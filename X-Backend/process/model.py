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
paragraph = ''

new_paragraph = ''
#get .txt extension files only

text_files  = []

for file in all_files:
    
    base,ext = os.path.splitext(file)
    
    if ext == '.txt':
        text_files.append(file)
        
    else:
        
        pass
    
class DuplicationAnalysis(object):
    
    def __init__(self, filename):
        
        filename = self.filename
        
    #incoming fxn

    def process_incoming_file(self):
        
        for text_file in text_files:
            
            with open(path+'/Xerox/X-Backend/process/documents/'+self.filename) as f:
                #wrap it inside a spacy object
                paragraph_String  = nlp(f.read())
                
                #tokenize and remove stop words 
                
                tokenized_doc  = [token.lemma_ for token in paragraph_String if not token.is_stop]
                
                paragraph = nlp(' '.join(tokenized_doc))
                
                
    def process_present_files():
        
        for text_file in text_files:
            
            with open(path+'/Xerox/X-Backend/process/documents/'+text_file) as f:
                #wrap it inside a spacy object
                paragraph_String  = nlp(f.read())
                
                #tokenize and remove stop words 
                
                tokenized_doc  = [token.lemma_ for token in paragraph_String if not token.is_stop]
                
                paragraph = nlp(' '.join(tokenized_doc))
                
                #convert word to vectors 
                #both should be objects exposed to same process
                #get the similarity value
                sims  = paragraph.similarity(new_paragraph)
                
                print(sims)

        
        
        
