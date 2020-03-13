#!/bin/bash

datapath=/data/wyw/make_data/case_large_train/expr-pow-2048-nusgpu-20200304/output

for (( ii=0; ii< 15; ii++ ))
do
  dataname=${datapath}/model_7_shot_${ii}_div.bin
  echo "in=${dataname} n1=126 n2=12004 data_format=native_float" > model_7_shot_${ii}_div_raw.rsf
  sfmath < model_7_shot_${ii}_div_raw.rsf output="abs(input)" |\
    sfmax axis=2 max=y > model_7_shot_${ii}_div_max.rsf
done

