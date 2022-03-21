#!/bin/bash
#SBATCH --job-name=DMR_cleaner
#SBATCH --partition=batch
#SBATCH --ntasks=1
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --constraint=AMD
#SBATCH --time=20:00:00
#SBATCH --mem=50gb

module load BEDTools/2.29.2-GCC-8.3.0

bedtools intersect -wa -u -a wt-mdr1_mat_endo_CG_3X_hyperDMRs.txt -b wt-mdr1_mat_endo_CHG_3X_hyperDMRs.txt > wt-mdr1_mat_endo_3X_hyperDMRs_unsorted_scaf.txt
bedtools intersect -wa -u -a wt-mdr1_mat_endo_CG_3X_hypoDMRs.txt -b wt-mdr1_mat_endo_CHG_3X_hypoDMRs.txt > wt-mdr1_mat_endo_3X_hypoDMRs_unsorted_scaf.txt
bedtools intersect -wa -u -a wt-mdr1_mat_endo_CG_3X_EMRs.txt -b wt-mdr1_mat_endo_CHG_3X_EMRs.txt > wt-mdr1_mat_endo_3X_EMRs_unsorted_scaf.txt
sort -nk 1 -nk 2,2 wt-mdr1_mat_endo_3X_hyperDMRs_unsorted_scaf.txt > wt-mdr1_mat_endo_hyperDMRs_scaf.bed
sort -nk 1 -nk 2,2 wt-mdr1_mat_endo_3X_hypoDMRs_unsorted_scaf.txt > wt-mdr1_mat_endo_hypoDMRs_scaf.bed
sort -nk 1 -nk 2,2 wt-mdr1_mat_endo_3X_EMRs_unsorted_scaf.txt > wt-mdr1_mat_endo_EMRs_scaf.bed
awk '{ if ($1 <= 10) { print } }' wt-mdr1_mat_endo_hyperDMRs_scaf.bed > wt-mdr1_mat_endo_hyperDMRs.bed 
awk '{ if ($1 <= 10) { print } }' wt-mdr1_mat_endo_hypoDMRs_scaf.bed > wt-mdr1_mat_endo_hypoDMRs.bed 
awk '{ if ($1 <= 10) { print } }' wt-mdr1_mat_endo_EMRs_scaf.bed > wt-mdr1_mat_endo_EMRs.bed 

bedtools intersect -wa -u -a wt-dng102_mat_endo_CG_3X_hyperDMRs.txt -b wt-dng102_mat_endo_CHG_3X_hyperDMRs.txt > wt-dng102_mat_endo_3X_hyperDMRs_unsorted_scaf.txt
bedtools intersect -wa -u -a wt-dng102_mat_endo_CG_3X_hypoDMRs.txt -b wt-dng102_mat_endo_CHG_3X_hypoDMRs.txt > wt-dng102_mat_endo_3X_hypoDMRs_unsorted_scaf.txt
bedtools intersect -wa -u -a wt-dng102_mat_endo_CG_3X_EMRs.txt -b wt-dng102_mat_endo_CHG_3X_EMRs.txt > wt-dng102_mat_endo_3X_EMRs_unsorted_scaf.txt
sort -nk 1 -nk 2,2 wt-dng102_mat_endo_3X_hyperDMRs_unsorted_scaf.txt > wt-dng102_mat_endo_hyperDMRs_scaf.bed
sort -nk 1 -nk 2,2 wt-dng102_mat_endo_3X_hypoDMRs_unsorted_scaf.txt > wt-dng102_mat_endo_hypoDMRs_scaf.bed
sort -nk 1 -nk 2,2 wt-dng102_mat_endo_3X_EMRs_unsorted_scaf.txt > wt-dng102_mat_endo_EMRs_scaf.bed
awk '{ if ($1 <= 10) { print } }' wt-dng102_mat_endo_hyperDMRs_scaf.bed > wt-dng102_mat_endo_hyperDMRs.bed 
awk '{ if ($1 <= 10) { print } }' wt-dng102_mat_endo_hypoDMRs_scaf.bed > wt-dng102_mat_endo_hypoDMRs.bed 
awk '{ if ($1 <= 10) { print } }' wt-dng102_mat_endo_EMRs_scaf.bed > wt-dng102_mat_endo_EMRs.bed 

