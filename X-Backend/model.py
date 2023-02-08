#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Feb  2 12:32:33 2023

@author: armsy326
"""

import os
import gensim
from gensim import matutils
import mysql.connector

database  = mysql.connector.connect(
    host = "localhost",
    user="root",
    password = "Armstrong3-26",
    database = "Hackathon",
)
mycursor  = database.cursor()

#will be fetched from the database
corpus  = []

def get_patient_record():
        corpus.clear()
        mycursor.execute("SELECT firstname,surname,lastname,sex,datebirth FROM patient")
        for data in mycursor:
            print(data)
            string_record = ' '.join(data)

            corpus.append(string_record)

class DuplicationChecker(object):

    def __init__(self, query_user_info):

        self.query_user_info = query_user_info 

    def check_xerox(self):

        try:

            #preprocess the information bith incoming input and corpus

            input_preprocess = gensim.utils.simple_preprocess(self.query_user_info)

            corpus_preprocess = [gensim.utils.simple_preprocess(doc) for doc in corpus]

            #create a dictionary

            dictionary = gensim.corpora.Dictionary(corpus_preprocess)

            #create a bow model for both input and corpus

            input_bow  = dictionary.doc2bow(input_preprocess)

            corpus_bow  = [dictionary.doc2bow(doc) for doc in corpus_preprocess]


            #convert to tfidf , 1. we create the model that takes corpus_bow and the dictionary

            tfidf_model  =  gensim.models.TfidfModel(corpus_bow, dictionary=dictionary)

            #create tfidf for the sentence a list

            input_tfidf  = tfidf_model[input_bow]

            #create tfidf for the corpus bow

            corpus_tfidf  = tfidf_model[corpus_bow]

            #check for similarity.....a loop

            similarity  = [matutils.cossim(input_tfidf, doc) for doc in corpus_tfidf]

            #compare if it passes a particular threshold

            threshold  = 0.3

            filtered_users  = [doc for sim, doc in  zip(similarity, corpus) if sim >= threshold]

            if filtered_users == []:

                return {"flag": 202, "feedback": "No duplicate, registering patient..."}

            else:

                return {"flag": 204, "feedback": filtered_users}

        except Exception:

            return {"flag": "400", "feedback": "Could not check for duplicacy"}