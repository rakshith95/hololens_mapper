{
    "header": {
        "pipelineVersion": "2.2",
        "releaseVersion": "2021.1.0",
        "fileVersion": "1.1",
        "nodesVersions": {
            "HlocLocalizer": "0.1",
            "HlocQueryComposer": "0.1"
        }
    },
    "graph": {
        "HlocLocalizer_1": {
            "nodeType": "HlocLocalizer",
            "position": [
                576,
                -25
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "864fafcb545420ed5f88016f67c6eb84a4da5d0f"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "hlocMapDir": "{HlocQueryComposer_1.hlocMapDir}",
                "queryFile": "{HlocQueryComposer_1.output}",
                "localSfM": "",
                "imagesRig": false,
                "copyDensePts": false,
                "verboseLevel": "debug"
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/",
                "image_pairs": "{cache}/{nodeType}/{uid0}/image_pairs.txt",
                "localization": "{cache}/{nodeType}/{uid0}/query_localization_results.txt",
                "densePts": "{cache}/{nodeType}/{uid0}/model.obj"
            }
        },
        "HlocQueryComposer_1": {
            "nodeType": "HlocQueryComposer",
            "position": [
                372,
                -29
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "37de4633f07037ab81453de04d1f626c5bbd50de"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "imageDir": "True",
                "images": [],
                "hlocMapDir": "/home/rakshith/CTU/ARI/SPRING/hololens_mapper/pipelines/MeshroomCache/HlocMapCreator/577b6b00a40ab862f98621d8c4f6d55ffc6866b3",
                "queryImageDir": "/run/user/1000/gvfs/sftp:host=data.ciirc.cvut.cz,user=madharak/nfs/datasets/SPRING/ARI/3rd_floor_lab/VICON_exp/images/5/query",
                "sameCamera": "True",
                "intrinsics": [
                    {
                        "cameraModel": "OPENCV_FISHEYE",
                        "width": 3264,
                        "height": 2448,
                        "params": "1163.017863035068  1163.017863035068  1659.485709363832  1267.526731256599  -0.04087365163363622  -0.003741100324305693  0  0  -0.0008322767702335206  0  0  0"
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