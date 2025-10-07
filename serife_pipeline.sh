#!/bin/bash


#----------------------------------------------------------------------------------------
#SBATCH --job-name=se_m4
#SBATCH -p Priority,Background,GPU
#SBATCH --output=/data/Food/analysis/R0986_toombak/serife/out_m4.txt
#SBATCH --error=/data/Food/analysis/R0986_toombak/serife/err_m4.txt
#SBATCH --cpus-per-task=7
#SBATCH --mail-user dhrati.patangia@teagasc.ie
#SBATCH --mail-type END,FAIL



#module load bowtie2/2.5.3 
#module load diamond/2.1.8-162 
#module load kneaddata/0.12.0 


#######cp and unzip files

#primaryfolder="/data/Food/primary/R0986_toombak/Fatma/Serife_shotgundata"
folder="/data/Food/analysis/R0986_toombak/serife/Serife_shotgundata"

#cd $folder
#mkdir data

#cd $primaryfolder

#find . -iname *.gz -exec cp {} $folder/data \;

#cd $folder/data
#gunzip *



### ----------------------------------------------------------------------------------------
### Gunzip the files

cd $folder 
#mkdir H3
#mkdir fastq
#mkdir KD_fastq
#mkdir fastqc
#mkdir M4


#### ----------------------------------------------------------------------------------------
#### Quality control of the shotgun data
#cd $folder/data


#source activate /data/Food/analysis/R3930_resistomeanalysis/software/trimmomatic


####Kneaddata first
#for f in *R1_cat.fastq
#do
     #fname=${f}
     #fname2=${f%%_R1_cat.fastq}
     #R1="_R1_cat.fastq"
     #R2="_R2_cat.fastq"
     #echo $fname
     #echo $fname2
     #echo $fname$R1
     #kneaddata --trimmomatic /data/Food/analysis/R3930_resistomeanalysis/software/trimmomatic/Trimmomatic-0.39/ \
     #-i1 $fname2$R1 -i2 $fname2$R2 -db /data/Food/analysis/R0986_toombak/serife/genomes/rat/rat_mRatBN7.2 -o $folder/KD_fastq --cat-final-output \
     #--threads 5 --remove-intermediate-output
#done    
 
##--fastqc /install/software/mincondas/3.7/instance3/opt/fastqc-0.11.9/ --run-fastqc-start --run-fastqc-end

#kneaddata_read_count_table --input $folder/KD_fastq/ --output $folder/KD_fastq/kneaddata_counts_serife.txt

#source deactivate /data/Food/analysis/R3930_resistomeanalysis/software/trimmomatic



#############part2##### 

##fastqc post kneaddata

#module load fastqc/0.12.1

#cd $folder/KD_fastq

#mkdir fastqc_r1_afterT
#mkdir fastqc_r2_afterT

#fastqc -o $folder/KD_fastq/fastqc_r1_afterT/ -t 4 $folder/KD_fastq/*_paired_1.fastq

#fastqc -o $folder/KD_fastq/fastqc_r2_afterT/ -t 10 $folder/KD_fastq/*_paired_2.fastq

 
#### ----------------------------------------------------------------------------------------
##concatenate kneaddata output  ##already used cat so dont need this step

#cd $folder/KD_fastq

#mkdir H3_input

#make a file with all sample names in it

#ls -1 *R1*.fastq | awk -F '_' '{print $1"_"$2}' | sort | uniq > ID_knead

##cat them

#for i in `cat ./ID_knead`; 

#do cat $i\_L001_R1_001_kneaddata_paired_1.fastq $i\_L001_R1_001_kneaddata_paired_2.fastq $i\_L001_R1_001_kneaddata_unmatched_1.fastq $i\_L001_R1_001_kneaddata_unmatched_2.fastq > $i\_kneaded_4cat.fastq; 

#done;


##move the cat files to a new folder called H3_input

#cd /data/Food/analysis/R0986_toombak/serife/Serife_shotgundata/KD_fastq
#cp *_cat_kneaddata.fastq /data/Food/analysis/R0986_toombak/serife/Serife_shotgundata/H3_input/

# ## ----------------------------------------------------------------------------------------
# ## Run Humann 3

#module load humann/3.8
#module load metaphlan/4.1.1
#humann --version


#cd $folder/H3_input
 
#for f in *.fastq
#do
    #fname=${f%%.fastq}
    #text="_h3"
    #humann --input ${f} --output $folder/H3/$fname$text \
    #--nucleotide-database /data/databases/humann3.8/chocophlan \
    #--protein-database /data/databases/humann3.8/uniref/ \
    #--metaphlan-options "--bowtie2db /data/databases/MetaPhlAn4.0.6/ --index mpa_vOct22_CHOCOPhlAnSGB_202212" \
    #--search-mode uniref90 --threads 7 --memory-use maximum
#done





#######-------------------------PART3----------------------------------------------------------



###running metaphlan4 separately as it is not compatible with humann3

module load metaphlan/4.1.1


cd $folder 

mkdir M4

cd $folder/M4
mkdir SAM
mkdir TAXO
mkdir BWT

cd $folder/H3_input/

for i in *.fastq;
do 
     metaphlan $i --input_type fastq --bowtie2db /data/databases_v2/metaphlan4/ --index mpa_vJun23_CHOCOPhlAnSGB_202403 \
     --bowtie2out $folder/M4/BWT/${i%.fastq} --samout $folder/M4/SAM/${i%.fastq}.sam \
     --nproc 7 > $folder/M4/TAXO/${i%.fastq}_profile.txt; 
done

cd $folder/M4/SAM/

merge_metaphlan_tables.py $folder/M4/TAXO/*txt > $folder/M4/TAXO/metaphlan4_serife.txt





#EOB