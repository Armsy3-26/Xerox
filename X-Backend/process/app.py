#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Feb  1 22:45:44 2023

@author: armsy326
"""
import os
from flask import Flask,request
from flask_restful import Resource,Api,marshal_with, fields
from flask_sqlalchemy import SQLAlchemy

app = Flask(__name__)

app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+mysqlconnector://root:Armstrong3-26@localhost/AliXe'

api = Api(app)
db = SQLAlchemy(app)

class Patient(db.Model):
    
    id  = db.Column(db.Integer, primary_key=True, autoincrement=True)
    firstname  = db.Column(db.String(10))
    surname   = db.Column(db.String(10), )
    lastname  = db.Column(db.String(10))
    sex    = db.Column(db.String(8))
    language  = db.Column(db.String(12))
    datebirth = db.Column(db.DATETIME)
    
    
    def __repr__(self):
        
        return f"{self.firstname} {self.surname} "
    
    
with app.app_context():
    
    db.create_all()
    
patient_information = {
    "firstname": fields.String,
    "surname": fields.String,
    "lastname": fields.String,
    "sex": fields.String,
    "language": fields.String,
    "datebirth": fields.DateTime
}
class PatientField(Resource):
    
    @marshal_with(patient_information)
    def get(self):
        
        
        user_info = Patient.query.filter_by().first(firstname="", datebirth="").first()

        return user_info
    
    
    def post(self):
        
        try:
            data   = request.get_json(force=True)
            
            firstname  = data['firstname']
            surname  = data['surnaname']
            lastname  = data['lastname']
            sex  = data['sex']
            language  = data['language']
            datebirth = data['datebirth']
            
            
            insert_patient  = Patient(firstname=firstname, surname=surname,lastname=lastname, sex=sex, language=language,datebirth=datebirth)

            db.add(insert_patient)

            db.commit()
        
            return {"flag": 201, "feedback":"posted successfully"}

        except Exception:

            return {"flag": 400, "feedback": "Error occured try again!"}
    
    def delete(self):
        
        delete_field = Patient.query.filter_by().first()

        db.delete(delete_field)

        db.commit()

        return "Deleted successfully!"
    
    
api.add_resource(PatientField, '/patient/record')
    
    