#!/bin/bash
#SBATCH --job-name=GFF_BED_COunter_Range1
#SBATCH --partition=batch
#SBATCH --ntasks=1
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --constraint=AMD
#SBATCH --time=100:00:00
#SBATCH --mem=2gb
#SBATCH --mail-user=gent@uga.edu
#SBATCH --mail-type=BEGIN,END,NONE,FAIL,REQUEUE

python3 GFF_BED_Counter_Range2-1.py
