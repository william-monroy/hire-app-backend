import os
from flask import Flask, jsonify
from flask_sqlalchemy import SQLAlchemy
from flask_marshmallow import Marshmallow
# from flask_cors import CORS

app = Flask(__name__)
# CORS(app)

# pymysql error: https://stackoverflow.com/questions/22252397/importerror-no-module-named-mysqldb
app.config['SQLALCHEMY_DATABASE_URI'] = "mysql://root:Fg3F8L38kV85mqz1GY8k@containers-us-west-42.railway.app:7755/railway"
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

db = SQLAlchemy(app)
ma = Marshmallow(app)

#MODELOS
class Administrator(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    fname = db.Column(db.String(255), nullable=False)
    lname = db.Column(db.String(255), nullable=False)
    age = db.Column(db.Date)
    email = db.Column(db.String(255), nullable=False)
    phoneNumber = db.Column(db.String(20), nullable=False)
    passwordHash = db.Column(db.String(300), nullable=False)
    candidates = db.relationship("Candidate", back_populates="administrator")

    def __init__(self, id, fname, lname, age, email, phoneNumber, passwordHash):
        self.id = id
        self.fname = fname
        self.lname = lname
        self.age = age
        self.email = email
        self.phoneNumber = phoneNumber
        self.passwordHash = passwordHash

class Candidate(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    fname = db.Column(db.String(255), nullable=False)
    lname = db.Column(db.String(255), nullable=False)
    age = db.Column(db.Date)
    email = db.Column(db.String(255), nullable=False)
    phoneNumber = db.Column(db.String(20), nullable=False)
    passwordHash = db.Column(db.String(300), nullable=False)
    # Foreign Key
    idAdministrator = db.Column(db.Integer, db.ForeignKey('administrator.id'))
    # administrator = db.relationship("Administrator", backref="candidates")
    administrator = db.relationship("Administrator", back_populates="candidates")
    test1 = db.relationship("Test1", back_populates="candidate", uselist=False)
    test2 = db.relationship("Test2", back_populates="candidate", uselist=False)
    test3 = db.relationship("Test3", back_populates="candidate", uselist=False)

    def __init__(self, id, fname, lname, age, email, phoneNumber, passwordHash, idAdministrator):
        self.id = id
        self.fname = fname
        self.lname = lname
        self.age = age
        self.email = email
        self.phoneNumber = phoneNumber
        self.passwordHash = passwordHash
        self.idAdministrator = idAdministrator

class Test1(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    answer1 = db.Column(db.Integer, nullable=False)
    answer2 = db.Column(db.Integer, nullable=False)
    answer3 = db.Column(db.Integer, nullable=False)
    answer4 = db.Column(db.Integer, nullable=False)
    answer5 = db.Column(db.Integer, nullable=False)
    answer6 = db.Column(db.Integer, nullable=False)
    idCandidate = db.Column(db.Integer, db.ForeignKey('candidate.id'))
    candidate = db.relationship("Candidate", back_populates="test1")

    def __init__(self, id, answer1, answer2, answer3, answer4, answer5, answer6, idCandidate):
        self.id = id
        self.answer1 = answer1
        self.answer2 = answer2
        self.answer3 = answer3
        self.answer4 = answer4
        self.answer5 = answer5
        self.answer6 = answer6
        self.idCandidate = self.idCandidate

class Test2(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    answer1 = db.Column(db.Integer, nullable=False)
    answer2 = db.Column(db.Integer, nullable=False)
    answer3 = db.Column(db.Integer, nullable=False)
    answer4 = db.Column(db.Integer, nullable=False)
    answer5 = db.Column(db.Integer, nullable=False)
    idCandidate = db.Column(db.Integer, db.ForeignKey('candidate.id'))
    candidate = db.relationship("Candidate", back_populates="test2")

    def __init__(self, id, answer1, answer2, answer3, answer4, answer5, idCandidate):
        self.id = id
        self.answer1 = answer1
        self.answer2 = answer2
        self.answer3 = answer3
        self.answer4 = answer4
        self.answer5 = answer5
        self.idCandidate = self.idCandidate

class Test3(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    answer1 = db.Column(db.Integer, nullable=False)
    answer2 = db.Column(db.Integer, nullable=False)
    answer3 = db.Column(db.Integer, nullable=False)
    answer4 = db.Column(db.Integer, nullable=False)
    answer5 = db.Column(db.Integer, nullable=False)
    answer6 = db.Column(db.Integer, nullable=False)
    idCandidate = db.Column(db.Integer, db.ForeignKey('candidate.id'))
    candidate = db.relationship("Candidate", back_populates="test3")

    def __init__(self, id, answer1, answer2, answer3, answer4, answer5, answer6, idCandidate):
        self.id = id
        self.answer1 = answer1
        self.answer2 = answer2
        self.answer3 = answer3
        self.answer4 = answer4
        self.answer5 = answer5
        self.answer6 = answer6
        self.idCandidate = self.idCandidate

# SCHEMAS
class AdministratorSchema(ma.SQLAlchemyAutoSchema):
    class Meta:
        model =  Administrator
        include_fk = True

class CandidateSchema(ma.SQLAlchemyAutoSchema):
    class Meta:
        model =  Candidate
        include_fk = True

class Test1Schema(ma.SQLAlchemyAutoSchema):
    class Meta:
        model =  Test1
        include_fk = True

class Test2Schema(ma.SQLAlchemyAutoSchema):
    class Meta:
        model =  Test2
        include_fk = True

class Test3Schema(ma.SQLAlchemyAutoSchema):
    class Meta:
        model =  Test3
        include_fk = True

# ROUTES
@app.route("/administrator")
def index_administrator():
    administradores = Administrator.query.all()
    administrador_schema = AdministratorSchema(many=True)
    output = administrador_schema.dump(administradores)
    return jsonify({"datos": output})

@app.route("/candidate")
def index_candidate():
    candidates = Candidate.query.all()
    candidate_schema = CandidateSchema(many=True)
    output = candidate_schema.dump(candidates)
    return jsonify({"datos": output})

@app.route("/test1")
def index_test1():
    tests1 = Test1.query.all()
    test1_schema = Test1Schema(many=True)
    output = test1_schema.dump(tests1)
    return jsonify({"datos": output})

@app.route("/test2")
def index_test2():
    tests2 = Test2.query.all()
    test2_schema = Test2Schema(many=True)
    output = test2_schema.dump(tests2)
    return jsonify({"datos": output})

@app.route("/test3")
def index_test3():
    tests3 = Test2.query.all()
    test3_schema = Test3Schema(many=True)
    output = test3_schema.dump(tests3)
    return jsonify({"datos": output})

if __name__ == '__main__':
    app.run(debug=True, port=os.getenv("PORT", default=5000))
