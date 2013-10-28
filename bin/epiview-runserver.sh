#!/bin/bash
mkdir -p $HOME/log
nohup R -e "shiny::runApp('$HOME/epiview')" > $HOME/log/epiview-$$.log 2>&1 &
