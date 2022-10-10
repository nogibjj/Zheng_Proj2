#!/bin/bash

targ_repo="empty"

prepare()
{
    sudo apt install unzip
    make install
    kaggle datasets download -d $targ_repo
    rm -rf data
    mkdir data
    unzip *.zip -d data
    list
    rm *.zip
}

list()
{
    for file in $(ls ./data)
    do
        echo $file
    done
}

help()
{
    echo "The script is for data preparation."
    echo "Enter -p + dataset's name to start preparation for dataset in Kaggle."
    echo "Enter -i + csv file's path for the info of cached dataset."
    echo "Enter -m for the names of cached csv files and available operations."
    echo "Enter -h + csv file to print 10 lines from the head of dataset."
    echo "Enter -s + csv file for the info of sorted dataset."
    echo "Enter -c + csv file for the info of cleaned dataset."
}

while getopts ":p:i:h:t:s:c:m" OPTION
do
    case $OPTION in
        p)
            targ_repo=$OPTARG
            prepare
            list
            help
            ;;
        i)
            targ_csv=$OPTARG
            python operation.py cli-info --csv_file $targ_csv 
            ;;
        h)
            targ_csv=$OPTARG
            python operation.py cli-head --csv_file $targ_csv 
            ;;
        s)
            targ_csv=$OPTARG
            python operation.py cli-sort --csv_file $targ_csv 
            ;;
        c)
            targ_csv=$OPTARG
            python operation.py cli-clean --csv_file $targ_csv 
            ;;
        m)
            list
            targ_csv=$OPTARG
            python operation.py --help
            ;;
        \?)                      
            help
            ;;
    esac
done