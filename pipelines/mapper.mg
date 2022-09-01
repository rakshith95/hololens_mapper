{
    "header": {
        "pipelineVersion": "2.2",
        "releaseVersion": "2021.1.0",
        "fileVersion": "1.1",
        "nodesVersions": {
            "KeypointsDetector": "0.1",
            "Mapper": "0.1",
            "HlocMapCreator": "0.1",
            "PoseFilter": "0.1",
            "KeyframeSelector": "0.1",
            "IOConvertor": "0.1",
            "ModelsAligner": "0.1",
            "Matcher": "0.1"
        }
    },
    "graph": {
        "IOConvertor_1": {
            "nodeType": "IOConvertor",
            "position": [
                191,
                32
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 0,
                "split": 1
            },
            "uids": {
                "0": "e9fe22074fda75aca9cf5a95d9d5e1807ea9c0fe"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "keyframesFolder": "{PoseFilter_1.output}",
                "inputFolder": "",
                "pointcloudFile": "",
                "PosesFile": "{PoseFilter_1.PoseFile}",
                "hashScale": 1,
                "renderScale": 1,
                "allPoints": false,
                "intrinsics": [],
                "inputSfMFormat": "ORB-SLAM",
                "outputSfMFormat": [
                    "COLMAP"
                ],
                "copyImagesToOutput": false,
                "convertImgsToJpeg": false,
                "imagesPath": "original",
                "verboseLevel": "info"
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/",
                "outputMeshroomSfM": "{cache}/{nodeType}/{uid0}/meshroom_sfm.json",
                "lQueryFile": "{cache}/{nodeType}/{uid0}/hloc_queries.txt",
                "densePts": "{cache}/{nodeType}/{uid0}/model.obj"
            }
        },
        "ModelsAligner_1": {
            "nodeType": "ModelsAligner",
            "position": [
                631,
                -38
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "072b93a269c45d9480257f8774868c6c158327e9"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "sfmTransform": "{Mapper_1.output}",
                "ptsTransform": "",
                "sfmReference": "{IOConvertor_1.output}",
                "alignerType": [
                    "sfm"
                ],
                "verboseLevel": "info",
                "RANSAC": false,
                "ransacInlierThreshold": 0.01
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/",
                "transforedPts": "{cache}/{nodeType}/{uid0}/model.obj"
            }
        },
        "Matcher_1": {
            "nodeType": "Matcher",
            "position": [
                267,
                -291
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "f88ddc57384e4d0cfd80b769edc85b8235273a70"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "databaseFile": "{KeypointsDetector_1.output}",
                "inputMatchesFormat": "no data",
                "inputMatches": "",
                "algorithm": "COLMAP",
                "matchingType": "Sequential",
                "vocabTree": "/home/rakshith/CTU/ARI/SPRING/hololens_mapper/vocab_tree_flickr100K_words32K.bin",
                "matchingTreshold": 2,
                "verboseLevel": "info"
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/",
                "databaseOutputFile": "{cache}/{nodeType}/{uid0}/database.db"
            }
        },
        "KeypointsDetector_1": {
            "nodeType": "KeypointsDetector",
            "position": [
                15,
                -260
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "426a9b54edf7a63d7a8d665963890d289b8d6d75"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "imagesFolder": "{PoseFilter_1.output}",
                "database": "",
                "algorithm": "SIFT",
                "cameraModel": "OPENCV_FISHEYE",
                "removeImages": true,
                "verboseLevel": "info"
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/database.db"
            }
        },
        "PoseFilter_1": {
            "nodeType": "PoseFilter",
            "position": [
                -255,
                -260
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "5b4580d3d462d1ced3d328a77da5bd00df7bb04d"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "inputDir": "{KeyframeSelector_1.output}",
                "imageFolderNames": "{KeyframeSelector_1.imageFolderNames}",
                "PoseFile": "{KeyframeSelector_1.PoseFile}",
                "PoseFilter": true,
                "distanceThreshold": 0.1,
                "orientationThreshold": 30.0,
                "maxCamerasinPosition": 1,
                "imageType": "jpg",
                "verboseLevel": "info"
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/"
            }
        },
        "Mapper_1": {
            "nodeType": "Mapper",
            "position": [
                514,
                -289
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "3cac17517549ae3995c350d57f6e7ca2ca5c8cb4"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "databaseFile": "{Matcher_1.databaseOutputFile}",
                "imagesDirectory": "{KeypointsDetector_1.imagesFolder}",
                "algorithm": "COLMAP",
                "ignoreTwoView": true,
                "verboseLevel": "info"
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/"
            }
        },
        "KeyframeSelector_1": {
            "nodeType": "KeyframeSelector",
            "position": [
                -505,
                -262
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "0b1fb9e97a9912ebb86c7ae1d5a431d9afac06a1"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "recordingDir": "/run/user/1000/gvfs/sftp:host=data.ciirc.cvut.cz,user=madharak/nfs/datasets/SPRING/ARI/3rd_floor_lab/VICON_exp/images/2",
                "imageFolderNames": "/run/user/1000/gvfs/sftp:host=data.ciirc.cvut.cz,user=madharak/nfs/datasets/SPRING/ARI/3rd_floor_lab/VICON_exp/images/2/ImageFolders",
                "PoseFile": "/run/user/1000/gvfs/sftp:host=data.ciirc.cvut.cz,user=madharak/nfs/datasets/SPRING/ARI/3rd_floor_lab/VICON_exp/images/2/robot_pose.json",
                "recordingSource": "BROCA",
                "pvBlurThreshold": 40.0,
                "pvMinFrameOffset": 0,
                "vlcMinFrameOffset": 0,
                "verboseLevel": "debug"
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/"
            }
        },
        "HlocMapCreator_2": {
            "nodeType": "HlocMapCreator",
            "position": [
                805,
                -297
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "2d3c6efa38eab2eb73270adffbc68e910c121ce1"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "inputSfM": "{ModelsAligner_1.output}",
                "imageDirectory": "{Mapper_1.imagesDirectory}",
                "imageFolderNames": "{PoseFilter_1.imageFolderNames}",
                "copyDensePts": false,
                "verboseLevel": "debug"
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/"
            }
        }
    }
}