bedtools intersect -wa -u -a wt_endo-tassel_CG_3X_hyperDMRs.txt -b wt_endo-tassel_CHG_3X_hyperDMRs.txt > wt_endo-tassel_3X_hyperDMRs_unsorted_scaf.txt
bedtools intersect -wa -u -a wt_endo-tassel_CG_3X_hypoDMRs.txt -b wt_endo-tassel_CHG_3X_hypoDMRs.txt > wt_endo-tassel_3X_hypoDMRs_unsorted_scaf.txt
bedtools intersect -wa -u -a wt_endo-tassel_CG_3X_EMRs.txt -b wt_endo-tassel_CHG_3X_EMRs.txt > wt_endo-tassel_3X_EMRs_unsorted_scaf.txt
sort -nk 1 -nk 2,2 wt_endo-tassel_3X_hyperDMRs_unsorted_scaf.txt > wt_endo-tassel_hyperDMRs_scaf.bed
sort -nk 1 -nk 2,2 wt_endo-tassel_3X_hypoDMRs_unsorted_scaf.txt > wt_endo-tassel_hypoDMRs_scaf.bed
sort -nk 1 -nk 2,2 wt_endo-tassel_3X_EMRs_unsorted_scaf.txt > wt_endo-tassel_EMRs_scaf.bed
awk '{ if ($1 <= 10) { print } }' wt_endo-tassel_hyperDMRs_scaf.bed > wt_endo-tassel_hyperDMRs.bed 
awk '{ if ($1 <= 10) { print } }' wt_endo-tassel_hypoDMRs_scaf.bed > wt_endo-tassel_hypoDMRs.bed 
awk '{ if ($1 <= 10) { print } }' wt_endo-tassel_EMRs_scaf.bed > wt_endo-tassel_EMRs.bed 

bedtools intersect -wa -u -a wt_endo-J306_leaf_CG_3X_hyperDMRs.txt -b wt_endo-J306_leaf_CHG_3X_hyperDMRs.txt > wt_endo-J306_leaf_3X_hyperDMRs_unsorted_scaf.txt
bedtools intersect -wa -u -a wt_endo-J306_leaf_CG_3X_hypoDMRs.txt -b wt_endo-J306_leaf_CHG_3X_hypoDMRs.txt > wt_endo-J306_leaf_3X_hypoDMRs_unsorted_scaf.txt
bedtools intersect -wa -u -a wt_endo-J306_leaf_CG_3X_EMRs.txt -b wt_endo-J306_leaf_CHG_3X_EMRs.txt > wt_endo-J306_leaf_3X_EMRs_unsorted_scaf.txt
sort -nk 1 -nk 2,2 wt_endo-J306_leaf_3X_hyperDMRs_unsorted_scaf.txt > wt_endo-J306_leaf_hyperDMRs_scaf.bed
sort -nk 1 -nk 2,2 wt_endo-J306_leaf_3X_hypoDMRs_unsorted_scaf.txt > wt_endo-J306_leaf_hypoDMRs_scaf.bed
sort -nk 1 -nk 2,2 wt_endo-J306_leaf_3X_EMRs_unsorted_scaf.txt > wt_endo-J306_leaf_EMRs_scaf.bed
awk '{ if ($1 <= 10) { print } }' wt_endo-J306_leaf_hyperDMRs_scaf.bed > wt_endo-J306_leaf_hyperDMRs.bed 
awk '{ if ($1 <= 10) { print } }' wt_endo-J306_leaf_hypoDMRs_scaf.bed > wt_endo-J306_leaf_hypoDMRs.bed 
awk '{ if ($1 <= 10) { print } }' wt_endo-J306_leaf_EMRs_scaf.bed > wt_endo-J306_leaf_EMRs.bed 

