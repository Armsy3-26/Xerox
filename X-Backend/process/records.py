#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Feb  1 22:45:44 2023

@author: armsy326
"""
import os
from flask import request
from flask_restful import Resource,fields
from datetime import datetime
from process import db,api,app
from model import  DuplicationChecker,get_student_record,get_duplicates
from alpha_model import AlphaDuplicationChecker, get_schools,get_student_records,get_alpha_duplicates


class Student(db.Model):

    __tablename__  = 'student'
    
    id  = db.Column(db.Integer, primary_key=True, autoincrement=True)
    firstname  = db.Column(db.String(10))
    surname   = db.Column(db.String(10), )
    lastname  = db.Column(db.String(10))
    bc    = db.Column(db.String(18))
    schoolname  = db.Column(db.String(30))
    datebirth = db.Column(db.String(16))
    #accountNo  = db.Column(db.BigInteger)
    
    
    def __repr__(self):
        
        return f"{self.firstname} {self.surname} "
    
    
with app.app_context():
    
    db.create_all()

class SchoolResource(Resource):

    def get(self):

        schools = []

        existing_schools = Student.query.with_entities(Student.schoolname).all()
        
        schoolnames = [school[0] for school in existing_schools]

        return {"success": True, "schools": {"schools": list(set(schoolnames))}}



class DuplicateResource(Resource):
    
    def get(self,key):
        try:
            #get data passed as query parameters
            # automatically assume we checking for duplicates
            # check the existence of the school

            start_time = datetime.now()

            school = Student.query.filter_by(schoolname=key).first()

            if school:

                # we begin to extract/ check for duplicates
                # get the stedent records, need to pass in schoolname
                total_records = get_student_record(school.schoolname)

                # next we check for duplicates
                duplicates = get_duplicates()

                end_time = datetime.now()

                time_difference  = end_time - start_time
                search_duration = f"{time_difference.total_seconds()*1000:.2f}"

                return {
                    "total_records": total_records, 
                    "unique_records": total_records - len(duplicates), 
                    "possible_duplicates": len(duplicates), 
                    "get_duplicate": duplicates,
                    "search_duration": search_duration,
                    "results_for": school.schoolname
                    }
        except Exception as e:
            print(e)
        
    
    def post(self,key):
        
        try:
            data   = request.get_json(force=True)

            insert_student  = Student(
                firstname=data['firstname'], 
                surname=data['surname'],
                lastname=data['lastname'],
                bc=data['bc'], 
                schoolname = data['schoolname'],
                datebirth=data['datebirth'],
                )

            db.session.add(insert_student)

            db.session.commit()
            
            return {"flag": 201, "feedback":"You have been successfully registered!"}
                

        except Exception as e:
           
            return {"flag": 400, "feedback": "Error occured try after sometime!"}
    
    def delete(self,key):
        
        delete_field = Student.query.filter_by().first()

        db.session.delete(delete_field)

        db.session.commit()

        return "Deleted successfully!"
    
class AlphaDuplicateResource(Resource):

    def get(self):

        start_time = datetime.now()
       
        # automatically assume we checking for duplicates
        

        # we begin to extract/ check for duplicates
        #get all schools, essential for mapping
        get_schools()
        # get the student records
        total_records = get_student_records()

        # next we check for duplicates
        duplicates = get_alpha_duplicates()

        end_time = datetime.now()

        search_duration = f"{(end_time - start_time).total_seconds()*1:.2f}"

        return {
            "total_records": total_records, 
            "unique_records": total_records - len(duplicates), 
            "possible_duplicates": len(duplicates), 
            "get_duplicate": duplicates,
            "search_duration": search_duration,
            "results_for": "All schools"
            }

    
    
api.add_resource(DuplicateResource, '/student/record/<string:key>')
api.add_resource(SchoolResource, '/schools')
api.add_resource(AlphaDuplicateResource, '/engine2/alpha')