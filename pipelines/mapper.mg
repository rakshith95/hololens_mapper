{
    "header": {
        "pipelineVersion": "2.2",
        "releaseVersion": "2021.1.0",
        "fileVersion": "1.1",
        "nodesVersions": {
            "KeypointsDetector": "0.1",
            "PoseFilter": "0.1",
            "KeyframeSelector": "0.1",
            "Mapper": "0.1",
            "Matcher": "0.1",
            "HlocMapCreator": "0.1"
        }
    },
    "graph": {
        "Matcher_1": {
            "nodeType": "Matcher",
            "position": [
                220,
                -261
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "a2e1ca67530db13d2a2e613f967955b8ba6bd32b"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "databaseFile": "{KeypointsDetector_1.output}",
                "inputMatchesFormat": "no data",
                "inputMatches": "",
                "algorithm": "COLMAP",
                "matchingTreshold": 2,
                "verboseLevel": "info"
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/",
                "databaseOutputFile": "{cache}/{nodeType}/{uid0}/database.db"
            }
        },
        "KeyframeSelector_1": {
            "nodeType": "KeyframeSelector",
            "position": [
                -421,
                -242
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "02885abb4b9f48d6e77f0d77d1549f84fff3f196"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "recordingDir": "/run/user/1000/gvfs/sftp:host=data.ciirc.cvut.cz,user=madharak/nfs/datasets/SPRING/ARI/3rd_floor_lab/VICON_exp/images/5",
                "imageFolderNames": "/run/user/1000/gvfs/sftp:host=data.ciirc.cvut.cz,user=madharak/nfs/datasets/SPRING/ARI/3rd_floor_lab/VICON_exp/images/2/ImageFolders",
                "recordingSource": "BROCA",
                "pvBlurThreshold": 32.0,
                "pvMinFrameOffset": 0,
                "vlcMinFrameOffset": 0,
                "verboseLevel": "debug"
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/"
            }
        },
        "Mapper_1": {
            "nodeType": "Mapper",
            "position": [
                407,
                -219
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "11dddfd7d80b246bf27f43ab6edf4c0369a9758c"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "databaseFile": "{Matcher_1.databaseOutputFile}",
                "imagesDirectory": "{KeypointsDetector_1.imagesFolder}",
                "algorithm": "COLMAP",
                "verboseLevel": "info"
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/"
            }
        },
        "KeypointsDetector_1": {
            "nodeType": "KeypointsDetector",
            "position": [
                -3,
                -250
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "54ce6f3248651a0cdc315000225380e050d04f80"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "imagesFolder": "{PoseFilter_1.inputDir}",
                "database": "",
                "algorithm": "SIFT",
                "removeImages": true,
                "verboseLevel": "info"
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/database.db"
            }
        },
        "HlocMapCreator_2": {
            "nodeType": "HlocMapCreator",
            "position": [
                625,
                -231
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "577b6b00a40ab862f98621d8c4f6d55ffc6866b3"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "inputSfM": "{Mapper_1.output}",
                "imageDirectory": "{Mapper_1.imagesDirectory}",
                "imageFolderNames": "",
                "copyDensePts": false,
                "verboseLevel": "debug"
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/"
            }
        },
        "PoseFilter_1": {
            "nodeType": "PoseFilter",
            "position": [
                -221,
                -221
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "fd5dae44e6ccbd3d9320e2a9de28c37228638011"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "inputDir": "{KeyframeSelector_1.output}",
                "PoseFile": "/run/user/1000/gvfs/sftp:host=data.ciirc.cvut.cz,user=madharak/nfs/datasets/SPRING/ARI/3rd_floor_lab/VICON_exp/images/5/robot_pose.json",
                "PoseFilter": true,
                "distanceThreshold": 0.33,
                "orientationThreshold": 45.0,
                "maxCamerasinPosition": 2,
                "imageType": "jpg",
                "verboseLevel": "info"
            },
            "outputs": {}
        }
    }
}