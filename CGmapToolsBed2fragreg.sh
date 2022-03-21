#!/bin/bash
#SBATCH --job-name=bed2fragreg
#SBATCH --partition=batch
#SBATCH --ntasks=1
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --constraint=AMD
#SBATCH --time=2:00:00
#SBATCH --mem=20gb

ml  CGmapTools/0.1.2-foss-2019b

I=/scratch/gent/regions/wt_endo-embryo_EMRs.bed #Put in the the gff (anotation) files

prefix=wt_endo-embryo_EMRs  #Put in the name of you want for the output. Name the file!

let withingene=200   #Put in the number about how deep you want to go into the gene

let bin=100    #Put in the number of bin size

let flank=3000  #Put in the number of the flanking region

let n=(${withingene}+${flank})/$bin

#Calculating the upstream

awk '{print $1,$2-'$flank',$2+'$withingene',"+"}' ${I} OFS="\t" | sort -b -k1,1 -k2,2n -k3,3n > ${prefix}_up.bed

cgmaptools bed2fragreg -i ${prefix}_up.bed -n $n -o ${prefix}_UP_final.bed

sort -b -k1,1 -k2,2n -k3,3n ${prefix}_UP_final.bed > ${prefix}_UP_sort.bed

rm ${prefix}_up.bed ${prefix}_UP_final.bed ${prefix}_up1.bed ${prefix}_down1.bed

#Calculating the downstream

${prefix}.bed | awk '{print $1,$3-'$withingene',$3+'$flank',"+"}' ${I} OFS="\t" | sort -b -k1,1 -k2,2n -k3,3n > ${prefix}_down.bed 

cgmaptools bed2fragreg -i ${prefix}_down.bed -n $n -o ${prefix}_DOWN_final.bed

sort -b -k1,1 -k2,2n -k3,3n ${prefix}_DOWN_final.bed > ${prefix}_DOWN_sort.bed

rm ${prefix}_down.bed ${prefix}_DOWN_final.bed

