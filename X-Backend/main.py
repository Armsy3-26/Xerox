#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Feb  1 23:18:24 2023

@author: armsy326
"""

from process import app


if __name__ == '__main__':
    
    app.run(port=5000, debug=True)