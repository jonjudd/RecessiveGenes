#!/bin/bash
#SBATCH --job-name=process_burden_tests
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=2G

# Directory containing the files
input_dir="/oak/stanford/groups/pritch/users/nmilind/share/gdrcs/LoF/WES"
# Directory where you want to save the output file
output_dir="/oak/stanford/groups/pritch/users/jjudd5/recessive_genes"
# Output file name
output_file="$output_dir/processed_burden_tests.tsv"

# Initialize the output file with the header (modify as needed)
echo -e "ID\tMASK\tBETA\tSE\tLOG10P\tSOURCE_FILE" > $output_file

# Loop through each file in the input directory
for file in $input_dir/*.gz; do
    # Extract the file name without the directory and extension
    file_name=$(basename "$file" .WES.regenie.gz)
    
    # Unzip the file and extract the desired columns, then add the file name as a new column
    zcat "$file" | awk -v fname="$file_name" 'NR > 1 {print $3 "\t" $5 "\t" $9 "\t" $10 "\t" $12 "\t" fname}' >> $output_file
done

echo "Processing complete. Output written to $output_file"
