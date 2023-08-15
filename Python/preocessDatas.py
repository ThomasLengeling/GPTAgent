import networkx as nx
import osmnx as ox
import taxicab as tc
import geopandas as gpd
import geocoder
import json
import time


with open('raw_agent.json', 'r') as f:
    file = json.loads(f.read())    

print(file['Agents']['Records'])
print()
print()
print()

newFile = {}
newFile['Records'] = []
for index, one_agnet in enumerate(file['Agents']['Records']):
    tmpArray = []

    tmp = {}
    tmp['Day Schedule'] = {}

    for item in one_agnet['ConvertedDayActivities']:
        ttmp = {}
        ttmp['Time'] = item['Time']
        ttmp['Activity'] = item['Activity']
        ttmp['Address'] = item['Location']
        ttmp['Transportation'] = 'walk'

        tmpArray.append(ttmp)

    tmp['Day Schedule']['Activities'] = tmpArray

    newFile['Records'].append(tmp)



with open('pre_agent.json', 'w') as f:
    json.dump(newFile, f)

print(json.dumps((newFile)))
