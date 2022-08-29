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
                "0": "035a144d705232682720da5c21d2624737171c39"
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
                "0": "596b93a21ca139e38cdb6b6443962837cbee649e"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "imageDir": "True",
                "images": [],
                "hlocMapDir": "/home/rakshith/CTU/ARI/SPRING/hololens_mapper/pipelines/MeshroomCache/HlocMapCreator/353dc066c00f66805f9041d8bb5a5d798d6b686b",
                "queryImageDir": "/run/user/1000/gvfs/sftp:host=data.ciirc.cvut.cz,user=madharak/nfs/datasets/SPRING/ARI/ARI_AprDataCollection_BROCA/rosbags&images/14AprExtractedImages/query_loc",
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