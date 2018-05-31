#!/bin/bash
export PATH=$(pwd):$PATH

function RecgPerson()
{
    AllPersonDir="pic"
    AllPerson=$(ls $AllPersonDir  -1 |awk '{print i"/'$AllPersonDir'/"$0}' i=`pwd`'/')
    Thresh=0.7

    for file in $AllPerson
    do
        ./recgnize $1 $file > ${file}.txt
        Result=$(grep "cmp_feature score"  "${file}.txt" | cut -f2 -d ':')
        if [ $(echo "$Result > $Thresh" | bc) = 1 ];then
            echo "success:1=$1 file=$file"
        fi
    done
}
