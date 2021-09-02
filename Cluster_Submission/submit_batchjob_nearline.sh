#!/bin/bash
##Read in list of files to run

LISTFILE="/lustre/gamma/amistry/DESPEC_S452_NEARLINE_NIM/Cluster_Submission/S452_allfiles.txt"

#LISTFILE="/lustre/gamma/amistry/DESPEC_S452_NEARLINE_NIM/Cluster_Submission/file_list_full_188Ta.txt"

#LISTFILE="/lustre/gamma/amistry/DESPEC_S452_NEARLINE_NIM/Cluster_Submission/file_list_152Eu.txt"

#LISTFILE="/lustre/gamma/amistry/DESPEC_S452_NEARLINE_NIM/Cluster_Submission/file_list_133Ba.txt"

#LISTFILE="/lustre/gamma/amistry/DESPEC_S452_NEARLINE_NIM/Cluster_Submission/S452_f188.txt" 

declare -a size
while IFS= read -r line
do
    size+=($line)
   
done < "$LISTFILE"

##Submit job
sbatch -J despec_go4_s452am -D /lustre/gamma/amistry/DESPEC_S452_NEARLINE_NIM/ -o logs/go4_%A_%a.out.log -e logs/go4_%A_%a.err.log \
  --time=8:00:00 --mem-per-cpu=4G \
  --array=0-${#size[@]}:2 -- /lustre/gamma/amistry/DESPEC_S452_NEARLINE_NIM/Cluster_Submission/go4_launcher_nearline.sh
