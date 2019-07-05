#!/bin/bash

virtualenv .env && source .env/bin/activate && pip install -r requirements.txt
PATH=.env/bin/activate:$PATH
bash
