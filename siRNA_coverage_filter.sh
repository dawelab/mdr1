#!/bin/bash
#SBATCH --job-name=coverage_filter
#SBATCH --partition=batch
#SBATCH --ntasks=1
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --constraint=AMD
#SBATCH --time=1:00:00
#SBATCH --mem=50gb
#SBATCH --mail-user=gent.edu
#SBATCH --mail-type=BEGIN,END,NONE,FAIL,REQUEUE#SBATCH --mail-type=BEGIN,END,NONE,FAIL,REQUEUE

awk '{ if ($8 >= 50) { print } }' w-EN.sub.siRNAs.bam.CHH_MRs.cov > w-EN.sub.siRNAs.bam.CHH_MRs.50.cov
awk '{ if ($10 >= 50) { print } }' w-EN.sub.siRNAs.bam.mdr1_DMRs.cov > w-EN.sub.siRNAs.bam.mdr1_DMRs.50.cov
awk '{ if ($10 >= 50) { print } }' w-EN.sub.siRNAs.bam.mdr1_EMRs.cov > w-EN.sub.siRNAs.bam.mdr1_EMRs.50.cov

awk '{ if ($8 >= 50) { print } }' m-EN.sub.siRNAs.bam.CHH_MRs.cov > m-EN.sub.siRNAs.bam.CHH_MRs.50.cov
awk '{ if ($10 >= 50) { print } }' m-EN.sub.siRNAs.bam.mdr1_DMRs.cov > m-EN.sub.siRNAs.bam.mdr1_DMRs.50.cov
awk '{ if ($10 >= 50) { print } }' m-EN.sub.siRNAs.bam.mdr1_EMRs.cov > m-EN.sub.siRNAs.bam.mdr1_EMRs.50.cov

awk '{ if ($8 >= 50) { print } }' w-EM.sub.siRNAs.bam.CHH_MRs.cov > w-EM.sub.siRNAs.bam.CHH_MRs.50.cov
awk '{ if ($10 >= 50) { print } }' w-EM.sub.siRNAs.bam.mdr1_DMRs.cov > w-EM.sub.siRNAs.bam.mdr1_DMRs.50.cov
awk '{ if ($10 >= 50) { print } }' w-EM.sub.siRNAs.bam.mdr1_EMRs.cov > w-EM.sub.siRNAs.bam.mdr1_EMRs.50.cov

awk '{ if ($8 >= 50) { print } }' m-EM.sub.siRNAs.bam.CHH_MRs.cov > m-EM.sub.siRNAs.bam.CHH_MRs.50.cov
awk '{ if ($10 >= 50) { print } }' m-EM.sub.siRNAs.bam.mdr1_DMRs.cov > m-EM.sub.siRNAs.bam.mdr1_DMRs.50.cov
awk '{ if ($10 >= 50) { print } }' m-EM.sub.siRNAs.bam.mdr1_EMRs.cov > m-EM.sub.siRNAs.bam.mdr1_EMRs.50.cov

awk '{ if ($8 >= 50) { print } }' J500s.sub.siRNAs.bam.CHH_MRs.cov > J500s.sub.siRNAs.bam.CHH_MRs.50.cov
awk '{ if ($10 >= 50) { print } }' J500s.sub.siRNAs.bam.mdr1_DMRs.cov > J500s.sub.siRNAs.bam.mdr1_DMRs.50.cov
awk '{ if ($10 >= 50) { print } }' J500s.sub.siRNAs.bam.mdr1_EMRs.cov > J500s.sub.siRNAs.bam.mdr1_EMRs.50.cov

awk '{ if ($8 >= 50) { print } }' J500m.sub.siRNAs.bam.CHH_MRs.cov > J500m.sub.siRNAs.bam.CHH_MRs.50.cov
awk '{ if ($10 >= 50) { print } }' J500m.sub.siRNAs.bam.mdr1_DMRs.cov > J500m.sub.siRNAs.bam.mdr1_DMRs.50.cov
awk '{ if ($10 >= 50) { print } }' J500m.sub.siRNAs.bam.mdr1_EMRs.cov > J500m.sub.siRNAs.bam.mdr1_EMRs.50.cov

