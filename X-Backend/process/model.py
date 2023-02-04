#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Feb  2 12:32:33 2023

@author: armsy326
"""

import os
import spacy

nlp = spacy.load("en_core_web_lg")


#default current path

path  = os.path.expanduser('~')

#opens files for comparison
#get all .txt

all_files  = os.listdir(path+'/Xerox/X-Backend/process/documents')

#read the files one by one , tokenize, lemma it and make a complete statement
paragraph = []

new_paragraph = []
#get .txt extension files only

text_files  = []

def fetch_present_files():
    
    for file in all_files:
        
        base,ext = os.path.splitext(file)
        
        if ext == '.txt':
            text_files.append(file)
            
        else:
            
            pass
    
#incoming fxn

def process_incoming_file(filename):
    
    #for text_file in text_files:
        
    with open(path+'/Xerox/X-Backend/process/documents/'+filename) as f:
        #wrap it inside a spacy object
        paragraph_String  = nlp(f.read())
        
        #tokenize and remove stop words 
        
        tokenized_doc  = [token.lemma_ for token in paragraph_String if not token.is_stop]
        
        new_paragraph.append(' '.join(tokenized_doc))
        
        print("done")
        
        return {"flag": 201, "feedback": "Extraction complete \n scanning for duplications"}
            
            
def process_present_files():
    
    for text_file in text_files:
        
        with open(path+'/Xerox/X-Backend/process/documents/'+text_file) as f:
            #wrap it inside a spacy object
            paragraph_String  = nlp(f.read())
            
            #tokenize and remove stop words 
            
            tokenized_doc  = [token.lemma_ for token in paragraph_String if not token.is_stop]
            
            paragraph.append(' '.join(tokenized_doc))
            print("done")
            
            return {"flag": 201, "feedback": "Current docs scanned to completion"}
        
def get_similarity():
            
            #convert word to vectors 
            #both should be objects exposed to same process
            #get the similarity value
            nlp_obj = nlp(paragraph[0])
            nlp_obj2 = nlp(new_paragraph[0])
            sims  = nlp_obj.similarity(nlp_obj2)
            
            print(sims)
            
            #clear the lists to avoid over-stack
            paragraph.clear()
            new_paragraph.clear()

        
        
        
