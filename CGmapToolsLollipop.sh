#!/bin/bash
#SBATCH --job-name=Cgmaptools_lollipop
#SBATCH --partition=batch
#SBATCH --ntasks=1
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --constraint=AMD
#SBATCH --time=20:00:00
#SBATCH --mem=20gb
#SBATCH --mail-user=gent@uga.edu
#SBATCH --mail-type=BEGIN,END,NONE,FAIL,REQUEUE

module load CGmapTools/0.1.2-foss-2019b

#gunzip -c wt-mdr1_endo_CG.gz | awk '{print $1,$3,$6,$9}' OFS="\t" | gzip > wt-mdr1_endo_CG_lolli.gz
#gunzip -c wt-mdr1_endo_CHG.gz | awk '{print $1,$3,$6,$9}' OFS="\t" | gzip > wt-mdr1_endo_CHG_lolli.gz
#gunzip -c wt-mdr1_endo_CHH.gz | awk '{print $1,$3,$6,$9}' OFS="\t" | gzip > wt-mdr1_endo_CHH_lolli.gz

#gunzip -c wt_endo-embryo_CG.gz | awk '{print $1,$3,$6,$9}' OFS="\t" | gzip > wt_endo-embryo_CG_lolli.gz
#gunzip -c wt_endo-embryo_CHG.gz | awk '{print $1,$3,$6,$9}' OFS="\t" | gzip > wt_endo-embryo_CHG_lolli.gz
#gunzip -c wt_endo-embryo_CHH.gz | awk '{print $1,$3,$6,$9}' OFS="\t" | gzip > wt_endo-embryo_CHH_lolli.gz

gunzip -c wt-mdr1_endo_CG_lolli.gz | awk -F "\t" '{ if(($1 == "LWRW02000294_1") && ($2 >= 0)  && ($2 <= 8000)) { print } }'  > wt-mdr1_endo_CG_lolli10_r1.gz
gunzip -c wt-mdr1_endo_CHG_lolli.gz | awk -F "\t" '{ if(($1 == "LWRW02000294_1") && ($2 >= 0)  && ($2 <= 8000)) { print } }'  > wt-mdr1_endo_CHG_lolli10_r1.gz
gunzip -c wt-mdr1_endo_CHH_lolli.gz | awk -F "\t" '{ if(($1 == "LWRW02000294_1") && ($2 >= 0)  && ($2 <= 8000)) { print } }'  > wt-mdr1_endo_CHH_lolli10_r1.gz

cgmaptools lollipop -i wt-mdr1_endo_CG_lolli10_r1.gz -b ~/references/sigma.bed
cgmaptools lollipop -i wt-mdr1_endo_CHG_lolli10_r1.gz -b ~/references/sigma.bed
cgmaptools lollipop -i wt-mdr1_endo_CHH_lolli10_r1.gz -b ~/references/sigma.bed

gunzip -c wt_endo-embryo_CG_lolli.gz | awk -F "\t" '{ if(($1 == "LWRW02000294_1") && ($2 >= 0)  && ($2 <= 8000)) { print } }'  > wt_endo-embryo_CG_lolli10_r1.gz
gunzip -c wt_endo-embryo_CHG_lolli.gz | awk -F "\t" '{ if(($1 == "LWRW02000294_1") && ($2 >= 0)  && ($2 <= 8000)) { print } }'  > wt_endo-embryo_CHG_lolli10_r1.gz
gunzip -c wt_endo-embryo_CHH_lolli.gz | awk -F "\t" '{ if(($1 == "LWRW02000294_1") && ($2 >= 0)  && ($2 <= 8000)) { print } }'  > wt_endo-embryo_CHH_lolli10_r1.gz

cgmaptools lollipop -i wt_endo-embryo_CG_lolli10_r1.gz -b ~/references/sigma.bed
cgmaptools lollipop -i wt_endo-embryo_CHG_lolli10_r1.gz -b ~/references/sigma.bed
cgmaptools lollipop -i wt_endo-embryo_CHH_lolli10_r1.gz -b ~/references/sigma.bed

gunzip -c wt-mdr1_endo_CG_lolli.gz | awk -F "\t" '{ if(($1 == 10) && ($2 >= 73947000)  && ($2 <= 73957000)) { print } }'  > wt-mdr1_endo_CG_lolli10_myb155.gz
gunzip -c wt-mdr1_endo_CHG_lolli.gz | awk -F "\t" '{ if(($1 == 10) && ($2 >= 73947000)  && ($2 <= 73957000))  { print } }'  > wt-mdr1_endo_CHG_lolli10_myb155.gz
gunzip -c wt-mdr1_endo_CHH_lolli.gz | awk -F "\t" '{ if(($1 == 10) && ($2 >= 73947000)  && ($2 <= 73957000))  { print } }'  > wt-mdr1_endo_CHH_lolli10_myb155.gz

cgmaptools lollipop -i wt-mdr1_endo_CG_lolli10_myb155.gz -b ~/references/Zm00004b038748.bed
cgmaptools lollipop -i wt-mdr1_endo_CHG_lolli10_myb155.gz -b ~/references/Zm00004b038748.bed
cgmaptools lollipop -i wt-mdr1_endo_CHH_lolli10_myb155.gz -b ~/references/Zm00004b038748.bed

gunzip -c wt_endo-embryo_CG_lolli.gz | awk -F "\t" '{ if(($1 == 10) && ($2 >= 73947000)  && ($2 <= 73957000)) { print } }'  > wt_endo-embryo_CG_lolli10_myb155.gz
gunzip -c wt_endo-embryo_CHG_lolli.gz | awk -F "\t" '{ if(($1 == 10) && ($2 >= 73947000)  && ($2 <= 73957000))  { print } }'  > wt_endo-embryo_CHG_lolli10_myb155.gz
gunzip -c wt_endo-embryo_CHH_lolli.gz | awk -F "\t" '{ if(($1 == 10) && ($2 >= 73947000)  && ($2 <= 73957000))  { print } }'  > wt_endo-embryo_CHH_lolli10_myb155.gz

cgmaptools lollipop -i wt_endo-embryo_CG_lolli10_myb155.gz -b ~/references/Zm00004b038748.bed
cgmaptools lollipop -i wt_endo-embryo_CHG_lolli10_myb155.gz -b ~/references/Zm00004b038748.bed
cgmaptools lollipop -i wt_endo-embryo_CHH_lolli10_myb155.gz -b ~/references/Zm00004b038748.bed