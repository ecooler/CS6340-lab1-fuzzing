#!/bin/bash

cd build
cmake ..
make

cd ../test
clang -emit-llvm -S -fno-discard-value-names -c -o simple0.ll simple0.c -g

opt -load ../build/InstrumentPass.so -Instrument -S simple0.ll -o simple0.instrument.ll

clang -o simple0 ../lib/runtime.c simple0.instrument.ll

./simple0

exit 
