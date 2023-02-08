#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Feb  1 23:13:23 2023

@author: armsy326
"""

import os
import requests
import gensim
from gensim import matutils
import mysql.connector

"""connector  = mysql.connector.connect(
    host="localhost",
    user="root",
     password="Armstrong3-26",
     database='Hackathon' )
corpus  = [
    "0718358415 Armstrong nyagwencha onyango 19900223 male english",
    "0741235462 Fakii mohammed 18862322 male kiswahili ",
    "0721345412 Florence Ngina 20021223 female english",
    "0734567676 David Kamau neems 19900223 male english",
    "0712346578 Brian Breezy 19921203 male kiswahili"
    ]

mycursor  = connector.cursor()

mycursor.execute("SELECT firstname,surname,lastname,sex,language,datebirth FROM patient;")

for x in mycursor:
    string = ' '.join(x)

    corpus.append(string)
print(corpus)"""
#all_files  = os.listdir('/home/armsy326/Downloads')

#print(all_files)

file  = open("/home/armsy326/Pictures/al.jpg", mode='rb')

url = 'http://127.0.0.1:5000/patient/record'

data1 = {"firstname": "David", "surname": "Waweru","lastname": "Kamau", "sex": "male", "language": "English", "datebirth": "19901225"}

data = {"username": "Onyango", "sex": "male","datebirth": "19900326"}
res  = requests.post(url,json=data1)

if res.status_code == 200:
    print(res.json())
    #print("We did it")
    
else:
    
    print("You screwed!")
corpus  = []

#the following fucntion gets all 
"""def get_patients():

    #query all

    patients  = Patient.query.all()
    print(patients)
    for patient in patients:

        corpus.append(patient)

get_patients()"""

class DuplicationChecker(object):

    def __init__(self, query_user_info):

        self.query_user_info = query_user_info 

    def check_xerox(self):

        #preprocess the information bith incoming input and corpus

        input_preprocess = gensim.utils.simple_preprocess(self.query_user_info)

        corpus_preprocess = [gensim.utils.simple_preprocess(doc) for doc in corpus]

        #create a dictionary

        dictionary = gensim.corpora.Dictionary(corpus_preprocess)

        #create a bow model for both input and corpus

        input_bow  = dictionary.doc2bow(input_preprocess)

        corpus_bow  = [dictionary.doc2bow(doc) for doc in corpus_preprocess]


        #conver to tfidf , 1. we create the model that takes corpus_bow and the dictionary

        tfidf_model  =  gensim.models.TfidfModel(corpus_bow, dictionary=dictionary)

        #create tfidf for the sentence a list

        input_tfidf  = tfidf_model[input_bow]

        #create tfidf for the corpus bow

        corpus_tfidf  = tfidf_model[corpus_bow]

        #check for similarity.....a loop

        similarity  = [matutils.cossim(input_tfidf, doc) for doc in corpus_tfidf]

        #compare if it passes a particular threshold

        threshold  = 0.3

        filtered_sentence  = [doc for sim, doc in  zip(similarity, corpus) if sim >= threshold]

        print(filtered_sentence)

