import json

targetFile = "package.json"

with open(targetFile, "r") as jsonFile:
    data = json.load(jsonFile)

if "type" in data:
    del data["type"]
data["relsolutions"] = {"mockery": "2.1.0"}
data["name"] = "webdriverio-autoinit"

with open(targetFile, "w") as jsonFile:
    json.dump(data, jsonFile, indent=2)
