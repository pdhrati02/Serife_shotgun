#!/bin/sh

##
# SUPER COOL BATCH SCRIPT
#  general usage
##

#SBATCH --job-name=tri
#SBATCH --output=/data/Food/analysis/R0986_toombak/serife/Serife_shotgundata/data/out_trim.txt
#SBATCH --error=/data/Food/analysis/R0986_toombak/serife/Serife_shotgundata/data/err_trim.txt
#SBATCH -p Priority,Background
#SBATCH --cpus-per-task=5
#SBATCH --mail-user dhrati.patangia@teagasc.ie
#SBATCH --mail-type END,FAIL


module load trimmomatic/0.39

cd /data/Food/analysis/R0986_toombak/serife/Serife_shotgundata/data

ls /data/Food/analysis/R0986_toombak/serife/Serife_shotgundata/data/*_R1_cat.fastq | awk -F '_R1_cat.fastq' '{print "trimmomatic PE "$1"_R1_cat.fastq "$1"_R2_cat.fastq "$1"_1_paired.fq "$1"_1_unpaired.fq "$1"_2_paired.fq "$1"_2_unpaired.fq -phred33 -threads 10 ILLUMINACLIP:NexteraPE-PE.fa:2:30:10:4:true LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36"}' > trim.sh

sh trim.sh


#EOB
