#!/bin/bash
#SBATCH --job-name=CGmapTools_merge
#SBATCH --partition=batch
#SBATCH --ntasks=1
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --constraint=AMD
#SBATCH --time=60:00:00
#SBATCH --mem=50gb
#SBATCH --mail-user=gent@uga.edu
#SBATCH --mail-type=BEGIN,END,NONE,FAIL,REQUEUE

module load CGmapTools/0.1.2-foss-2019b

#cgmaptools merge2 cgmap -1 J500s_1_S1.W22.CGmap.gz -2 J500s_2_S2.W22.CGmap.gz | gzip > J500s_tassel_temp.CGmap.gz
#cgmaptools merge2 cgmap -1 J500s_tassel_temp.CGmap.gz -2 J500s_3_S3.W22.CGmap.gz | gzip > J500s_tassel.CGmap.gz

#cgmaptools merge2 cgmap -1 J500m-1-2.W22.CGmap.gz -2 J500m_2_S5.W22.CGmap.gz | gzip > J500m_tassel_temp.CGmap.gz
#cgmaptools merge2 cgmap -1 J500m_tassel_temp.CGmap.gz -2 J500m_3_S6.W22.CGmap.gz | gzip > J500m_tassel.CGmap.gz

#cgmaptools merge2 cgmap -1 J306_self_rep1_S29.W22.CGmap.gz -2 J306_self_rep2_S30.W22.CGmap.gz -o J306_leaf_temp.CGmap.gz
#cgmaptools merge2 cgmap -1 J306_leaf_temp.CGmap.gz -2 J306_self_rep3_S31.W22.CGmap.gz | gzip > J306_leaf.CGmap.gz

#cgmaptools merge2 cgmap -1 J272_self_rep1_S26.W22.CGmap.gz -2 J272_self_rep2_S27.W22.CGmap.gz -o J272_leaf_temp.CGmap.gz
#cgmaptools merge2 cgmap -1 J272_leaf_temp.CGmap.gz -2 J272_self_rep3_S28.W22.CGmap.gz | gzip > J272_leaf.CGmap.gz

#cgmaptools merge2 cgmap -1 J664-leaf-rep1.CGmap.gz -2 J664-leaf-rep2.CGmap.gz | gzip > J664_leaf_temp.CGmap.gz
#cgmaptools merge2 cgmap -1 J664_leaf_temp.CGmap.gz -2 J664-EN-rep3.CGmap.gz | gzip > J664_leaf.CGmap.gz

#cgmaptools merge2 cgmap -1 J306_leaf.CGmap.gz -2 J664_leaf.CGmap.gz | gzip > w_leaf.CGmap.gz

#cgmaptools merge2 cgmap -1 wt-endo-21.W22.CGmap.gz -2 wt-endo-28.W22.CGmap.gz | gzip > Mdr1-EN_temp.CGmap.gz
#cgmaptools merge2 cgmap -1 Mdr1-EN_temp.CGmap.gz -2 wt-endo-44.W22.CGmap.gz | gzip > Mdr1-EN.CGmap.gz

#cgmaptools merge2 cgmap -1 mdr1-endo-10.W22.CGmap.gz -2 mdr1-endo-35.W22.CGmap.gz | gzip > mdr1-EN_temp.CGmap.gz
#cgmaptools merge2 cgmap -1 mdr1-EN_temp.CGmap.gz -2 mdr1-endo-36.W22.CGmap.gz | gzip > mdr1-EN.CGmap.gz

#cgmaptools merge2 cgmap -1 J664-EN-rep2.CGmap.gz -2 J664-EN-rep3.CGmap.gz | gzip > J664-EN-rep2-3-combined.CGmap.gz

#cgmaptools merge2 cgmap -1 w1-EN.CGmap.gz -2 w2-EN.CGmap.gz | gzip > w-EN_temp.CGmap.gz
#cgmaptools merge2 cgmap -1 w-EN_temp.CGmap.gz -2 w3-EN.CGmap.gz | gzip > w-EN.CGmap.gz

#cgmaptools merge2 cgmap -1 m1-EN.CGmap.gz -2 m2-EN.CGmap.gz | gzip > m-EN_temp.CGmap.gz
#cgmaptools merge2 cgmap -1 m-EN_temp.CGmap.gz -2 m4-EN.CGmap.gz | gzip > m-EN.CGmap.gz

#cgmaptools merge2 cgmap -1 w1-EM.CGmap.gz -2 w2-EM.CGmap.gz | gzip > w-EM_temp.CGmap.gz
#cgmaptools merge2 cgmap -1 w-EM_temp.CGmap.gz -2 w3-EM.CGmap.gz | gzip > w-EM.CGmap.gz

#cgmaptools merge2 cgmap -1 m1-EM.CGmap.gz -2 m2-EM.CGmap.gz | gzip > m-EM_temp.CGmap.gz
#cgmaptools merge2 cgmap -1 m-EM_temp.CGmap.gz -2 m4-EM.CGmap.gz | gzip > m-EM.CGmap.gz

#cgmaptools merge2 cgmap -1 J658-EN-7.CGmap.gz -2 J658-EN-9.CGmap.gz | gzip > dng102-EN_temp.CGmap.gz
#cgmaptools merge2 cgmap -1 dng102-EN_temp.CGmap.gz -2 J658-EN-19.CGmap.gz | gzip > dng102-EN.CGmap.gz
