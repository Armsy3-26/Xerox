#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Feb  1 22:45:44 2023

@author: armsy326
"""

import os
from flask import Flask, request
from flask_restful import Resource, Api

app = Flask(__name__)

api = Api(app)


class File(Resource):
    
    
    def get(self):
        
        #return files
        
        all_files  = os.listdir('/home/armsy326/Download')
        
        return all_files
    
    def post(self):
        
        file  = request.files['files']
        
        #check extension(support for .txt)
        print(file.filename)
        base, ext  = os.path.splitext(file.filename)
        
        file.save(os.path.join('/home/armsy326/Xerox/X-Backend/', file.filename))
        
        if ext == '.txt':
            
            print("Do magic buddy")
            
            return {"flag": 201, "feedback": "File received"}
            
        else:
            
            return {"flag": 400, "feedback":"Uploaded file is not supported!"}
        
        
    
api.add_resource(File, '/upload/file')

if __name__ == '__main__':
    
    app.run(port=5000, debug=True)


