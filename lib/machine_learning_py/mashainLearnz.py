from havenondemand.hodclient import *

client = HODClient("d028225e-f3d7-49ce-b431-c2d769602f1f", version="v1")


def train(filePath):
    param = {}
    csvFile = readFile(filePath)
    param["file"] = csvFile
    param["predicted_field"] = "characteristics"
    param["service_name"] = "subject prediction"
    hodapp = HODApps.TRAINPREDICT
    res = client.post_request(param, hodapp, Async=True, **arg)
    result = client.get_job_result(res["jobID"])


def predict(filePath):
    param = {}
    csvFile = readFile(filePath)
    param["file"] = csvFile
    param["service_name"] = "subject prediction"
    hodapp = HODApps.PREDICT
    res = client.post_request(param, hodapp, Async=True, **arg)
    result = client.get_job_result(res["jobID"])


def recommended(filePath):
    param = {}
    csvFile = readFile(filePath)
    param["file"] = csvFile
    param["service_name"] = "subject prediction"
    param["required_label"] = "characteristics"
    hodapp = HODApps.RECOMMEND
    res = client.post_request(param, hodapp, Async=True, **arg)
    result = client.get_job_result(res["jobID"])


def readFile(path):
    return open(path).read()
