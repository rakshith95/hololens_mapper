{
    "header": {
        "pipelineVersion": "2.2",
        "releaseVersion": "2021.1.0",
        "fileVersion": "1.1",
        "nodesVersions": {
            "ModelsAligner": "0.1",
            "PoseFilter": "0.1",
            "Mapper": "0.1",
            "HlocMapCreator": "0.1",
            "KeyframeSelector": "0.1",
            "IOConvertor": "0.1",
            "Matcher": "0.1",
            "KeypointsDetector": "0.1"
        }
    },
    "graph": {
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
                514,
                -289
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "9fc9f38bad8c5684fcbe21919cc93338c4f7586e"
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
                "0": "1af0a0b7ab8fa0087c053d56655b1d5f5c638f2e"
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
                "0": "7e8b59c886ddede1b84cfc0cacb7501ee03ea2d7"
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
                "0": "90e98ef1a6a235f2326612cd62c3790f94674cda"
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
                "0": "40cbffecb0860545d73d28f9c054d32d5f2c56fe"
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
                "0": "4dd741bb187883907a521cb9265a70fa38a6b972"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "inputDir": "{KeyframeSelector_1.output}",
                "imageFolderNames": "{KeyframeSelector_1.imageFolderNames}",
                "PoseFile": "/run/user/1000/gvfs/sftp:host=data.ciirc.cvut.cz,user=madharak/nfs/datasets/SPRING/ARI/Hloc_Broca_test/BrocaFrontRearFisheyeSubset/all_poses/combined_poses.json",
                "PoseFilter": true,
                "distanceThreshold": 0.15,
                "orientationThreshold": 30.0,
                "maxCamerasinPosition": 1,
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
                805,
                -297
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "5fca2f07520324010149905f8ca9cc5919e74246"
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