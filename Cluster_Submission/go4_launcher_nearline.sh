#!/bin/bash

##Setup environment
#source /cvmfs/csee.gsi.de/bin/go4login
#source /cvmfs/eel.gsi.de/debian10-x86_64/bin/go4login
#source /cvmfs/eel.gsi.de/centos7-x86_64/bin/go4login
source /cvmfs/eel.gsi.de/bin/go4login
export ROOT_INCLUDE_PATH=/lustre/gamma/amistry/DESPEC_S452_NEARLINE_NIM
echo "DESPEC Kronos Started at `date`"

LISTFILE="/lustre/gamma/amistry/DESPEC_S452_NEARLINE_NIM/Cluster_Submission/S452_allfiles.txt"

#LISTFILE="/lustre/gamma/amistry/DESPEC_S452_NEARLINE_NIM/Cluster_Submission/file_list_full_188Ta.txt"

#LISTFILE="/lustre/gamma/amistry/DESPEC_S452_NEARLINE_NIM/Cluster_Submission/S452_f188.txt"

#LISTFILE="/lustre/gamma/amistry/DESPEC_S452_NEARLINE_NIM/Cluster_Submission/file_list_152Eu.txt"

#LISTFILE="/lustre/gamma/amistry/DESPEC_S452_NEARLINE_NIM/Cluster_Submission/file_list_133Ba.txt"

##Count number of files
NFILES=$(cat ${LISTFILE} | wc -l)
echo "Analysing" $NFILES "Files"

##Read names from list file
declare -a array
while IFS= read -r line
do
    array+=($line)
done < "$LISTFILE"

echo "Array is $SLURM_ARRAY_TASK_ID"
part=(  "${array[@]:$SLURM_ARRAY_TASK_ID:2}" ) # :5 number of files to put together -> Has to be the same in the 2 .sh scripts

echo "Running Go4!"
#go4analysis -file ${part[*]} -step 2 -disable-step -enable-asf 1800 -asf /lustre/gamma/amistry/DESPEC_S452_NEARLINE_NIM/Cluster_Submission/Nearline_Histograms/152Eu_EffT_$SLURM_ARRAY_TASK_ID.root

go4analysis -file ${part[*]} -enable-asf 1800 -asf  /lustre/gamma/amistry/DESPEC_S452_NEARLINE_NIM/Cluster_Submission/Nearline_Histograms/188Ta_SetupTEST_$SLURM_ARRAY_TASK_ID.root


