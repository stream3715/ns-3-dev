#!/bin/bash
cd $1 && cat $2 | tr "\\t" "," > $2.csv