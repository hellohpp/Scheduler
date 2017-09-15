from flask import Flask

app = Flask(__name__)

@app.route("/login", methods=['POST'])
def login():
	'''
		Write login logic and return true or false if credentials accepted.  Flask example as follows:
		dat = {
			'id':request.json['id'],
			'name':request.json['name'],
			'title':request.json['title']
		}
		empDB.append(dat)
		return jsonify(dat)
	'''
	
if __name__ == "__main__":
    app.run()