bedtools intersect -wa -u -a wt_endo-embryo_CG_3X_hyperDMRs.txt -b wt_endo-embryo_CHG_3X_hyperDMRs.txt > wt_endo-embryo_3X_hyperDMRs_unsorted_scaf.txt
bedtools intersect -wa -u -a wt_endo-embryo_CG_3X_hypoDMRs.txt -b wt_endo-embryo_CHG_3X_hypoDMRs.txt > wt_endo-embryo_3X_hypoDMRs_unsorted_scaf.txt
bedtools intersect -wa -u -a wt_endo-embryo_CG_3X_EMRs.txt -b wt_endo-embryo_CHG_3X_EMRs.txt > wt_endo-embryo_3X_EMRs_unsorted_scaf.txt
sort -nk 1 -nk 2,2 wt_endo-embryo_3X_hyperDMRs_unsorted_scaf.txt > wt_endo-embryo_hyperDMRs_scaf.bed
sort -nk 1 -nk 2,2 wt_endo-embryo_3X_hypoDMRs_unsorted_scaf.txt > wt_endo-embryo_hypoDMRs_scaf.bed
sort -nk 1 -nk 2,2 wt_endo-embryo_3X_EMRs_unsorted_scaf.txt > wt_endo-embryo_EMRs_scaf.bed
awk '{ if ($1 <= 10) { print } }' wt_endo-embryo_hyperDMRs_scaf.bed > wt_endo-embryo_hyperDMRs.bed 
awk '{ if ($1 <= 10) { print } }' wt_endo-embryo_hypoDMRs_scaf.bed > wt_endo-embryo_hypoDMRs.bed 
awk '{ if ($1 <= 10) { print } }' wt_endo-embryo_EMRs_scaf.bed > wt_endo-embryo_EMRs.bed 

bedtools intersect -wa -u -a wt-mdr1_endo_CG_3X_hyperDMRs.txt -b wt-mdr1_endo_CHG_3X_hyperDMRs.txt > wt-mdr1_endo_3X_hyperDMRs_unsorted_scaf.txt
bedtools intersect -wa -u -a wt-mdr1_endo_CG_3X_hypoDMRs.txt -b wt-mdr1_endo_CHG_3X_hypoDMRs.txt > wt-mdr1_endo_3X_hypoDMRs_unsorted_scaf.txt
bedtools intersect -wa -u -a wt-mdr1_endo_CG_3X_EMRs.txt -b wt-mdr1_endo_CHG_3X_EMRs.txt > wt-mdr1_endo_3X_EMRs_unsorted_scaf.txt
sort -nk 1 -nk 2,2 wt-mdr1_endo_3X_hyperDMRs_unsorted_scaf.txt > wt-mdr1_endo_hyperDMRs_scaf.bed
sort -nk 1 -nk 2,2 wt-mdr1_endo_3X_hypoDMRs_unsorted_scaf.txt > wt-mdr1_endo_hypoDMRs_scaf.bed
sort -nk 1 -nk 2,2 wt-mdr1_endo_3X_EMRs_unsorted_scaf.txt > wt-mdr1_endo_EMRs_scaf.bed
awk '{ if ($1 <= 10) { print } }' wt-mdr1_endo_hyperDMRs_scaf.bed > wt-mdr1_endo_hyperDMRs.bed 
awk '{ if ($1 <= 10) { print } }' wt-mdr1_endo_hypoDMRs_scaf.bed > wt-mdr1_endo_hypoDMRs.bed 
awk '{ if ($1 <= 10) { print } }' wt-mdr1_endo_EMRs_scaf.bed > wt-mdr1_endo_EMRs.bed 

bedtools intersect -wa -u -a wt-mdr1_embryo_CG_3X_hyperDMRs.txt -b wt-mdr1_embryo_CHG_3X_hyperDMRs.txt > wt-mdr1_embryo_3X_hyperDMRs_unsorted_scaf.txt
bedtools intersect -wa -u -a wt-mdr1_embryo_CG_3X_hypoDMRs.txt -b wt-mdr1_embryo_CHG_3X_hypoDMRs.txt > wt-mdr1_embryo_3X_hypoDMRs_unsorted_scaf.txt
bedtools intersect -wa -u -a wt-mdr1_embryo_CG_3X_EMRs.txt -b wt-mdr1_embryo_CHG_3X_EMRs.txt > wt-mdr1_embryo_3X_EMRs_unsorted_scaf.txt
sort -nk 1 -nk 2,2 wt-mdr1_embryo_3X_hyperDMRs_unsorted_scaf.txt > wt-mdr1_embryo_hyperDMRs_scaf.bed
sort -nk 1 -nk 2,2 wt-mdr1_embryo_3X_hypoDMRs_unsorted_scaf.txt > wt-mdr1_embryo_hypoDMRs_scaf.bed
sort -nk 1 -nk 2,2 wt-mdr1_embryo_3X_EMRs_unsorted_scaf.txt > wt-mdr1_embryo_EMRs_scaf.bed
awk '{ if ($1 <= 10) { print } }' wt-mdr1_embryo_hyperDMRs_scaf.bed > wt-mdr1_embryo_hyperDMRs.bed 
awk '{ if ($1 <= 10) { print } }' wt-mdr1_embryo_hypoDMRs_scaf.bed > wt-mdr1_embryo_hypoDMRs.bed 
awk '{ if ($1 <= 10) { print } }' wt-mdr1_embryo_EMRs_scaf.bed > wt-mdr1_embryo_EMRs.bed 

