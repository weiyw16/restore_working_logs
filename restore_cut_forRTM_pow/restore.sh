#!/bin/bash

nr=126
nt=3001
nt_o=2048
dt=0.002
datapath=/data/wyw/DATA/VSPdata/nus_whole_vx/div
txtpath=/data/wyw/make_data/case_large_train/expr-pow-2048-nusgpu-20200304

for (( this_shot=0; this_shot < 15; this_shot++ ))
do

#this_shot=0
this_index=$(( ${this_shot} + 7*15 ))

cutname=${txtpath}/model_7_shot_${this_shot}_vz_cut.txt
fa=`cat ${cutname}` 
fa=$( echo "${fa} - 0.3" | bc )
if [ `echo "${fa} <  0" | bc` -eq 1 ]; then 
  fa=0
fi

if [ `echo "${fa} > 1.9" | bc` -eq 1 ]; then 
  fa=1.9
fi
echo ${fa}


#sfmath n1=${nt} n2=${nr} output=0 > ${this_shot}_ori.rsf
echo "n1=${nt_o} n2=${nr} data_format=native_float in=${datapath}/div_${this_index}.bin" > ${this_shot}_ori.rsf

sfpad < ${this_shot}_ori.rsf \
  n1=$( echo "${nt} - ${fa}/${dt}" | bc) |
  sfpad beg1=$(echo "${fa}/${dt}" | bc) \
  > ${this_shot}_pad.rsf


mv /var/tmp/${this_shot}_pad.rsf@ shot_gather.dat_${this_shot}

done

