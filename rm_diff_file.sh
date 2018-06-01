#!/bin/bash
function gen_file_list()
{
    picDir=$1
    picType=$2
    picListFile=$3
    ls $picDir/$picType  -1 |awk '{print i"/"$0}' i=`pwd`'/' >$picListFile
    return 0
}

function get_file()
{
    SrcFile=$(ls *ir.png)
    SrcCount=$(ls *ir.png | wc -w)
    DstFile=$(ls *ir.dat)
    DstCount=$(ls *ir.dat | wc -w)
}

function check()
{
    SrcF=$SrcFile
    DstF=$DstFile
    SrcC=$(echo $SrcF | wc -w)
    DstC=$(echo $DstF | wc -w)
    IsDiff=1
    echo "SrcC=$SrcC"
    echo "DstC=$DstC"

    for src in $SrcF
    do
        if [[ ! -z $src ]];then
             src_name=${src%_*}
             #src_rec=${src%%_*}
             #src_frame=${src#*_}
             #src_frame=${src_frame%%_*}
             #src_date=${src%%-*}
             #src_date=${src_date##*_}
             #src_time=${src##*-}
             #src_time=${src_time%%_*}
             #src_type=${src##*_}
             #src_type=${src_type%%.*}
             #src_ext=${src#*.}
        fi

        for dst in $DstF
        do
            if [[ ! -z $dst ]];then
                dst_name=${dst%_*}
                #dst_rec=${dst%%_*}
                #dst_frame=${dst#*_}
                #dst_frame=${dst_frame%%_*}
                #dst_date=${dst%%-*}
                #dst_date=${dst_date##*_}
                #dst_time=${dst##*-}
                #dst_time=${dst_time%%_*}
                #dst_type=${dst##*_}
                #dst_type=${dst_type%%.*}
                #dst_ext=${dst#*.}
            fi

            if [[ ${src_name} == ${dst_name} ]];then
               echo "src : $src , dst : $dst ."  
               IsDiff=0
            fi
        done

        if [[ $IsDiff -eq 1 ]];then
            echo "rm $src"
            rm $src
        fi

    done
}

function debug_src()
{
    echo "src_name: $src_name"
    echo "src_rec: $src_rec"
    echo "src_frame: $src_frame"
    echo "src_date: $src_date"
    echo "src_time: $src_time"
    echo "src_type: $src_type"
    echo "src_ext: $src_ext"
}

function debug_dst()
{
    echo "dst_name: $dst_name"
    echo "dst_rec: $dst_rec"
    echo "dst_frame: $dst_frame"
    echo "dst_date: $dst_date"
    echo "dst_time: $dst_time"
    echo "dst_type: $dst_type"
    echo "dst_ext: $dst_ext"
}

gen_file_list "ir" "*.png" "ir_pic.txt"
gen_file_list "ir" "*.dat" "ir_dat.txt"

pushd ir
get_file
if [[ -z $SrcFile ]];then
    exit
fi

if [[ -z $DstFile ]];then
    exit
fi
check "$SrcFile" "$DstFile"
popd
