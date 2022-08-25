import json
from pathlib import Path 
import sys

try:
    jsons_folder = Path(sys.argv[1])
except:
    jsons_folder = Path(".")

combined_file = jsons_folder.joinpath('combined_poses.json')
jsons_list = jsons_folder.glob('*.json')  
jsons_list = [x for x in jsons_list if x.is_file()]
all_poseData = []
for json_file in jsons_list:
    f = open(str(json_file))
    poseData = json.load(f)
    all_poseData = all_poseData  + poseData

with open(combined_file, 'w') as fout:
    json.dump(all_poseData, fout)
