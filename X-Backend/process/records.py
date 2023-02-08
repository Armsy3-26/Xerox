#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Feb  1 22:45:44 2023

@author: armsy326
"""
import os
from flask import request
from flask_restful import Resource,marshal_with, fields
from process import db,api,app
from model import  DuplicationChecker,get_patient_record


class Patient(db.Model):
    
    id  = db.Column(db.Integer, primary_key=True, autoincrement=True)
    firstname  = db.Column(db.String(10))
    surname   = db.Column(db.String(10), )
    lastname  = db.Column(db.String(10))
    sex    = db.Column(db.String(8))
    language  = db.Column(db.String(12))
    datebirth = db.Column(db.String(16))
    #accountNo  = db.Column(db.BigInteger)
    
    
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
    "datebirth": fields.String
}

class PatientField(Resource):
    
    @marshal_with(patient_information)
    def get(self):
        #get data passed as query parameters

        username = request.args.get('username')
        sex  = request.args.get('sex')
        datebirth = request.args.get('datebirth')
        
        user1_info = Patient.query.filter_by(firstname=username, datebirth=datebirth, sex=sex).all()
       
        if user1_info == []:
            
            user2_info = Patient.query.filter_by(surname=username, datebirth=datebirth, sex=sex).all()

            if user2_info == []:
                user3_info = Patient.query.filter_by(lastname=username, datebirth=datebirth, sex=sex).all()

                return user3_info

            return user2_info
        

        return user1_info
    
    
    def post(self):
        
        try:
            data   = request.get_json(force=True)
            
            username  = data['username']
            
            sex  = data['sex']
            language  = data['language']
            datebirth = data['datebirth']
            
            try:
                
                firstname,surname,lastname = username.split()
                
                query_user_info = f"{firstname} {surname} {lastname} {sex} {language} {datebirth}"
                
                user = DuplicationChecker(query_user_info)

                get_patient_record()

                feedback = user.check_xerox()

                if feedback['flag'] == 204:

                    return {"flag": "203", "feedback":"possible duplicate", "payload": feedback['feedback']}

                else:
                    insert_patient  = Patient(firstname=firstname, surname=surname,lastname=lastname, sex=sex, language=language,datebirth=datebirth)

                    db.session.add(insert_patient)

                    db.session.commit()
                    get_patient_record()
                    return {"flag": 201, "feedback":"You have been successfully registered!"}
                
            except Exception as e:
                
                if e.__class__.__name__ == "ValueError":
                    try:
                        firstname,surname = username.split()
                        query_user_info = f"{firstname} {surname} {sex} {language} {datebirth}"
                        
                        user = DuplicationChecker(query_user_info)

                        get_patient_record()

                        feedback = user.check_xerox()

                        if feedback['flag'] == 204:

                            return {"flag": "203", "feedback":"possible duplicate", "payload": feedback['feedback']}

                        else:
                            insert_patient  = Patient(firstname=firstname, surname=surname, sex=sex, language=language,datebirth=datebirth)

                            db.session.add(insert_patient)

                            db.session.commit()
                            get_patient_record()
                            return {"flag": 201, "feedback":"You have been successfully registered!"}
                        
                    except Exception as e:
                        
                        if e.__class__.__name__ == "ValueError":
                            firstname = username.split()
                            query_user_info = f"{firstname[0]} {sex} {language} {datebirth}"
                            
                            user = DuplicationChecker(query_user_info)

                            get_patient_record()

                            feedback = user.check_xerox()

                            if feedback['flag'] == 204:

                                return {"flag": "203", "feedback":"possible duplicate", "payload": feedback['feedback']}

                            else:
                                insert_patient  = Patient(firstname=firstname, surname=surname,lastname=lastname, sex=sex, language=language,datebirth=datebirth)

                                db.session.add(insert_patient)

                                db.session.commit()
                                get_patient_record()
                                return {"flag": 201, "feedback":"You have been successfully registered!"}
            
            query_user_info = f"{firstname} {surname} {lastname} {sex} {language} {datebirth}"
            
            user = DuplicationChecker(query_user_info)

            get_patient_record()

            feedback = user.check_xerox()

            if feedback['flag'] == 204:

                return {"flag": "203", "feedback":"possible duplicate", "payload": feedback['feedback']}

            else:
                insert_patient  = Patient(firstname=firstname, surname=surname,lastname=lastname, sex=sex, language=language,datebirth=datebirth)

                db.session.add(insert_patient)

                db.session.commit()
                get_patient_record()
                return {"flag": 201, "feedback":"You have been successfully registered!"}

        except Exception as e:
            print(e)
            return {"flag": 400, "feedback": "Error occured try after sometime!"}
    
    def delete(self):
        
        delete_field = Patient.query.filter_by().first()

        db.session.delete(delete_field)

        db.session.commit()

        return "Deleted successfully!"
    
    
api.add_resource(PatientField, '/patient/record')