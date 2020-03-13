#!/bin/bash

#datapath=/data/wyw/make_data/case_large_train/expr-pow-2048-nusgpu-20200304/output
datapath=/data/wyw/make_data/case_large_train/process_shotmore_model_7_pow/output

for (( ii=0; ii< 140; ii++ ))
do
  dataname=${datapath}/model_7_shot_${ii}_curl.bin
  echo "in=${dataname} n1=126 n2=12004 data_format=native_float" > model_7_shot_${ii}_curl_raw.rsf
  sfmath < model_7_shot_${ii}_curl_raw.rsf output="abs(input)" |\
    sfmax axis=2 max=y > model_7_shot_${ii}_curl_max.rsf
done

