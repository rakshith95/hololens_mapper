{
    "header": {
        "pipelineVersion": "2.2",
        "releaseVersion": "2021.1.0",
        "fileVersion": "1.1",
        "nodesVersions": {
            "FilterColmapSfM": "0.1",
            "DensePointcloudFilter": "0.1",
            "DensePonitcloudsAligner": "0.1",
            "PointcloudComposer": "0.1",
            "Texturing": "6.0",
            "ColmapMapper": "0.1",
            "ModelsAligner": "0.1",
            "Patchmatchnet": "0.1",
            "HoloLensIO": "0.1",
            "MatchingPairsSelector": "0.1",
            "ConvertSfMFormat": "2.1",
            "HoloLensMatcher": "0.1",
            "Meshing": "7.0",
            "MeshFiltering": "3.0",
            "KeyframeSelector": "0.1"
        }
    },
    "graph": {
        "DensePointcloudFilter_1": {
            "nodeType": "DensePointcloudFilter",
            "position": [
                57,
                124
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "87f8b9c8baeb06074d5ffe20f7c6b2ef9913894a"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "densePointcloud": "{PointcloudComposer_1.output}",
                "neighbourDistance": 0.05,
                "minNeighbours": 50,
                "verboseLevel": "info"
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}//model.obj"
            }
        },
        "HoloLensMatcher_1": {
            "nodeType": "HoloLensMatcher",
            "position": [
                583,
                -39
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "f21becf61588f868a241529948d2736f1a643135"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "colmapSfM": "{HoloLensIO_1.output}",
                "imagesFolder": "{KeyframeSelector_2.output}",
                "imagePairs": "{MatchingPairsSelector_1.output}",
                "algorithm": "SIFT",
                "clusteringRadius": 1,
                "matchingTreshold": 10,
                "verboseLevel": "info"
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/"
            }
        },
        "ColmapMapper_1": {
            "nodeType": "ColmapMapper",
            "position": [
                766,
                -13
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "45e1e197b44462ade387cfd90602a362e61f048d"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "colmapFolder": "{HoloLensMatcher_1.output}",
                "verboseLevel": "info"
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/"
            }
        },
        "ModelsAligner_1": {
            "nodeType": "ModelsAligner",
            "position": [
                965,
                7
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "da5dce289c016e5e0ec3d858b35f2c09d4e2190c"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "sfmTransform": "{ColmapMapper_1.output}",
                "sfmReference": "{HoloLensIO_1.output}",
                "verboseLevel": "info"
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/"
            }
        },
        "DensePonitcloudsAligner_1": {
            "nodeType": "DensePonitcloudsAligner",
            "position": [
                1387,
                87
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "ae8bbedb67b372ecbc6395174301e3584d1f20cf"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "inputPointcloud1": "{Patchmatchnet_1.outputPLY}",
                "inputPointcloud2": "{DensePointcloudFilter_1.output}",
                "alignmentMehod": "concatenation",
                "verboseLevel": "info"
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}//model.obj"
            }
        },
        "Texturing_1": {
            "nodeType": "Texturing",
            "position": [
                2589,
                -24
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "7998fe539b1ab20b7cfbaa76f4341d7abcec42d2"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "containerName": "{MeshFiltering_1.containerName}",
                "containerPrefix": "{MeshFiltering_1.containerPrefix}",
                "input": "{HoloLensIO_4.outputMeshroomSfM}",
                "imagesFolder": "",
                "inputMesh": "{MeshFiltering_1.outputMesh}",
                "inputRefMesh": "",
                "textureSide": 8192,
                "downscale": 2,
                "outputMeshFileType": "obj",
                "colorMapping": {
                    "enable": true,
                    "colorMappingFileType": "exr"
                },
                "bumpMapping": {
                    "enable": true,
                    "bumpType": "Normal",
                    "normalFileType": "exr",
                    "heightFileType": "exr"
                },
                "displacementMapping": {
                    "enable": true,
                    "displacementMappingFileType": "exr"
                },
                "unwrapMethod": "Basic",
                "useUDIM": true,
                "fillHoles": true,
                "padding": 5,
                "multiBandDownscale": 4,
                "multiBandNbContrib": {
                    "high": 1,
                    "midHigh": 5,
                    "midLow": 10,
                    "low": 0
                },
                "useScore": true,
                "bestScoreThreshold": 0.1,
                "angleHardThreshold": 90.0,
                "processColorspace": "sRGB",
                "correctEV": false,
                "forceVisibleByAllVertices": false,
                "flipNormals": false,
                "visibilityRemappingMethod": "PullPush",
                "subdivisionTargetRatio": 0.8,
                "verboseLevel": "info"
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/",
                "outputMesh": "{cache}/{nodeType}/{uid0}/texturedMesh.{outputMeshFileTypeValue}",
                "outputMaterial": "{cache}/{nodeType}/{uid0}/texturedMesh.mtl",
                "outputTextures": "{cache}/{nodeType}/{uid0}/texture_*.exr"
            }
        },
        "MeshFiltering_1": {
            "nodeType": "MeshFiltering",
            "position": [
                2378,
                -83
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "4b552306b23b35234dd47a08727481ec31bd734f"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "containerName": "{Meshing_2.containerName}",
                "containerPrefix": "{Meshing_2.containerPrefix}",
                "inputMesh": "{Meshing_2.outputMesh}",
                "outputMeshFileType": "obj",
                "keepLargestMeshOnly": false,
                "smoothingSubset": "all",
                "smoothingBoundariesNeighbours": 0,
                "smoothingIterations": 5,
                "smoothingLambda": 1.0,
                "filteringSubset": "all",
                "filteringIterations": 1,
                "filterLargeTrianglesFactor": 60.0,
                "filterTrianglesRatio": 0.0,
                "verboseLevel": "info"
            },
            "outputs": {
                "outputMesh": "{cache}/{nodeType}/{uid0}/mesh.{outputMeshFileTypeValue}"
            }
        },
        "FilterColmapSfM_1": {
            "nodeType": "FilterColmapSfM",
            "position": [
                1933,
                156
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "7ab2031f9169aa7854284b02a9d2dcfb33b12598"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "inputFolder": "{HoloLensIO_3.inputFolder}",
                "subsamplePoints3D": false,
                "numberOfPoints3D": 1000,
                "minNumberOfObservations": 50,
                "filterPV": false,
                "filterVLC": true,
                "cpoyImagesToOutput": true,
                "verboseLevel": "info"
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/"
            }
        },
        "Patchmatchnet_1": {
            "nodeType": "Patchmatchnet",
            "position": [
                1178,
                53
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "445b8403838f3d6bdb2e81d11df797e3239a86db"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "colmapFolder": "{ModelsAligner_1.output}",
                "verboseLevel": "info"
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/",
                "outputPLY": "{cache}/{nodeType}/{uid0}//fused.ply"
            }
        },
        "MatchingPairsSelector_1": {
            "nodeType": "MatchingPairsSelector",
            "position": [
                415,
                81
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "ce678425c82da86abe924511eb2cdd6b5c772bde"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "sfmFile": "{HoloLensIO_1.output}",
                "inputSfMFormat": "COLMAP",
                "outputSfMFormat": "COLMAP",
                "minCommonPts": 200,
                "verboseLevel": "info"
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}//image_pairs.txt"
            }
        },
        "PointcloudComposer_1": {
            "nodeType": "PointcloudComposer",
            "position": [
                -144,
                63
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 0,
                "split": 1
            },
            "uids": {
                "0": "64946ea31d91712726fa1f50c91e350083a7f7ec"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "recordingDir": "/local1/projects/artwin/datasets/LibrarySmall_Holo2",
                "recordingSource": "HoloLens2",
                "parameters": [],
                "verboseLevel": "info"
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}//model.obj"
            }
        },
        "HoloLensIO_1": {
            "nodeType": "HoloLensIO",
            "position": [
                242,
                32
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 5,
                "split": 1
            },
            "uids": {
                "0": "698acff16ce624933304c0094d1e25efde202d93"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "inputFolder": "{KeyframeSelector_2.output}",
                "pointcloudFile": "{DensePointcloudFilter_1.output}",
                "hashScale": 10,
                "allPoints": false,
                "intrinsics": [
                    {
                        "intrinsicId": 0,
                        "trackingFile": "pv",
                        "width": 1344,
                        "height": 756,
                        "pxFocalLength": {
                            "x": 1083.8628,
                            "y": 1082.8471
                        },
                        "principalPoint": {
                            "x": 665.5559,
                            "y": 400.5432
                        },
                        "distortionParams": [
                            -0.0168,
                            0.0044
                        ]
                    },
                    {
                        "intrinsicId": 1,
                        "trackingFile": "vlc_ll",
                        "width": 480,
                        "height": 640,
                        "pxFocalLength": {
                            "x": 449.2613,
                            "y": 449.2928
                        },
                        "principalPoint": {
                            "x": 249.9525,
                            "y": 304.7976
                        },
                        "distortionParams": [
                            -0.03371,
                            0.0236
                        ]
                    },
                    {
                        "intrinsicId": 2,
                        "trackingFile": "vlc_lf",
                        "width": 480,
                        "height": 640,
                        "pxFocalLength": {
                            "x": 458.5854,
                            "y": 454.1538
                        },
                        "principalPoint": {
                            "x": 233.5316,
                            "y": 324.1116
                        },
                        "distortionParams": [
                            -0.00717,
                            0.00725
                        ]
                    },
                    {
                        "intrinsicId": 3,
                        "trackingFile": "vlc_rf",
                        "width": 480,
                        "height": 640,
                        "pxFocalLength": {
                            "x": 460.7706,
                            "y": 456.1151
                        },
                        "principalPoint": {
                            "x": 257.1324,
                            "y": 320.1994
                        },
                        "distortionParams": [
                            -0.0102,
                            0.0194
                        ]
                    },
                    {
                        "intrinsicId": 4,
                        "trackingFile": "vlc_rr",
                        "width": 480,
                        "height": 640,
                        "pxFocalLength": {
                            "x": 445.7555,
                            "y": 445.6442
                        },
                        "principalPoint": {
                            "x": 240.7121,
                            "y": 313.0296
                        },
                        "distortionParams": [
                            -0.02997,
                            0.01758
                        ]
                    }
                ],
                "inputSfMFormat": "HoloLens2",
                "outputSfMFormat": [
                    "COLMAP"
                ],
                "cpoyImagesToOutput": false,
                "imagesPath": "original",
                "verboseLevel": "info"
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/",
                "outputMeshroomSfM": "{cache}/{nodeType}/{uid0}/meshroom_sfm.json"
            }
        },
        "DensePointcloudFilter_2": {
            "nodeType": "DensePointcloudFilter",
            "position": [
                1572,
                55
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "97c8f47c13456fdbaddf036dc217c3c6c4972e4c"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "densePointcloud": "{DensePonitcloudsAligner_1.output}",
                "neighbourDistance": 0.025,
                "minNeighbours": 30,
                "verboseLevel": "info"
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}//model.obj"
            }
        },
        "Meshing_2": {
            "nodeType": "Meshing",
            "position": [
                1988,
                -130
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "d6ec4c91bbce49de1ff9c4f28b3d72bbef622e16"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "containerName": "/local1/projects/artwin/mapping/hololens_mapper/alicevision.sif",
                "containerPrefix": "/opt/AliceVision_install/bin/",
                "input": "{HoloLensIO_3.outputMeshroomSfM}",
                "depthMapsFolder": "",
                "outputMeshFileType": "obj",
                "useBoundingBox": false,
                "boundingBox": {
                    "bboxTranslation": {
                        "x": 0.0,
                        "y": 0.0,
                        "z": 0.0
                    },
                    "bboxRotation": {
                        "x": 0.0,
                        "y": 0.0,
                        "z": 0.0
                    },
                    "bboxScale": {
                        "x": 1.0,
                        "y": 1.0,
                        "z": 1.0
                    }
                },
                "estimateSpaceFromSfM": true,
                "estimateSpaceMinObservations": 3,
                "estimateSpaceMinObservationAngle": 10,
                "maxInputPoints": 50000000,
                "maxPoints": 5000000,
                "maxPointsPerVoxel": 1000000,
                "minStep": 2,
                "partitioning": "singleBlock",
                "repartition": "multiResolution",
                "angleFactor": 15.0,
                "simFactor": 15.0,
                "pixSizeMarginInitCoef": 2.0,
                "pixSizeMarginFinalCoef": 4.0,
                "voteMarginFactor": 4.0,
                "contributeMarginFactor": 2.0,
                "simGaussianSizeInit": 10.0,
                "simGaussianSize": 10.0,
                "minAngleThreshold": 1.0,
                "refineFuse": true,
                "helperPointsGridSize": 10,
                "densify": false,
                "densifyNbFront": 1,
                "densifyNbBack": 1,
                "densifyScale": 20.0,
                "nPixelSizeBehind": 4.0,
                "fullWeight": 1.0,
                "voteFilteringForWeaklySupportedSurfaces": true,
                "addLandmarksToTheDensePointCloud": true,
                "invertTetrahedronBasedOnNeighborsNbIterations": 10,
                "minSolidAngleRatio": 0.2,
                "nbSolidAngleFilteringIterations": 2,
                "colorizeOutput": true,
                "addMaskHelperPoints": false,
                "maskHelperPointsWeight": 1.0,
                "maskBorderSize": 4,
                "maxNbConnectedHelperPoints": 50,
                "saveRawDensePointCloud": true,
                "exportDebugTetrahedralization": false,
                "seed": 0,
                "verboseLevel": "info"
            },
            "outputs": {
                "outputMesh": "{cache}/{nodeType}/{uid0}/mesh.{outputMeshFileTypeValue}",
                "output": "{cache}/{nodeType}/{uid0}/densePointCloud.abc",
                "outputRAW": "{cache}/{nodeType}/{uid0}/densePointCloud_raw.abc"
            }
        },
        "KeyframeSelector_2": {
            "nodeType": "KeyframeSelector",
            "position": [
                62,
                -10
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "d6369fdfa53c7a82e1b098e8a9f1b2155714154a"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "recordingDir": "{PointcloudComposer_1.recordingDir}",
                "recordingSource": "{PointcloudComposer_1.recordingSource}",
                "pvBlurThreshold": 15.0,
                "pvMinFrameOffset": 5,
                "vlcMinFrameOffset": 5,
                "verboseLevel": "info"
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/"
            }
        },
        "ConvertSfMFormat_3": {
            "nodeType": "ConvertSfMFormat",
            "position": [
                2197,
                28
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "92e66247b3d2b379d268c971d59bbe1246a12cee"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "containerName": "{Meshing_2.containerName}",
                "containerPrefix": "{Meshing_2.containerPrefix}",
                "input": "{Meshing_2.output}",
                "fileExt": "ply",
                "describerTypes": [
                    "sift",
                    "unknown"
                ],
                "imageWhiteList": [],
                "views": false,
                "intrinsics": false,
                "extrinsics": false,
                "structure": true,
                "observations": false,
                "verboseLevel": "info"
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/sfm.{fileExtValue}"
            }
        },
        "HoloLensIO_3": {
            "nodeType": "HoloLensIO",
            "position": [
                1751,
                -27
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 0,
                "split": 1
            },
            "uids": {
                "0": "8d847375647deacd905c08beab82f03fba57cfe2"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "inputFolder": "{ModelsAligner_1.output}",
                "pointcloudFile": "{DensePointcloudFilter_2.output}",
                "hashScale": 100,
                "allPoints": false,
                "intrinsics": [],
                "inputSfMFormat": "COLMAP",
                "outputSfMFormat": [
                    "OBJ",
                    "Meshroom"
                ],
                "cpoyImagesToOutput": true,
                "imagesPath": "container",
                "verboseLevel": "info"
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/",
                "outputMeshroomSfM": "{cache}/{nodeType}/{uid0}/meshroom_sfm.json"
            }
        },
        "HoloLensIO_4": {
            "nodeType": "HoloLensIO",
            "position": [
                2381,
                124
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 0,
                "split": 1
            },
            "uids": {
                "0": "e00e11a04694351ac255f826d105ba860ecfed85"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "inputFolder": "{FilterColmapSfM_1.output}",
                "pointcloudFile": "{ConvertSfMFormat_3.output}",
                "hashScale": 100,
                "allPoints": true,
                "intrinsics": [],
                "inputSfMFormat": "COLMAP",
                "outputSfMFormat": [
                    "Meshroom"
                ],
                "cpoyImagesToOutput": true,
                "imagesPath": "container",
                "verboseLevel": "info"
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/",
                "outputMeshroomSfM": "{cache}/{nodeType}/{uid0}/meshroom_sfm.json"
            }
        }
    }
}