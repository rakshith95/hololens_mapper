from __future__ import print_function

__version__ = "0.1"

from meshroom.core import desc
import shutil
import glob
import os
import os.path 
import sys
from pathlib import Path
from shutil import copy2

# import mapper packages
dir_path = __file__
for i in range(6):
    dir_path = os.path.dirname(dir_path)
sys.path.append(dir_path)
from src.colmap.Colmap import Colmap
from src.utils.UtilsContainers import UtilsContainers
from src.holo.HoloIO import HoloIO

class ColmapMapper(desc.Node):

    category = 'ARTwin'
    documentation = '''
This node COLMAP mapper on database which contains matches.
'''

    inputs = [
        desc.File(
            name="colmapFolder",
            label="Colmap folder",
            description="The directory containing input database.db and images.",
            value="",
            uid=[0],
        ),
        desc.ChoiceParam(
            name='verboseLevel',
            label='Verbose Level',
            description='''verbosity level (critical, error, warning, info, debug).''',
            value='info',
            values=['critical', 'error', 'warning', 'info', 'debug'],
            exclusive=True,
            uid=[],
            ),
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

    def processChunk(self, chunk):
        try:
            chunk.logManager.start(chunk.node.verboseLevel.value)
            
            if not chunk.node.colmapFolder:
                chunk.logger.warning('COLMAP directory is missing.')
                return
            if not chunk.node.output.value:
                return

            # copy required resources
            out_dir = chunk.node.output.value
            holo_io = HoloIO()
            holo_io.copy_sfm_images(chunk.node.colmapFolder.value, out_dir)
            copy2(chunk.node.colmapFolder.value + '/database.db', out_dir)

            # run standard matching
            chunk.logger.info('Init COLMAP container')
            if sys.platform == 'win32':
                out_dir = out_dir[0].lower() + out_dir[1::]
                colmap_container = UtilsContainers("docker", "uodcvip/colmap", "/host_mnt/" + out_dir.replace(":",""))
            else:
                colmap_container = UtilsContainers("singularity", dir_path + "/colmap.sif", out_dir)
            colmap = Colmap(colmap_container)
            
            colmap.mapper("/data/database.db", "/data", "/data")

            # create txt files out of the largest reconstruction
            if os.path.isdir(out_dir + '/0'):
                colmap.model_converter('/data/0','/data','TXT')

            chunk.logger.info('Mapper done.')
          
        except AssertionError as err:
            chunk.logger.error("Error in keyframe selector: " + err)
        finally:
            chunk.logManager.end()
