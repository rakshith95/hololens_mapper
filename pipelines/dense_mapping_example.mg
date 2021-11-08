{
    "header": {
        "pipelineVersion": "2.2",
        "releaseVersion": "2021.1.0",
        "fileVersion": "1.1",
        "nodesVersions": {
            "KeyframeSelector": "0.1",
            "HoloLensMatcher": "0.1",
            "HololensPointcloudComposer": "0.1"
        }
    },
    "graph": {
        "HololensPointcloudComposer_1": {
            "nodeType": "HololensPointcloudComposer",
            "position": [
                327,
                18
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "9ec581b7dfdc6c6da24677dbc2057b6d71e687bd"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "recordingDir": "d:/local1/projects/artwin/datasets/2021_08_02__11_23_59_MUCLab_1",
                "UVfile": "d:/local1/projects/artwin/datasets/uvdata.txt",
                "verboseLevel": "info"
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/"
            }
        },
        "KeyframeSelector_1": {
            "nodeType": "KeyframeSelector",
            "position": [
                518,
                -60
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "14880f067a17587b2d7857e0bc2a218dee93563e"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "recordingDir": "{HololensPointcloudComposer_1.recordingDir}",
                "blurThreshold": 25.0,
                "minFrameOffset": 13,
                "copyCSVs": true,
                "verboseLevel": "info"
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/"
            }
        },
        "HoloLensMatcher_1": {
            "nodeType": "HoloLensMatcher",
            "position": [
                710,
                -63
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "703b07820d07b728c89ba50772cee067ca5dc2e7"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input": "{KeyframeSelector_1.output}",
                "algorithm": "SIFT",
                "clusteringRadius": 1,
                "matchingTreshold": 10,
                "verboseLevel": "info"
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/"
            }
        }
    }
}