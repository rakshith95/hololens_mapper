{
    "header": {
        "pipelineVersion": "2.2",
        "releaseVersion": "2021.1.0",
        "fileVersion": "1.1",
        "nodesVersions": {
            "KeypointsDetector": "0.1",
            "KeyframeSelector": "0.1",
            "PoseFilter": "0.1",
            "Mapper": "0.1",
            "HlocMapCreator": "0.1",
            "ModelsAligner": "0.1",
            "Matcher": "0.1",
            "IOConvertor": "0.1"
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
                "0": "5964c01f82b859565f3bb2a87e7bab8fc3713efa"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "recordingDir": "/run/user/1000/gvfs/sftp:host=data.ciirc.cvut.cz,user=madharak/nfs/datasets/SPRING/ARI/3rd_floor_lab/VICON_exp/images/2",
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
                514,
                -289
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "c8d3056938a4f19505f5586b6d86ff5c8c18805c"
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
                "0": "5755d193372734a13a87629d007a8ed836ff4ba5"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "keyframesFolder": "{PoseFilter_1.output}",
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
                -255,
                -260
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "dc8c5b2263054259f440bb26ea238e254bd11c24"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "inputDir": "{KeyframeSelector_1.output}",
                "PoseFile": "/run/user/1000/gvfs/sftp:host=data.ciirc.cvut.cz,user=madharak/nfs/datasets/SPRING/ARI/3rd_floor_lab/VICON_exp/images/2/robot_pose.json",
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
                "0": "2833de7f1808c8896c97ecbd7cf5fbf936399e5f"
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
                "0": "6f7a187c0d1a684680fca38c8cd698f7e6bd0ff9"
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
                "0": "99c39466f79d0c84715958b3bb6f876a7ba4de61"
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
                "0": "d92af149aa1e2f67e89ccf5bf04f94064c724576"
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
        }
    }
}