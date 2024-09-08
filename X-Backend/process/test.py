#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Feb  1 23:13:23 2023

@author: armsy326
"""

import os
import gensim
from gensim import matutils

corpus  = [
    "0718358415 Armstrong nyagwencha onyango 19900223 male english",
    "0741235462 Fakii mohammed 18862322 male kiswahili ",
    "0721345412 Florence Ngina 20021223 female english",
    "0734567676 David Kamau neems 19900223 male english",
    "Brian  19921203 Breezy male kiswahili 0712346578"
    ]

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

        threshold  = 0.5

        filtered_sentence  = [(doc,sim) for sim, doc in  zip(similarity, corpus) if sim >= threshold]

        print(filtered_sentence)

# query_checker = DuplicationChecker("0712346578 Brian Breezy 19921203 male kiswahili")

# query_checker.check_xerox()


from faker import Faker
import random
import mysql.connector
import secrets
import time

database = mysql.connector.connect(
    username='root',
    password='Armstrong3-26',
    host='localhost',
    database='XEROX'
)

mycursor = database.cursor()

# schools = ['Elisa Academy', 
#            'St. Don Bosco Primary School', 
#            'Mt.Sinai Academy', 'Asumbi Girls Primary School', 
#            'St. Andrew Kaaga Boys', 
#            'Tabaka Girls Primary School']

# fake = Faker()

# i = 21

# while i < 40:

    
#     mycursor.execute(
#          "Insert into student (id,firstname,surname,lastname,bc,schoolname,datebirth) values(%s,%s,%s,%s,%s,%s,%s)",
#          (i,fake.first_name(), fake.user_name(), fake.last_name(), secrets.token_hex(i-19), random.choice(schools), str(fake.date_of_birth())))
    
#     database.commit()
 
#     time.sleep(1)
#     print(f"Added student {fake.first_name()} to database ........{mycursor.rowcount+i} added.")
#     i = i+1

# corpus = []

# mycursor.execute("SELECT firstname,surname,lastname,bc,datebirth FROM  student WHERE schoolname ='Elisa Academy'")

# all_data = mycursor.fetchall()

# for data in all_data:

#     string_record = ' '.join(data)

#     corpus.append(string_record)

# print(corpus)


