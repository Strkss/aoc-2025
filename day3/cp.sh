#!/bin/bash

echo -e "Assemble and run " $1

OBJ="${1}.o"
SOURCE="${1}.s"

as $SOURCE -o $OBJ -32
gcc $OBJ -o $1 -m32
./$1