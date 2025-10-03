#!/bin/sh

##
# SUPER COOL BATCH SCRIPT
#  general usage
##

#SBATCH --job-name=se_krak
#SBATCH -p Priority,Background,GPU
#SBATCH --output=/data/Food/analysis/R0986_toombak/serife/out_krak.txt
#SBATCH --error=/data/Food/analysis/R0986_toombak/serife/err_krak.txt
#SBATCH --cpus-per-task=8
#SBATCH --mail-user dhrati.patangia@teagasc.ie
#SBATCH --mail-type END,FAIL


#for file in /data/Food/analysis/R0986_toombak/serife/Serife_shotgundata/H3_input/*_R1_cat_kneaddata.fastq;
#do
  # Create a new filename for the repaired file
  #newfile="${file%.fastq}_repaired.fastq"
  
  # Apply the sed command and write output to the new file
  #sed 's/\.1.*/\/1/g' < "$file" > "$newfile"
  
#done

module load kraken2/2.1.3

cd /data/Food/analysis/R0986_toombak/serife/Serife_shotgundata/H3_input

# Directory containing FASTQ files
INPUT_DIR="/data/Food/analysis/R0986_toombak/serife/Serife_shotgundata/H3_input"

# Kraken2 database path
KRAKEN2_DB="/data/databases_v2/kraken2/k2_pluspf/"

# Number of threads to use
THREADS=8

# Output directory for Kraken2 results
OUTPUT_DIR="/data/Food/analysis/R0986_toombak/serife/Serife_shotgundata/kraken2_results"
mkdir -p $OUTPUT_DIR

# Loop through all cat-output fastq files
for f in "$INPUT_DIR"/*_R1_cat_kneaddata.fastq; do
    sample=$(basename "$f" | cut -d_ -f1)  # Extract sample name before first underscore
    
    echo "Running Kraken2 on $sample"

    kraken2 \
        --db "$KRAKEN2_DB" \
        --threads "$THREADS" \
        --use-names \
        --report "$OUTPUT_DIR/${sample}_kraken2_report.txt" \
        --output "$OUTPUT_DIR/${sample}_kraken2_output.txt" \
        "$f"
done

echo "All Kraken2 jobs completed."

#EOB
