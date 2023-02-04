#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Feb  1 22:45:44 2023

@author: armsy326
"""

import os
from flask import Flask, request
from flask_restful import Resource, Api
from model import text_files, fetch_present_files, process_incoming_file,process_present_files, get_similarity

app = Flask(__name__)

api = Api(app)


class File(Resource):
    
    
    def get(self):
        
        #return files
        
        all_files  = os.listdir('/home/armsy326/Download')
        
        return all_files
    
    def post(self):
        
        selected_file  = request.files['files']
        
        #check extension(support for .txt)
        fetch_present_files()
        #print(text_files)
        base, ext  = os.path.splitext(selected_file.filename)
        
        
        if ext == '.txt':
            
            for file in text_files:
                
                if selected_file.filename == file:
                    
                    return {"flag": 401, "feedback": "File exists"}
                else:
                    
                    selected_file.save(os.path.join('/home/armsy326/Xerox/X-Backend/process/documents/', selected_file.filename))
                    
            process_incoming_file(selected_file.filename)
            
            process_present_files()
            
            get_similarity()
            
            return {"flag": 201, "feedback": "File received"}
            
        else:
            
            return {"flag": 400, "feedback":"Uploaded file is not supported!"}
        
        
    
api.add_resource(File, '/upload/file')

if __name__ == '__main__':
    
    app.run(port=5000, debug=True)


