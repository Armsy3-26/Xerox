#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Feb  2 12:32:33 2023

@author: armsy326
"""

import os
import gensim
from gensim import matutils

complete_input  = ""

#will be fetched from the database
corpus  = [
    "0718358415 Armstrong nyagwencha onyango 19900223 male english",
    "0741235462 Fakii mohammed 18862322 male kiswahili ",
    "0721345412 Florence Ngina 20021223 female english",
    "0734567676 David Kamau neems 19900223 male english",
    "0712346578 Brian Breezy 19921203 male kiswahili"
    ]

#preprocess the information bith incoming input and corpus

input_preprocess = gensim.utils.simple_preprocess(complete_input)

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
