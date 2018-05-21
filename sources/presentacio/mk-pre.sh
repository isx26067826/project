#!/bin/bash
# pandoc bash script
#---------------------------------------------------------
pandoc --standalone --to=dzslides --incremental --css=propi_style.css --output=presentacion.html presentacion.md