bedtools intersect -wa -u -a wt-mdr1_tassel_CG_3X_hyperDMRs.txt -b wt-mdr1_tassel_CHG_3X_hyperDMRs.txt > wt-mdr1_tassel_3X_hyperDMRs_unsorted_scaf.txt
bedtools intersect -wa -u -a wt-mdr1_tassel_CG_3X_hypoDMRs.txt -b wt-mdr1_tassel_CHG_3X_hypoDMRs.txt > wt-mdr1_tassel_3X_hypoDMRs_unsorted_scaf.txt
bedtools intersect -wa -u -a wt-mdr1_tassel_CG_3X_EMRs.txt -b wt-mdr1_tassel_CHG_3X_EMRs.txt > wt-mdr1_tassel_3X_EMRs_unsorted_scaf.txt
sort -nk 1 -nk 2,2 wt-mdr1_tassel_3X_hyperDMRs_unsorted_scaf.txt > wt-mdr1_tassel_hyperDMRs_scaf.bed
sort -nk 1 -nk 2,2 wt-mdr1_tassel_3X_hypoDMRs_unsorted_scaf.txt > wt-mdr1_tassel_hypoDMRs_scaf.bed
sort -nk 1 -nk 2,2 wt-mdr1_tassel_3X_EMRs_unsorted_scaf.txt > wt-mdr1_tassel_EMRs_scaf.bed
awk '{ if ($1 <= 10) { print } }' wt-mdr1_tassel_hyperDMRs_scaf.bed > wt-mdr1_tassel_hyperDMRs.bed 
awk '{ if ($1 <= 10) { print } }' wt-mdr1_tassel_hypoDMRs_scaf.bed > wt-mdr1_tassel_hypoDMRs.bed 
awk '{ if ($1 <= 10) { print } }' wt-mdr1_tassel_EMRs_scaf.bed > wt-mdr1_tassel_EMRs.bed 

bedtools intersect -wa -u -a J306-mdr1_leaf_CG_3X_hyperDMRs.txt -b J306-mdr1_leaf_CHG_3X_hyperDMRs.txt > J306-mdr1_leaf_3X_hyperDMRs_unsorted_scaf.txt
bedtools intersect -wa -u -a J306-mdr1_leaf_CG_3X_hypoDMRs.txt -b J306-mdr1_leaf_CHG_3X_hypoDMRs.txt > J306-mdr1_leaf_3X_hypoDMRs_unsorted_scaf.txt
bedtools intersect -wa -u -a J306-mdr1_leaf_CG_3X_EMRs.txt -b J306-mdr1_leaf_CHG_3X_EMRs.txt > J306-mdr1_leaf_3X_EMRs_unsorted_scaf.txt
sort -nk 1 -nk 2,2 J306-mdr1_leaf_3X_hyperDMRs_unsorted_scaf.txt > J306-mdr1_leaf_hyperDMRs_scaf.bed
sort -nk 1 -nk 2,2 J306-mdr1_leaf_3X_hypoDMRs_unsorted_scaf.txt > J306-mdr1_leaf_hypoDMRs_scaf.bed
sort -nk 1 -nk 2,2 J306-mdr1_leaf_3X_EMRs_unsorted_scaf.txt > J306-mdr1_leaf_EMRs_scaf.bed
awk '{ if ($1 <= 10) { print } }' J306-mdr1_leaf_hyperDMRs_scaf.bed > J306-mdr1_leaf_hyperDMRs.bed 
awk '{ if ($1 <= 10) { print } }' J306-mdr1_leaf_hypoDMRs_scaf.bed > J306-mdr1_leaf_hypoDMRs.bed 
awk '{ if ($1 <= 10) { print } }' J306-mdr1_leaf_EMRs_scaf.bed > J306-mdr1_leaf_EMRs.bed 

