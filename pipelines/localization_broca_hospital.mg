{
    "header": {
        "pipelineVersion": "2.2",
        "releaseVersion": "2021.1.0",
        "fileVersion": "1.1",
        "nodesVersions": {
            "HlocLocalizer": "0.1",
            "HlocMapCreator": "0.1",
            "KeyframeSelector": "0.1",
            "KeypointsDetector": "0.1",
            "Mapper": "0.1",
            "Matcher": "0.1",
            "HlocQueryComposer": "0.1"
        }
    },
    "graph": {
        "Matcher_1": {
            "nodeType": "Matcher",
            "position": [
                312,
                -89
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "b60c56a982640559e53e4958e2a08d595f424084"
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
                46,
                11
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "e90648d11d7544097b38bfa02f084196ab6030c6"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "recordingDir": "/run/user/1000/gvfs/sftp:host=data.ciirc.cvut.cz,user=madharak/nfs/datasets/SPRING/ARI/Hloc_Broca_test/davidTestDataset",
                "imageFolderNames": "/run/user/1000/gvfs/sftp:host=data.ciirc.cvut.cz,user=madharak/nfs/datasets/SPRING/ARI/Hloc_Broca_test/davidTestDataset/BlurringFolders",
                "recordingSource": "BROCA",
                "pvBlurThreshold": 25.0,
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
                538,
                -234
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "5e937a192b6b3e574e01ff194a253271397f913c"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "databaseFile": "{Matcher_1.databaseOutputFile}",
                "imagesDirectory": "",
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
                90,
                -231
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "127ef75ca57c261c6dce94858b784665964c8b36"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "imagesFolder": "",
                "database": "",
                "algorithm": "SIFT",
                "removeImages": true,
                "verboseLevel": "info"
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/database.db"
            }
        },
        "HlocLocalizer_1": {
            "nodeType": "HlocLocalizer",
            "position": [
                1127,
                163
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "a5d68870a2e61015f2e507f66c7e33e4e8ad7a3c"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "hlocMapDir": "{HlocQueryComposer_1.hlocMapDir}",
                "queryFile": "{HlocQueryComposer_1.output}",
                "localSfM": "",
                "imagesRig": false,
                "copyDensePts": false,
                "verboseLevel": "info"
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/",
                "image_pairs": "{cache}/{nodeType}/{uid0}/image_pairs.txt",
                "localization": "{cache}/{nodeType}/{uid0}/query_localization_results.txt",
                "densePts": "{cache}/{nodeType}/{uid0}/model.obj"
            }
        },
        "HlocMapCreator_1": {
            "nodeType": "HlocMapCreator",
            "position": [
                731,
                196
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "5cf2b5fba03d79893cd6fa9dd688f1fe60ed65c8"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "inputSfM": "/local1/projects/artwin/mapping/hololens_mapper/pipelines/MeshroomCache/IOConvertor/194fe1cddf09dcbf237ce61a6e9e247be8345bb8",
                "imageDirectory": "",
                "imageFolderNames": "",
                "copyDensePts": false,
                "verboseLevel": "info"
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/"
            }
        },
        "HlocLocalizer_2": {
            "nodeType": "HlocLocalizer",
            "position": [
                1257,
                -271
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "bf2dc69f4eabfdc1761924e155441b5e5ec1fd9b"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "hlocMapDir": "{HlocQueryComposer_2.hlocMapDir}",
                "queryFile": "{HlocQueryComposer_2.output}",
                "localSfM": "",
                "imagesRig": false,
                "copyDensePts": false,
                "verboseLevel": "info"
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/",
                "image_pairs": "{cache}/{nodeType}/{uid0}/image_pairs.txt",
                "localization": "{cache}/{nodeType}/{uid0}/query_localization_results.txt",
                "densePts": "{cache}/{nodeType}/{uid0}/model.obj"
            }
        },
        "HlocMapCreator_2": {
            "nodeType": "HlocMapCreator",
            "position": [
                787,
                -237
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "c196fa1899b013c0ed1fc353c8d3b2d14359eaa5"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "inputSfM": "{Mapper_1.output}",
                "imageDirectory": "",
                "imageFolderNames": "",
                "copyDensePts": false,
                "verboseLevel": "debug"
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/"
            }
        },
        "HlocQueryComposer_2": {
            "nodeType": "HlocQueryComposer",
            "position": [
                1008,
                -254
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "3c4e2bae6f80bfe8cdd536417da2271a8a55b381"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "imageDir": true,
                "images": [],
                "hlocMapDir": "{HlocMapCreator_2.output}",
                "queryImageDir": "/local/datasets/davidTestDataset/query_images",
                "sameCamera": "True",
                "intrinsics": [
                    {
                        "cameraModel": "OPENCV_FISHEYE",
                        "width": 3264,
                        "height": 2448,
                        "params": "1.1886892840742685e+03 1.1893016496137716e+03 1.6319484444597201e+03 1.2428175443297432e+03 -6.5074864654844314e-02 2.2948182911307041e-02 -3.9319897787193784e-03 -3.7411424922587362e-03"
                    }
                ],
                "verboseLevel": "info"
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/hloc_queries.txt"
            }
        },
        "HlocQueryComposer_1": {
            "nodeType": "HlocQueryComposer",
            "position": [
                929,
                203
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "76bd77285e54a4d43c7c19262e04a022dd95a3b5"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "imageDir": "True",
                "images": [],
                "hlocMapDir": "{HlocMapCreator_1.output}",
                "queryImageDir": "/local/datasets/LocalizationQueryExample/images",
                "sameCamera": "True",
                "intrinsics": [
                    {
                        "cameraModel": "RADIAL",
                        "width": 760,
                        "height": 428,
                        "params": "585.7 376.3103 196.7361 0.0028 -0.0125"
                    }
                ],
                "verboseLevel": "info"
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/hloc_queries.txt"
            }
        }
    }
}