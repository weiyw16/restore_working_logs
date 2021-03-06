#!/bin/bash 


#datapath='/home/wyw/DATA/NEWBIN_less/2048-pow'
datapath='/home/wyw/workspace/my-faset-forward/forward_modeling/case/expr-pow-2048-nusgpu-20200304/seismo_pow'
#datapath_target=${datapath}
datapath_target=`pwd`
model_range=16
shot_range=15

for (( ii=0; ii<${model_range}; ii++ ))
do
  for (( jj=0; jj<${shot_range}; jj++ ))
  do
    this_index=$(( ${ii}*${shot_range} + ${jj} ))
    echo ${this_index}
    tarvz=vzmodel_${ii}_shot_${jj}_vz_afterpowmodel_${ii}_shot_${jj}_vz_plot_ready.rsf@
#  name2=model_${ii}_shot_${jj}_div_plot_ready.rsf@
    tarvx=vxmodel_${ii}_shot_${jj}_vx_afterpowmodel_${ii}_shot_${jj}_vx_plot_ready.rsf@
    tardiv=divmodel_${ii}_shot_${jj}_div_afterpowmodel_${ii}_shot_${jj}_div_plot_ready.rsf@
    tarcurl=curlmodel_${ii}_shot_${jj}_curl_afterpowmodel_${ii}_shot_${jj}_curl_plot_ready.rsf@
    mv ${datapath}/${tarvz} ${datapath_target}/vz/vz_${this_index}.bin
    mv ${datapath}/${tardiv} ${datapath_target}/div/div_${this_index}.bin
    mv ${datapath}/${tarvx} ${datapath_target}/vx/vx_${this_index}.bin
    mv ${datapath}/${tarcurl} ${datapath_target}/curl/curl_${this_index}.bin
  done
done

