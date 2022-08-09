{
    "header": {
        "pipelineVersion": "2.2",
        "releaseVersion": "2021.1.0",
        "fileVersion": "1.1",
        "nodesVersions": {
            "KeypointsDetector": "0.1",
            "Mapper": "0.1",
            "Matcher": "0.1",
            "HlocMapCreator": "0.1",
            "KeyframeSelector": "0.1"
        }
    },
    "graph": {
        "Matcher_1": {
            "nodeType": "Matcher",
            "position": [
                170,
                -61
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "d5d59f788d2469750af154c0923a1a6950b63087"
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
                62,
                173
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "b1a024845f87d2fc6c8f01483c3ace821fd22d96"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "recordingDir": "/local/datasets/davidTestDataset",
                "imageFolderNames": "/local/datasets/davidTestDataset/BlurringFolders",
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
        "HlocMapCreator_2": {
            "nodeType": "HlocMapCreator",
            "position": [
                550,
                -78
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "290a26b7cbbe6177dd9c20303037f00436078a5a"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "inputSfM": "{Mapper_1.output}",
                "imageDirectory": "{KeyframeSelector_1.output}",
                "imageFolderNames": "{KeyframeSelector_1.imageFolderNames}",
                "copyDensePts": false,
                "verboseLevel": "debug"
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/"
            }
        },
        "Mapper_1": {
            "nodeType": "Mapper",
            "position": [
                358,
                -61
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "442a0a4639141d2489cf7710a620b294e2649df8"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "databaseFile": "{Matcher_1.databaseOutputFile}",
                "imagesDirectory": "{KeyframeSelector_1.output}",
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
                -27,
                -37
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "9951730bb6c50aca1ee03feb35776d727b4bbd78"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "imagesFolder": "{KeyframeSelector_1.output}",
                "database": "",
                "algorithm": "SIFT",
                "removeImages": true,
                "verboseLevel": "info"
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/database.db"
            }
        }
    }
}