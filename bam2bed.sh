input_bam=$1
output_dir=$2
echo "Input BAM: $input_bam"
echo "Output directory: $output_dir"
mkdir -p $output_dir

# load conda
source $(dirname $(dirname $(which mamba)))/etc/profile.d/conda.sh

# make environment
conda create -y -n bam2bed bedtools

# activate environment
conda activate bam2bed

# name files
filename=$(basename $input_bam .bam)
bedfile=$output_dir/${filename}.bed
chr1_bedfile=$output_dir/${filename}_chr1.bed
countfile=$output_dir/bam2bed_number_of_rows.txt

# convert bam2bed
bedtools bamtobed -i $input_bam > $bedfile

# filter for chromosome 1, making sure not to include chromosome 1x
grep "^Chr1[[:space:]]" $bedfile > $chr1_bedfile

# count lines
wc -l $chr1_bedfile > $countfile

# say my name
echo "Koen Baars"
