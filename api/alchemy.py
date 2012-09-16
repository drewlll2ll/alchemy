from flask import Flask, request, abort
from mongoengine import *
from docParse import processDocuments
from models import *
import os

app = Flask(__name__)
app.config["MONGODB_DB"] = "alchemy"
app.config["SECRET_KEY"] = "(e%\+ydg$mtd&4wvzfmg-a*b@tfyz*1tn2ak(k+-&4q9=#&qpdq"

db = connect(app.config["MONGODB_DB"])

@app.route('/')
def index():
  return app.send_static_file('test.html')

@app.route('/login', methods=["POST"])
def login():
  app.logger.debug(str(request.form))
  if 'accessToken' in request.form and 'userID' in request.form:
      userID = request.form['userID']
      accessToken = request.form['accessToken']
      return 'success'
  abort(500)

@app.route('/getDocument', methods=["POST"])
def getDocument():
  pass

@app.route('/getSessions', methods=["POST"])
def getSessions():
  if not 'userID' in request.form:
    abort(400)
  else:
    user = Users.objects.get(userID_exact=request.form['userID'])
    #user.
  pass

@app.route('/getStatus', methods=["POST"])
def getStatus():
  pass

@app.route('/getGoals', methods=["POST"])
def getGoals():
  pass

@app.route('/updateStats', methods=["POST"])
def updateStats():
  pass

@app.route('/addDocument', methods=["POST"])
def addDocument():
  app.logger.debug(str(request.form))
  if not 'files' in request.form:
    abort(400)
  for document in request.form['files']:
    metadata = processDocuments(document['url'])
    doc = Paper(
      title = document['data']['filename'],
      FPUrl = document['url'])
    for keyword in metadata['keywords']:
      try:
        key = Keyword.objects(keyword__iexact=keyword['text'])
        key.indices.append()
      except:
        key = Keyword(
          indices = {document['data']['filename']: keyword['position']},
          keyword = keyword['text'],
          documents = [doc])
      key.save()
      doc.keywords.append(key)
    for concept in metadata['concepts']:
      con = concept(
        concept = concept['text'],
        documents = [doc])
      con.save()
      doc.concepts.append(con)
    doc.save()
  return success

@app.route('/static/<path:file_path>')
def static_fetch(file_path):
  return app.send_static_file(str(file_path))

if __name__ == '__main__':
  # Bind to PORT if defined, otherwise default to 5000.
  port = int(os.environ.get('PORT', 5000))
  app.run(host='0.0.0.0', port=port, debug=True)