#!/bin/bash

cd vz; shref_multi vz
cd ../
cd vx; shref_multi vx
cd ../
cd div; shref_multi div
cd ../
cd curl; shref_multi curl
cd ../

tar -zcvf $1.tgz ./vz/*eps ./vx/*eps ./div/*eps ./curl/*eps
