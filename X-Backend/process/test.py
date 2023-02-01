#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Feb  1 23:13:23 2023

@author: armsy326
"""

import os
import requests

#all_files  = os.listdir('/home/armsy326/Downloads')

#print(all_files)

file  = open("/home/armsy326/Pictures/al.jpg", mode='rb')

url = 'http://127.0.0.1:5000/upload/file'

data = {"data", 'data'}

res  = requests.post(url, files = {"files": file})

if res.status_code == 200:
    
    print("We did it")
    
else:
    
    print("YOu screwed!")