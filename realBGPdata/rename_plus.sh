#!/bin/bash 

#datapath='/home/wyw/DATA/NEWBIN_less/2048-pow'
#datapath='/home/wyw/workspace/my-faset-forward/forward_modeling/case/expr-pow-2048-nusgpu-20200304/seismo_pow'
#datapath=$1
#datapath='/data/wyw/make_data/case_large_train/expr-wholescale-pow-2048-20200306/seismo_pow'
#datapath='/data/wyw/make_data/case_large_train/process_shotmore_model_7_pow/seismo_pow'
#datapath_target=${datapath}
datapath='/var/tmp/DATA/BGP-data/splited_data'
datapath_target=`pwd`
model_range=1
shot_range=275

mkdir ${datapath_target}/vz
mkdir ${datapath_target}/vx
mkdir ${datapath_target}/vy
#mkdir ${datapath_target}/div
#mkdir ${datapath_target}/curl

for (( ii=0; ii<${model_range}; ii++ ))
do
  for (( jj=0; jj<${shot_range}; jj++ ))
  do
    this_index=$((  ${jj} ))
    echo ${this_index}
    tarvz=shot_${jj}_cn_0_process.rsf@
    tarvx=shot_${jj}_cn_1_process.rsf@
    tarvy=shot_${jj}_cn_2_process.rsf@
    cp ${datapath}/${tarvz} ${datapath_target}/vz/vz_${this_index}.bin
    cp ${datapath}/${tarvy} ${datapath_target}/vy/vy_${this_index}.bin
    cp ${datapath}/${tarvx} ${datapath_target}/vx/vx_${this_index}.bin
  done
done

