import sys
import os
import numpy as np
from numpy import True_, linalg
import sqlite3
sys.path.insert(1, '../../')
from src.utils.UtilsMath import UtilsMath

def load_images(colmap_imgs_file):
    utils_math = UtilsMath()
    images_list = []
    file_reader = open(colmap_imgs_file, 'r')
    data_lines = file_reader.read().split("\n")
    first_row = True
    for line in data_lines:
        if len(line) == 0:
            first_row = not first_row
            continue
        if line[0] == "#":
            continue

        p = line.split(" ")
        if first_row:
            if float(p[1]) == 1 and float(p[2]) == 0 and float(p[3]) == 0 and float(p[4]) == 0 \
                and float(p[5]) == 0 and float(p[6]) == 0 and float(p[7]) == 0:
                continue
            R = utils_math.q2r([float(p[1]), float(p[2]), float(p[3]), float(p[4])])
            C = - np.matrix(R).T * np.matrix([float(p[5]), float(p[6]), float(p[7])]).T
            img = {
                'image_id': int(p[0]),
                'camera_id': p[8],
                'R': R,
                'C': C,
                'name': p[9].replace('\\','/').replace('\/','/'),
                'uvs': [],
                'point3D_ids': []
            }
            first_row = False
        else:
            for ii in range(int(len(p) / 3)):
                img['uvs'].append(p[3 * ii])
                img['uvs'].append(p[3 * ii + 1])
                img['point3D_ids'].append(p[3 * ii + 2])
            images_list.append(img)
            first_row = True
            
    images_dict = {}
    for img in images_list:
        images_dict[int(img['image_id'])] = img

    return images_dict



images = load_images(sys.argv[1])
print(images[317].keys()         )
