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
    database = "XEROX",
)
mycursor  = database.cursor()
#will be fetched from the database
corpus  = []

def get_student_record(school_name):
        corpus.clear()
        mycursor.execute("SELECT firstname,surname,lastname,bc,datebirth FROM  student WHERE schoolname = %s ",(school_name,))
        for data in mycursor:
           
            string_record = ' '.join(data)

            corpus.append(string_record)

        return len(corpus)


class DuplicationChecker(object):

    def __init__(self, query_user_info):

        self.query_user_info = query_user_info 

    def check_xerox(self):
        corpus.pop(corpus.index(self.query_user_info))
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

            threshold  = 0.5

            filtered_users  = [(doc,sim) for sim, doc in  zip(similarity, corpus) if sim >= threshold]
            
            if filtered_users == []:
                
                return {"success": True, "feedback": "No duplicates found"}

            else:

                # have separate records for duplicates and similarity scores

                duplicate_sentences = []

                duplicate_score = []
                
                for doc, sim in filtered_users:
                    duplicate_sentences.append(doc.split(' '))
                    duplicate_score.append(f"{sim*100:.0f}")

                return {"success": True, "score": duplicate_score, "duplicates": duplicate_sentences}

        except Exception as e:

            return {"success": False, "feedback": "Could not check for duplicacy"}

# duplicate_checker = DuplicationChecker('Kristi rome Ramos c511hf78838388 1949-01-17')
# duplicate_checker.check_xerox()

def get_duplicates():
    duplicate_dict = {}

    index = 0
    for record in corpus:
        # to check for duplicates 
        # we intantiate the class
        duplicate_checker = DuplicationChecker(record)
    
        # then we execute the fuction rhat does that
        res = duplicate_checker.check_xerox()
        
        # we then loop through the generated corpus looking for duplicates 
        # need to get duplicates with their indeces 
        check_duplicate_key = res.get('duplicates')
        if check_duplicate_key != None:

            # add duplicates to the duplicate dictionary
            # all the duplicates should be added to the dictionary
            res['duplicates'].insert(0,record.split(' '))
            res['score'].insert(0,0)
            
            duplicate_dict[f"dup{index}"] = [res['duplicates'], res['score']]

            # remove all the  duplicates from the corpus
            
            for i in range(len(res['duplicates'])-1):
                duplicate_index = i + 1
                
                duplicate_value = res['duplicates'][duplicate_index]

                corpus.pop(corpus.index(' '.join(duplicate_value)))  

            index = index+1

        else:
            pass
           # corpus.pop(corpus.index(record))
           
        #print(f'No duplicate found for: {record}')
    # print(duplicate_dict)
    return duplicate_dict

# get_duplicates()