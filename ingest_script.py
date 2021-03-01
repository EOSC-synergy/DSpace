import requests
import json
from requests_toolbelt.multipart.encoder import MultipartEncoder
import configparser

#ENV
USER = 'test@test.edu'
PASS = 'admin'
HOST = "dspace.ifca.es"
PORT = "8080"

with open('local.cfg') as f:
    file_content = '[dummy_section]\n' + f.read()

config_parser = configparser.RawConfigParser()
config_parser.read_string(file_content)

url = config_parser['dummy_section']['dspace.server.url']

#LOGIN

data = {'email': USER, 'password': PASS}
resp = requests.post(url + '/api/authn/login?user=%s&password=%s' % (USER,PASS))
print(url + '/api/authn/login?user=%s&password=%s' % (USER,PASS))
headers = resp.headers

#Login status
resp = requests.get(url + '/api/authn/status', headers=headers)

resp_json = json.loads(resp.content)
print(resp_json)

#Create Test community
#headers['Content-type'] = 'multipart/form-data'
#headers['Accept'] = 'application/json, text/plain, */*'

#community_data = {"type":{"value":"community"},"metadata":{"dc.title":[{"value":"Test community"}],"dc.description":[{}],"dc.description.abstract":[{"value":"Tests"}],"dc.rights":[{}],"dc.description.tableofcontents":[{}]}}


#community_data = {"type":{"value":"community"},"metadata":{"dc.title":[{"language":null,"value":"CURL"}],"dc.description":[{"language":null}],"dc.description.abstract":[{"language":null,"value":"curl test"}],"dc.rights":[{"language":null}],"dc.description.tableofcontents":[{"language":null}]}}
#resp = requests.post(url + '/api/core/communities', headers=headers, cookies=cookies, data=community_data)

#Get community
resp = requests.get(url + '/api/core/community', headers=headers)
resp_json = json.loads(resp.content)
community_id = "bc6aa7d3-f7cc-40e1-ba66-5b8e9b5fb03d"

#New item
#resp = requests.post('http://dspace.ifca.es:8080/server/api/submission/workspaceitems?projection=full&owningCollection=bc6aa7d3-f7cc-40e1-ba66-5b8e9b5fb03d', headers=headers)
#print(resp.content)


payload={'name': 'AMT'}
files=[
  ('file',('test.pdf',open('test.pdf','rb'),'application/pdf'))
]
headers = {
  'Authorization': 'Bearer' + headers['Authorization']
}

resp = requests.request("POST", url + '/api/submission/workspaceitems?projection=full&owningCollection=' + community_id, headers=headers, data=payload, files=files)

resp_json = json.loads(resp.content)
print("\n###### UPLOAD ######\n")
print(resp_json)

item_id = resp_json['_embedded']['workspaceitems'][0]['id']

metadata = [
    {"op":"add","path":"/sections/traditionalpageone/dc.title","value":[{"value":"Deployment Test","display":"Deployment Test","confidence":-1,"place":0}]},
    {"op":"add","path":"/sections/traditionalpageone/dc.date.issued","value":[{"value":"2021","display":"2021","confidence":-1,"place":0}]},
    {"op":"add","path":"/sections/traditionalpageone/dc.date.issued","value":[{"value":"2021-02","display":"2021-02","confidence":-1,"place":0}]},
    {"op":"add","path":"/sections/traditionalpageone/dc.date.issued","value":[{"value":"2021-02-26","display":"2021-02-26","confidence":-1,"place":0}]},
    {"op":"add","path":"/sections/license/granted","value":"true"}
]

resp = requests.request("PATCH", url + '/api/submission/workspaceitems/%i' % item_id, headers=headers, json=metadata)
print("\n#### METADATA #########\n")
resp_json = json.loads(resp.content)
print(resp_json)
item_url = resp_json['_embedded']['item']['_links']['self']['href']
#https://dspace-labs.github.io/DSpace7RestTutorial/exercise5

#Complete submission

headers['Content-Type'] = "text/uri-list"
data = url + "/api/submission/workspaceitems/%i" % item_id
resp = requests.request("POST", url + '/api/workflow/workflowitems?projection=full', headers=headers, data=data)
print(resp.text)


# Get Metadata
resp = requests.get(item_url, headers=headers)

items = json.loads(resp.content)
pid = items['metadata']['dc.identifier.uri'][0]['value']
print("PID = %s" % pid)
#TODO
pid = "http://193.146.75.184:4000" + pid[pid.rfind('/handle'):None]

#FAIR check
print("\n######### FAIR Checking ##########\n")
body = json.dumps({'id': pid, 'repo': 'dspace_7'})
url = 'http://dspace-fair:9090/v1.0/rda/all'
result = requests.post(url, data = body, headers={'Content-Type': 'application/json'})
print(result.content)
