#!/bin/bash

nr_o=128
nr=126
nt=3001
nt_o=2048
dt=0.002
#datapath=/data/wyw/DATA/VSPdata/nus_whole_vx/div
#datapath=/home/wyw/workspace/EXPERIMENTS/job/job_bgp_2to1/newbin_2to2/batchsize_10_gpuid-0-epoch-1950-sfrom-0-to-240
datapath=/home/wyw/workspace/EXPERIMENTS/job/job_bgp_2to1/newbin_2to2/batchsize_10_gpuid-0-epoch-2000-sfrom-980-to-140
#txtpath=/data/wyw/make_data/case_large_train/expr-pow-2048-nusgpu-20200304
txtpath=/data/wyw/make_data/case_large_train/process_shotmore_model_7_pow

for (( this_shot=0; this_shot < 140; this_shot++ ))
do

#this_shot=0
#this_index=$(( ${this_shot} + 7*15 ))
this_index=$(( ${this_shot} + 980 ))

cutname=${txtpath}/model_7_shot_${this_shot}_vz_cut.txt
fa=`cat ${cutname}` 
fa=$( echo "${fa} - 0.3" | bc )
if [ `echo "${fa} <  0" | bc` -eq 1 ]; then 
  fa=0
fi

if [ `echo "${fa} > 1.9" | bc` -eq 1 ]; then 
  fa=1.9
fi
echo "cut time: ${fa}"

#maxname=${maxminpath}/model_7_shot_${this_shot}_div_max.txt
#minname=${maxminpath}/model_7_shot_${this_shot}_div_max.txt
#maxv=`sed -n 1p ${maxname} | cut -d " " -f10`
#minv=`sed -n 1p ${minname} | cut -d " " -f10`
#
#if [ `echo "${maxv} >  -${minv}" | bc` -eq 1  ]; then
#  maxval=${maxv}
#else
#  maxval=$(( -${minv} ))
#fi
#echo "max value: ${maxval}"



## readin data
#sfmath n1=${nt} n2=${nr} output=0 > ${this_shot}_ori.rsf
#echo "n1=${nt_o} n2=${nr_o} data_format=native_float in=${datapath}/${this_index}_P" > ${this_shot}_ori.rsf
#echo "n1=${nt_o} n2=${nr_o} data_format=native_float in=${datapath}/${this_index}_P" > ${this_shot}_ori.rsf
echo "n1=${nr_o} n2=${nt_o} data_format=native_float in=${datapath}/${this_index}_S" > ${this_shot}_ori.rsf

## cut and pad
sftransp <  ${this_shot}_ori.rsf plane=12 |\
  sfwindow f2=1 n2=${nr} |
  sfpad n1=$( echo "${nt} - ${fa}/${dt}" | bc) |
  sfpad beg1=$(echo "${fa}/${dt}" | bc) |\
  sfput o1=0 o2=0 \
  > ${this_shot}_pad.rsf


## rescale
#sfmath < ${this_shot}_pad.rsf tau=${this_shot}_scale.rsf \
#  output="tau*input" > ${this_shot}_rescale.rsf
#
sfspray < model_7_shot_${this_shot}_curl_max.rsf n=3001 |\
  sftransp plane=12 |\
  sfmath tao=${this_shot}_pad.rsf output='input*tao' \
  > ${this_shot}_rescale.rsf

## pow1=-2
#sfpow < ${this_shot}_pad.rsf pow1=-2 > ${this_shot}_inpow.rsf
sfpow < ${this_shot}_rescale.rsf pow1=-2 > ${this_shot}_inpow.rsf


## rename
mv /var/tmp/${this_shot}_inpow.rsf@ shot_gather.dat_${this_shot}

done

