#!/bin/bash
#SBATCH --job-name=merge
#SBATCH --partition=batch
#SBATCH --ntasks=1
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --constraint=AMD
#SBATCH --time=24:00:00
#SBATCH --mem=50gb
module load SAMtools/1.9-GCC-8.3.0		
samtools merge w-EN.siRNAs.bam w1-EN-sRNA_R1_001.fastq.gz.trimmed.fastq.gz.bam.siRNAs.bam w2-EN-sRNA_R1_001.fastq.gz.trimmed.fastq.gz.bam.siRNAs.bam w3-EN-sRNA_R1_001.fastq.gz.trimmed.fastq.gz.bam.siRNAs.bam
samtools merge m-EN.siRNAs.bam m1-EN-sRNA_R1_001.fastq.gz.trimmed.fastq.gz.bam.siRNAs.bam m2-EN-sRNA_R1_001.fastq.gz.trimmed.fastq.gz.bam.siRNAs.bam m4-EN-sRNA_R1_001.fastq.gz.trimmed.fastq.gz.bam.siRNAs.bam
samtools merge w-EM.siRNAs.bam w1-EM-sRNA_R1_001.fastq.gz.trimmed.fastq.gz.bam.siRNAs.bam w2-EM-sRNA_R1_001.fastq.gz.trimmed.fastq.gz.bam.siRNAs.bam w3-EM-sRNA_R1_001.fastq.gz.trimmed.fastq.gz.bam.siRNAs.bam
samtools merge m-EM.siRNAs.bam m1-EM-sRNA_R1_001.fastq.gz.trimmed.fastq.gz.bam.siRNAs.bam m2-EM-sRNA_R1_001.fastq.gz.trimmed.fastq.gz.bam.siRNAs.bam m4-EM-sRNA_R1_001.fastq.gz.trimmed.fastq.gz.bam.siRNAs.bam
samtools merge J500s.siRNAs.bam J500s_1_S4_R1_001.fastq.gz.trimmed.fastq.gz.bam.siRNAs.bam J500s_2_S5_R1_001.fastq.gz.trimmed.fastq.gz.bam.siRNAs.bam J500s_3_S6_R1_001.fastq.gz.trimmed.fastq.gz.bam.siRNAs.bam
samtools merge J500m.siRNAs.bam J500m_1_S1_R1_001.fastq.gz.trimmed.fastq.gz.bam.siRNAs.bam J500m_2_S2_R1_001.fastq.gz.trimmed.fastq.gz.bam.siRNAs.bam J500m_3_S3_R1_001.fastq.gz.trimmed.fastq.gz.bam.siRNAs.bam

samtools view -c w-EN.siRNAs.bam
samtools view -c m-EN.siRNAs.bam
samtools view -c w-EM.siRNAs.bam
samtools view -c m-EM.siRNAs.bam
samtools view -c J500s.siRNAs.bam
samtools view -c J500m.siRNAs.bam

samtools view -h -s 0.8564 -o w-EN.sub.siRNAs.bam w-EN.siRNAs.bam
samtools view -h -s 0.4241 -o m-EN.sub.siRNAs.bam m-EN.siRNAs.bam
samtools view -h -s 0.3550 -o w-EM.sub.siRNAs.bam w-EM.siRNAs.bam
samtools view -h -s 0.4722 -o m-EM.sub.siRNAs.bam m-EM.siRNAs.bam
samtools view -h -s 0.3861 -o J500s.sub.siRNAs.bam J500s.siRNAs.bam
samtools view -h -s 0.4298 -o J500m.sub.siRNAs.bam J500m.siRNAs.bam

samtools view -c w-EN.sub.siRNAs.bam
samtools view -c m-EN.sub.siRNAs.bam
samtools view -c w-EM.sub.siRNAs.bam
samtools view -c m-EM.sub.siRNAs.bam
samtools view -c J500s.sub.siRNAs.bam
samtools view -c J500m.sub.siRNAs.bam


#samtools view -o w-EN.siRNAs.sam w-EN.siRNAs.bam
#samtools view -o m-EN.siRNAs.sam m-EN.siRNAs.bam
#samtools view -o w-EM.siRNAs.sam w-EM.siRNAs.bam
#samtools view -o m-EM.siRNAs.sam m-EM.siRNAs.bam
#samtools view -o J500s.siRNAs.sam J500s.siRNAs.bam
#samtools view -o J500m.siRNAs.sam J500m.siRNAs.bam

#samtools view -q20 -o w-EN.siRNAs.q20.sam w-EN.siRNAs.bam
#samtools view -q20 -o m-EN.siRNAs.q20.sam m-EN.siRNAs.bam
#samtools view -q20 -o w-EM.siRNAs.q20.sam w-EM.siRNAs.bam
#samtools view -q20 -o m-EM.siRNAs.q20.sam m-EM.siRNAs.bam
#samtools view -q20 -o J500s.siRNAs.q20.sam J500s.siRNAs.bam
#samtools view -q20 -o J500m.siRNAs.q20.sam J500m.siRNAs.bam
