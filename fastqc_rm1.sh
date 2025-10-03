#!/bin/sh

##
# SUPER COOL BATCH SCRIPT
#  general usage
##

#SBATCH --job-name=fq
#SBATCH --output=/data/Food/analysis/R0986_toombak/serife/Serife_shotgundata/out_fastqc.txt
#SBATCH --error=/data/Food/analysis/R0986_toombak/serife/Serife_shotgundata/err_fastqc.txt
#SBATCH -p Priority,Background
#SBATCH --cpus-per-task=4
#SBATCH --mail-user dhrati.patangia@teagasc.ie
#SBATCH --mail-type END,FAIL



module load fastqc/0.12.1

cd /data/Food/analysis/R0986_toombak/serife/Serife_shotgundata
mkdir fastqc_r1
mkdir fastqc_r2

fastqc -o /data/Food/analysis/R0986_toombak/serife/Serife_shotgundata/fastqc_r1/ -t 4 /data/Food/analysis/R0986_toombak/serife/Serife_shotgundata/data/*_R1_cat.fastq.gz

fastqc -o /data/Food/analysis/R0986_toombak/serife/Serife_shotgundata/fastqc_r2/ -t 4 /data/Food/analysis/R0986_toombak/serife/Serife_shotgundata/data/*_R2_cat.fastq.gz


module load multiqc/1.21
multiqc /data/Food/analysis/R0986_toombak/serife/Serife_shotgundata/fastqc_r1 -o multiqc_report_r1/
multiqc /data/Food/analysis/R0986_toombak/serife/Serife_shotgundata/fastqc_r2 -o multiqc_report_r2/

#EOB
