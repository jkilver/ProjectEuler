#!/bin/bash
cd ProjectEuler

# Run pytest
cd python
pytest

# build cpp
cd ../cpp
rm -rf ./build
mkdir build
cd build
cmake ..
make -j

# Run tests for cpp

