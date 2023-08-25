import json

targetFile = "tsconfig.json"

with open(targetFile, "r") as jsonFile:
    data = json.load(jsonFile)

data["compilerOptions"]["resolveJsonModule"] = True
data["compilerOptions"]["esModuleInterop"] = True
data["compilerOptions"]["target"] = "ESNext"
data["include"] = ["features"]

if "module" in data["compilerOptions"]:
    del data["compilerOptions"]["module"]

if "allowImportingTsExtensions" in data["compilerOptions"]:
    del data["compilerOptions"]["allowImportingTsExtensions"]


with open(targetFile, "w") as jsonFile:
    json.dump(data, jsonFile, indent=2)
