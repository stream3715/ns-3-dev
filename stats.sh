#!/bin/bash
cd $1 && cat $2 | awk -F"," '{if(FNR!=1)m+=$9} END{print m/NR;}' > stats.txt
