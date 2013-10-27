#!/bin/bash
nohup R -e "shiny::runApp('$HOME/epiview')" > $HOME/epiview-$$.log 2>&1 &
