#!/bin/bash

cp header.html index.html
pandoc --standalone index.md >> index.html

cp header.html projects.html
pandoc --standalone projects.md >> projects.html



