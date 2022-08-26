import src.colmap.ColmapIO as colmap
import numpy as np 
import sys
from pathlib import Path 
import matplotlib.pyplot as plt


C = colmap.ColmapIO()
images_file1 = sys.argv[1]
images_file2 = sys.argv[2]


fig = plt.figure() # figure handle to be used later
fig.clf()
ax = fig.add_subplot(111, projection='3d')

images1 = C.load_images(images_file1)
images2 = C.load_images(images_file2)

images1_keys = list(images1.keys())
images2_keys = list(images2.keys())

names1 = np.asarray([images1[key]['name'] for key in images1_keys])
names2 = np.asarray([images2[key]['name'] for key in images2_keys])
common_names = np.intersect1d(names1, names2)

positions_1 = []
for key in images1_keys:
    img = images1[key]
    name = img['name']
    if name in common_names:
        camera_pos = np.asarray(img['C'])
        positions_1.append(camera_pos)
        

positions_2 = []
for key in images2_keys:
    img = images2[key]
    name = img['name']
    if name in common_names:
        camera_pos = np.asarray(img['C'])
        positions_2.append(camera_pos)


positions_1 = np.asarray(positions_1)
positions_2 = np.asarray(positions_2)

ax.scatter(positions_1[:,0],positions_1[:,1], positions_1[:,2],'+', color='red')
ax.scatter(positions_2[:,0],positions_2[:,1], positions_2[:,2],'+', color='blue')










plt.show()
