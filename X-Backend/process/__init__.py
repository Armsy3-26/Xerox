#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Feb  1 22:45:44 2023

@author: armsy326
"""
import os
from flask import Flask,request
from datetime import datetime
from flask_restful import Resource,Api,marshal_with, fields
from flask_sqlalchemy import SQLAlchemy

app = Flask(__name__)

app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+mysqlconnector://root:Armstrong3-26@localhost/XEROX'

api = Api(app)
db = SQLAlchemy(app)

from process import records



    
    