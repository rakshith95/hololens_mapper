{
    "header": {
        "pipelineVersion": "2.2",
        "releaseVersion": "2021.1.0",
        "fileVersion": "1.1",
        "nodesVersions": {
            "HlocQueryComposer": "0.1",
            "HlocLocalizer": "0.1"
        }
    },
    "graph": {
        "HlocLocalizer_1": {
            "nodeType": "HlocLocalizer",
            "position": [
                734,
                -235
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "9cc57b8a9b47863ff4e0bba0220b48df9dcef956"
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
        "HlocQueryComposer_1": {
            "nodeType": "HlocQueryComposer",
            "position": [
                490,
                -181
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "0a03cbe8c2ef75891a8e92df29099191a7c5de96"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "imageDir": "True",
                "images": [],
                "hlocMapDir": "/home/rakshith/CTU/ARI/SPRING/hololens_mapper/pipelines/MeshroomCache/HlocMapCreator/cb38a7ee3d1fd576f9b53d1bb19db7aae5818a39\r\n",
                "queryImageDir": "/run/user/1000/gvfs/sftp:host=data.ciirc.cvut.cz,user=madharak/nfs/datasets/SPRING/ARI/Hloc_Broca_test/davidTestDataset/query_images\r\n",
                "sameCamera": "True",
                "intrinsics": [
                    {
                        "cameraModel": "OPENCV_FISHEYE",
                        "width": 3264,
                        "height": 2448,
                        "params": "1641.1408855177621268.860231236379  1160.443656680554  1160.443656680554  -0.03972002553691897  -0.005903976921644  -2.732007574613631e-05  0"
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