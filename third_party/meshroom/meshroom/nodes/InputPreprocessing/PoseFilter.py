from __future__ import print_function
from itertools import count

__version__ = "0.1"

from meshroom.core import desc
import glob
import os
import sys
import numpy as np


dir_path = __file__
for i in range(6):
    dir_path = os.path.dirname(dir_path)
sys.path.append(dir_path)
from src.holo.HoloIO import HoloIO
from src.holo.HoloIO2 import HoloIO2
from src.utils.UtilsKeyframes import UtilsKeyframes
from pathlib import Path
import shutil
import copy
import math
from tqdm import tqdm as tqdm
class PoseFilter(desc.Node):
    category = 'Input Preprocessing'
    documentation = '''
    This node select subset of images (keyframes) by poses and copy them to output path. 

    '''
    inputs = [
        desc.File(
            name="inputDir",
            label="Input Folder",
            description="Input folder with the keyframes",
            value="",
            uid=[0]
        ),
        desc.File(
            name="PoseFile",
            label="Pose file",
            description="Input pose file json",
            value="",
            uid=[0]
        ),
        desc.BoolParam(
            name='PoseFilter', 
            label='Pose filter',
            description='Remove images in the same grid by the robot poses if.',
            value=True,
            uid=[]
        ),  
        desc.FloatParam(
            name='distanceThreshold',
            label='Distance Threshold',
            description='Minimum distance below which, if an image already exists, new image will be discarded',
            value=0.15,
            range=None,
            uid=[]
        ),
        desc.FloatParam(
            name='orientationThreshold',
            label='Orientation Threshold',
            description='Minimum orientation threshold, in degrees, below which, if an image already exists, new image will be discarded',
            value=10,
            range=None,
            uid=[]
        ),
        desc.IntParam(
            name='maxCamerasinPosition',
            label='Max cameras',
            description='The maximum number of cameras allowed within the distance, and orientation threshold',
            value=2,
            range=(0, 100, 1),
            uid=[0],
            ),            

        desc.StringParam(
            name='imageType',
            label='Image type',
            description='jpg or png',
            value='jpg',
            uid=[]
        ),
        desc.ChoiceParam(
            name='verboseLevel',
            label='Verbose Level',
            description='''verbosity level (critical, error, warning, info, debug).''',
            value='info',
            values=['critical', 'error', 'warning', 'info', 'debug'],
            exclusive=True,
            uid=[],
            )
        ]

    outputs = [
        desc.File(
            name="output",
            label="Output Folder",
            description="",
            value=desc.Node.internalFolder,
            uid=[],
            ),
    ]

    def quaternion_multiply(self, quaternion1, quaternion0):
        w0, x0, y0, z0 = quaternion0
        w1, x1, y1, z1 = quaternion1
        return np.array([-x1 * x0 - y1 * y0 - z1 * z0 + w1 * w0,
                        x1 * w0 + y1 * z0 - z1 * y0 + w1 * x0,
                        -x1 * z0 + y1 * w0 + z1 * x0 + w1 * y0,
                        x1 * y0 - y1 * x0 + z1 * w0 + w1 * z0], dtype=np.float64)

    def euler_from_quaternion(self, q):
            """
            Convert a quaternion into euler angles (roll, pitch, yaw)
            roll is rotation around x in radians (counterclockwise)
            pitch is rotation around y in radians (counterclockwise)
            yaw is rotation around z in radians (counterclockwise)
            """
            w,x,y,z = q
            t0 = +2.0 * (w * x + y * z)
            t1 = +1.0 - 2.0 * (x * x + y * y)
            roll_x = math.atan2(t0, t1)
        
            t2 = +2.0 * (w * y - z * x)
            t2 = +1.0 if t2 > +1.0 else t2
            t2 = -1.0 if t2 < -1.0 else t2
            pitch_y = math.asin(t2)
        
            t3 = +2.0 * (w * z + x * y)
            t4 = +1.0 - 2.0 * (y * y + z * z)
            yaw_z = math.atan2(t3, t4)
        
            return roll_x, pitch_y, yaw_z # in radians
    
    def get_closest_index(self, query, times):
        diff = np.abs(times - query)
        min_ind = np.argmin(diff)
        return min_ind

    def processChunk(self, chunk):
        try:
            chunk.logManager.start(chunk.node.verboseLevel.value)

            inputFolder = None
            outputFolder = Path(chunk.node.output.value)
            if not chunk.node.inputDir:
                chunk.logger.error('Nothing to process')
                return

            inputFolder = Path(chunk.node.inputDir.value)
            chunk.logger.info('Filter frames by their poses')
            images = inputFolder.glob('*.'+chunk.node.imageType.value)
            images = [x for x in images if x.is_file()]
            
            seen_orientations = []

            if chunk.node.PoseFilter.value == True:
                assert os.path.isfile(chunk.node.PoseFile.value), "Poses file not found"
                poseFile = Path(chunk.node.PoseFile.value)
                filetype = poseFile.suffix
                assert filetype == ".json", "Incorrect file type for poses file"
                import json
                f = open(str(poseFile))

                poseData = json.load(f)
                times = np.asarray([data['time'] for data in poseData], dtype=np.longlong )

                seen_positions = None
                seen_orientations = []
                num_seen = [0]
                
                for image in tqdm(images):
                    image_timestamp = int(image.name.split('.')[0])
                    closest_timestamp_index = self.get_closest_index(image_timestamp, times)
                    approx_image_position_by_timestamp = np.asarray(poseData[closest_timestamp_index]['position']).reshape((3,1))
                    approx_image_orientation_by_timestamp = poseData[closest_timestamp_index]['orientation']
                    if seen_positions is None:
                        seen_positions = copy.deepcopy(approx_image_position_by_timestamp)
                        seen_orientations.append(approx_image_orientation_by_timestamp)
                        num_seen[0] = 1
                    else:
                        diff = seen_positions - approx_image_position_by_timestamp
                        dists = np.linalg.norm(diff, axis=0)
                        min_dist_ind = np.argmin(dists)

                        # Compute orientation diff
                        q1_inv = [0]*4
                        q2 = [0]*4 
                        
                        # REVERSE FOR ROS ANNOYING CONVENTION
                        q1_inv[3] = seen_orientations[min_dist_ind][0]
                        q1_inv[2] = seen_orientations[min_dist_ind][1]
                        q1_inv[1] = seen_orientations[min_dist_ind][2]
                        q1_inv[0] = -seen_orientations[min_dist_ind][3] # Negate for inverse

                        q2[3] = approx_image_orientation_by_timestamp[0]
                        q2[2] = approx_image_orientation_by_timestamp[1]
                        q2[1] = approx_image_orientation_by_timestamp[2]
                        q2[0] = approx_image_orientation_by_timestamp[3]

                        relative_orientation_quat = self.quaternion_multiply(q2, q1_inv)
                        relative_orientation_euler_deg = np.rad2deg( self.euler_from_quaternion(relative_orientation_quat) )
                        if dists[min_dist_ind] <= chunk.node.distanceThreshold.value and np.linalg.norm(relative_orientation_euler_deg) <= chunk.node.orientationThreshold.value:
                            num_seen[min_dist_ind] += 1
                            if num_seen[min_dist_ind] >= chunk.node.maxCamerasinPosition.value:
                                continue
            
                        # chunk.logger.info("Copy image "+image.name)
                        shutil.copy(image, outputFolder.joinpath(image.name)) 
                        seen_positions = np.append(seen_positions, approx_image_position_by_timestamp, axis=1)
                        seen_orientations.append(approx_image_orientation_by_timestamp)
                        num_seen.append(1)

        except AssertionError as err:
            chunk.logger.error("Error in PoseFilter: " + err)
        finally:
            chunk.logManager.end()
