{
    "header": {
        "pipelineVersion": "2.2",
        "releaseVersion": "2021.1.0",
        "fileVersion": "1.1",
        "nodesVersions": {
            "ModelsAligner": "0.1",
            "IOConvertor": "0.1",
            "PoseFilter": "0.1",
            "KeyframeSelector": "0.1",
            "KeypointsDetector": "0.1",
            "Mapper": "0.1",
            "Matcher": "0.1",
            "HlocMapCreator": "0.1"
        }
    },
    "graph": {
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
                "0": "87e5119705d830a22fed4ccc4766134287998c1f"
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
                -449,
                -249
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "80f19820b527bab5cb8e61cfe81837bd4f48913f"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "recordingDir": "/run/user/1000/gvfs/sftp:host=data.ciirc.cvut.cz,user=madharak/nfs/datasets/SPRING/ARI/Hloc_Broca_test/BrocaFrontRearFisheyeSubset",
                "imageFolderNames": "/run/user/1000/gvfs/sftp:host=data.ciirc.cvut.cz,user=madharak/nfs/datasets/SPRING/ARI/Hloc_Broca_test/BrocaFrontRearFisheyeSubset/allImagesFolders",
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
                525,
                -291
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "f55d69f359a378efd95ad00fe4341145a0aac9c8"
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
                15,
                -260
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "5ead1b8004d0c05940b7d3ad3f5fc0afd5954951"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "imagesFolder": "{PoseFilter_1.output}",
                "database": "",
                "algorithm": "SIFT",
                "removeImages": true,
                "verboseLevel": "info"
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/database.db"
            }
        },
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
                "0": "bbea6fb12fe3ae251744e5ae200de4b74fd5740c"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "keyframesFolder": "{KeyframeSelector_1.output}",
                "inputFolder": "",
                "pointcloudFile": "",
                "PosesFile": "/run/user/1000/gvfs/sftp:host=data.ciirc.cvut.cz,user=madharak/nfs/datasets/SPRING/ARI/Hloc_Broca_test/BrocaFrontRearFisheyeSubset/all_poses/combined_poses.json",
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
        "PoseFilter_1": {
            "nodeType": "PoseFilter",
            "position": [
                -207,
                -249
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "3996474776cf5080fdfb382695c6df4fb4c1201b"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "inputDir": "{KeyframeSelector_1.output}",
                "PoseFile": "/run/user/1000/gvfs/sftp:host=data.ciirc.cvut.cz,user=madharak/nfs/datasets/SPRING/ARI/Hloc_Broca_test/BrocaFrontRearFisheyeSubset/all_poses/combined_poses.json",
                "PoseFilter": true,
                "distanceThreshold": 0.1,
                "orientationThreshold": 30.0,
                "maxCamerasinPosition": 3,
                "imageType": "jpg",
                "verboseLevel": "info"
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/"
            }
        },
        "HlocMapCreator_2": {
            "nodeType": "HlocMapCreator",
            "position": [
                771,
                -296
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "af7ce4577dbcd3d9bd9e39d419151a172ece12c8"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "inputSfM": "{ModelsAligner_1.output}",
                "imageDirectory": "{Mapper_1.imagesDirectory}",
                "imageFolderNames": "",
                "copyDensePts": false,
                "verboseLevel": "debug"
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/"
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
                "0": "2c7c97a16fac278a4714c4419adda92c149316db"
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
                "ransacInlierThreshold": 0.1
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/",
                "transforedPts": "{cache}/{nodeType}/{uid0}/model.obj"
            }
        }
    }
}