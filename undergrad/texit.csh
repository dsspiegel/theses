#!/bin/csh

latex $1
latex $1
latex $1

dvips $1 -o ${1}.ps