bedtools intersect -wa -u -a wt_embryo-tassel_CG_3X_hyperDMRs.txt -b wt_embryo-tassel_CHG_3X_hyperDMRs.txt > wt_embryo-tassel_3X_hyperDMRs_unsorted_scaf.txt
bedtools intersect -wa -u -a wt_embryo-tassel_CG_3X_hypoDMRs.txt -b wt_embryo-tassel_CHG_3X_hypoDMRs.txt > wt_embryo-tassel_3X_hypoDMRs_unsorted_scaf.txt
bedtools intersect -wa -u -a wt_embryo-tassel_CG_3X_EMRs.txt -b wt_embryo-tassel_CHG_3X_EMRs.txt > wt_embryo-tassel_3X_EMRs_unsorted_scaf.txt
sort -nk 1 -nk 2,2 wt_embryo-tassel_3X_hyperDMRs_unsorted_scaf.txt > wt_embryo-tassel_hyperDMRs_scaf.bed
sort -nk 1 -nk 2,2 wt_embryo-tassel_3X_hypoDMRs_unsorted_scaf.txt > wt_embryo-tassel_hypoDMRs_scaf.bed
sort -nk 1 -nk 2,2 wt_embryo-tassel_3X_EMRs_unsorted_scaf.txt > wt_embryo-tassel_EMRs_scaf.bed
awk '{ if ($1 <= 10) { print } }' wt_embryo-tassel_hyperDMRs_scaf.bed > wt_embryo-tassel_hyperDMRs.bed 
awk '{ if ($1 <= 10) { print } }' wt_embryo-tassel_hypoDMRs_scaf.bed > wt_embryo-tassel_hypoDMRs.bed 
awk '{ if ($1 <= 10) { print } }' wt_embryo-tassel_EMRs_scaf.bed > wt_embryo-tassel_EMRs.bed 

bedtools intersect -wa -u -a wt_embryo-J306_leaf_CG_3X_hyperDMRs.txt -b wt_embryo-J306_leaf_CHG_3X_hyperDMRs.txt > wt_embryo-J306_leaf_3X_hyperDMRs_unsorted_scaf.txt
bedtools intersect -wa -u -a wt_embryo-J306_leaf_CG_3X_hypoDMRs.txt -b wt_embryo-J306_leaf_CHG_3X_hypoDMRs.txt > wt_embryo-J306_leaf_3X_hypoDMRs_unsorted_scaf.txt
bedtools intersect -wa -u -a wt_embryo-J306_leaf_CG_3X_EMRs.txt -b wt_embryo-J306_leaf_CHG_3X_EMRs.txt > wt_embryo-J306_leaf_3X_EMRs_unsorted_scaf.txt
sort -nk 1 -nk 2,2 wt_embryo-J306_leaf_3X_hyperDMRs_unsorted_scaf.txt > wt_embryo-J306_leaf_hyperDMRs_scaf.bed
sort -nk 1 -nk 2,2 wt_embryo-J306_leaf_3X_hypoDMRs_unsorted_scaf.txt > wt_embryo-J306_leaf_hypoDMRs_scaf.bed
sort -nk 1 -nk 2,2 wt_embryo-J306_leaf_3X_EMRs_unsorted_scaf.txt > wt_embryo-J306_leaf_EMRs_scaf.bed
awk '{ if ($1 <= 10) { print } }' wt_embryo-J306_leaf_hyperDMRs_scaf.bed > wt_embryo-J306_leaf_hyperDMRs.bed 
awk '{ if ($1 <= 10) { print } }' wt_embryo-J306_leaf_hypoDMRs_scaf.bed > wt_embryo-J306_leaf_hypoDMRs.bed 
awk '{ if ($1 <= 10) { print } }' wt_embryo-J306_leaf_EMRs_scaf.bed > wt_embryo-J306_leaf_EMRs.bed 