awk '{ if ($7 == 0) { print } }' w-EN.sub.siRNAs.bam.CHH_MRs.cov > w-EN.sub.siRNAs.bam.CHH_MRs.0.cov
awk '{ if ($9 == 0) { print } }' w-EN.sub.siRNAs.bam.mdr1_DMRs.cov > w-EN.sub.siRNAs.bam.mdr1_DMRs.0.cov
awk '{ if ($9 == 0) { print } }' w-EN.sub.siRNAs.bam.mdr1_EMRs.cov > w-EN.sub.siRNAs.bam.mdr1_EMRs.0.cov

awk '{ if ($7 == 0) { print } }' m-EN.sub.siRNAs.bam.CHH_MRs.cov > m-EN.sub.siRNAs.bam.CHH_MRs.0.cov
awk '{ if ($9 == 0) { print } }' m-EN.sub.siRNAs.bam.mdr1_DMRs.cov > m-EN.sub.siRNAs.bam.mdr1_DMRs.0.cov
awk '{ if ($9 == 0) { print } }' m-EN.sub.siRNAs.bam.mdr1_EMRs.cov > m-EN.sub.siRNAs.bam.mdr1_EMRs.0.cov

awk '{ if ($7 == 0) { print } }' w-EM.sub.siRNAs.bam.CHH_MRs.cov > w-EM.sub.siRNAs.bam.CHH_MRs.0.cov
awk '{ if ($9 == 0) { print } }' w-EM.sub.siRNAs.bam.mdr1_DMRs.cov > w-EM.sub.siRNAs.bam.mdr1_DMRs.0.cov
awk '{ if ($9 == 0) { print } }' w-EM.sub.siRNAs.bam.mdr1_EMRs.cov > w-EM.sub.siRNAs.bam.mdr1_EMRs.0.cov

awk '{ if ($7 == 0) { print } }' m-EM.sub.siRNAs.bam.CHH_MRs.cov > m-EM.sub.siRNAs.bam.CHH_MRs.0.cov
awk '{ if ($9 == 00) { print } }' m-EM.sub.siRNAs.bam.mdr1_DMRs.cov > m-EM.sub.siRNAs.bam.mdr1_DMRs.0.cov
awk '{ if ($9 == 0) { print } }' m-EM.sub.siRNAs.bam.mdr1_EMRs.cov > m-EM.sub.siRNAs.bam.mdr1_EMRs.0.cov

awk '{ if ($7 == 0) { print } }' J500s.sub.siRNAs.bam.CHH_MRs.cov > J500s.sub.siRNAs.bam.CHH_MRs.0.cov
awk '{ if ($9 == 0) { print } }' J500s.sub.siRNAs.bam.mdr1_DMRs.cov > J500s.sub.siRNAs.bam.mdr1_DMRs.0.cov
awk '{ if ($9 == 0) { print } }' J500s.sub.siRNAs.bam.mdr1_EMRs.cov > J500s.sub.siRNAs.bam.mdr1_EMRs.0.cov

awk '{ if ($7 == 0) { print } }' J500m.sub.siRNAs.bam.CHH_MRs.cov > J500m.sub.siRNAs.bam.CHH_MRs.0.cov
awk '{ if ($9 == 0) { print } }' J500m.sub.siRNAs.bam.mdr1_DMRs.cov > J500m.sub.siRNAs.bam.mdr1_DMRs.0.cov
awk '{ if ($9 == 0) { print } }' J500m.sub.siRNAs.bam.mdr1_EMRs.cov > J500m.sub.siRNAs.bam.mdr1_EMRs.0.cov

wc -l *.sub.siRNAs.*.cov > coverage_counts.txt