#!/usr/bin/env bash

echo "building..."
mkdir build && cd build
cmake ..
make ALLOW_WARNINGS=1