bedtools intersect -wa -u -a wt_endo_dev-mat_CG_3X_hyperDMRs.txt -b wt_endo_dev-mat_CHG_3X_hyperDMRs.txt > wt_endo_dev-mat_3X_hyperDMRs_unsorted_scaf.txt
bedtools intersect -wa -u -a wt_endo_dev-mat_CG_3X_hypoDMRs.txt -b wt_endo_dev-mat_CHG_3X_hypoDMRs.txt > wt_endo_dev-mat_3X_hypoDMRs_unsorted_scaf.txt
bedtools intersect -wa -u -a wt_endo_dev-mat_CG_3X_EMRs.txt -b wt_endo_dev-mat_CHG_3X_EMRs.txt > wt_endo_dev-mat_3X_EMRs_unsorted_scaf.txt
sort -nk 1 -nk 2,2 wt_endo_dev-mat_3X_hyperDMRs_unsorted_scaf.txt > wt_endo_dev-mat_hyperDMRs_scaf.bed
sort -nk 1 -nk 2,2 wt_endo_dev-mat_3X_hypoDMRs_unsorted_scaf.txt > wt_endo_dev-mat_hypoDMRs_scaf.bed
sort -nk 1 -nk 2,2 wt_endo_dev-mat_3X_EMRs_unsorted_scaf.txt > wt_endo_dev-mat_EMRs_scaf.bed
awk '{ if ($1 <= 10) { print } }' wt_endo_dev-mat_hyperDMRs_scaf.bed > wt_endo_dev-mat_hyperDMRs.bed 
awk '{ if ($1 <= 10) { print } }' wt_endo_dev-mat_hypoDMRs_scaf.bed > wt_endo_dev-mat_hypoDMRs.bed 
awk '{ if ($1 <= 10) { print } }' wt_endo_dev-mat_EMRs_scaf.bed > wt_endo_dev-mat_EMRs.bed 

bedtools intersect -wa -u -a wt_endo-J664_leaf_CG_3X_hyperDMRs.txt -b wt_endo-J664_leaf_CHG_3X_hyperDMRs.txt > wt_endo-J664_leaf_3X_hyperDMRs_unsorted_scaf.txt
bedtools intersect -wa -u -a wt_endo-J664_leaf_CG_3X_hypoDMRs.txt -b wt_endo-J664_leaf_CHG_3X_hypoDMRs.txt > wt_endo-J664_leaf_3X_hypoDMRs_unsorted_scaf.txt
bedtools intersect -wa -u -a wt_endo-J664_leaf_CG_3X_EMRs.txt -b wt_endo-J664_leaf_CHG_3X_EMRs.txt > wt_endo-J664_leaf_3X_EMRs_unsorted_scaf.txt
sort -nk 1 -nk 2,2 wt_endo-J664_leaf_3X_hyperDMRs_unsorted_scaf.txt > wt_endo-J664_leaf_hyperDMRs_scaf.bed
sort -nk 1 -nk 2,2 wt_endo-J664_leaf_3X_hypoDMRs_unsorted_scaf.txt > wt_endo-J664_leaf_hypoDMRs_scaf.bed
sort -nk 1 -nk 2,2 wt_endo-J664_leaf_3X_EMRs_unsorted_scaf.txt > wt_endo-J664_leaf_EMRs_scaf.bed
awk '{ if ($1 <= 10) { print } }' wt_endo-J664_leaf_hyperDMRs_scaf.bed > wt_endo-J664_leaf_hyperDMRs.bed 
awk '{ if ($1 <= 10) { print } }' wt_endo-J664_leaf_hypoDMRs_scaf.bed > wt_endo-J664_leaf_hypoDMRs.bed 
awk '{ if ($1 <= 10) { print } }' wt_endo-J664_leaf_EMRs_scaf.bed > wt_endo-J664_leaf_EMRs.bed 

#sort -nk 1 -nk 2,2 J500s_combined_CHG.2_3X_unsorted_UMRs.txt > J500s_combined_CHG.2_UMRs_scaf.bed
#awk '{ if ($1 <= 10) { print } }' J500s_combined_CHG.2_UMRs_scaf.bed > J500s_combined_CHG.2_UMRs.bed 

#sort -nk 1 -nk 2,2 J500s_combined_CHH.2_3X_unsorted_MRs.txt > J500s_combined_CHH.2_MRs_scaf.bed
#awk '{ if ($1 <= 10) { print } }' J500s_combined_CHH.2_MRs_scaf.bed > J500s_combined_CHH.2_MRs.bed 


wc -l *MRs.bed > region_counts.txt