#!/usr/bin/perl

my @files = <*.gz.trimmed.fastq.gz.bam>;
for my $file (@files) {

    open out, '>', "$file.sh";
        print out "#!/bin/bash\n";
        print out "#SBATCH --job-name=$file\n";
        print out "#SBATCH --partition=batch\n";        
        print out "#SBATCH --ntasks=1\n";
        print out "#SBATCH --nodes=1\n";
        print out "#SBATCH --ntasks-per-node=12\n";
		print out "#SBATCH --constraint=AMD\n";
        print out "#SBATCH --time=48:00:00\n";
        print out "#SBATCH --mem=50gb\n";
        print out "#SBATCH --mail-user=gent@uga.edu\n";
        print out "#SBATCH --mail-type=BEGIN,END,NONE,FAIL,REQUEUE#SBATCH --mail-type=BEGIN,END,NONE,FAIL,REQUEUE\n";
       	print out "module load Bowtie2/2.4.1-GCC-8.3.0\n";
       	print out "module load SAMtools/1.10-iccifort-2019.5.281\n";
       	print out "module load BEDTools/2.29.2-GCC-8.3.0\n";
		
		print out "bedtools intersect -v -f .9 -a $file -b ~/references/W22_miRNA.bed > $file.miRF.bam\n";
		print out "bedtools intersect -v -f .9 -a $file.miRF.bam -b ~/references/rice_tRNA.bed > $file.miRF_tRNAF.bam\n";
		print out "bedtools intersect -v -f .9 -a $file.miRF_tRNAF.bam -b ~/references/W22_NOR.bed > $file.miRF_tRNAF_NORF.bam\n";		
		print out "bedtools intersect -v -f .9 -a $file.miRF_tRNAF_NORF.bam -b ~/references/W22_5S_rRNA.bed > $file.siRNAs.bam\n";		
		print out "bedtools intersect -v -f .9 -a $file.miRF_tRNAF_NORF.bam -b ~/references/W22_5S_rRNA.bed > $file.siRNAs.bam\n";		
		print out "samtools view -h -q20 -o $file.siRNAs.q20.bam $file.siRNAs.bam\n";

		print out "samtools view -h -o $file.siRNAs.sam $file.siRNAs.bam\n";
		print out "samtools view -h -o $file.siRNAs.q20.sam $file.siRNAs.q20.bam\n";


		print out "bedtools intersect -f .9 -a $file.siRNAs.bam -b /scratch/gent/regions/wt-mdr1_endo_hyperDMRs.bed > $file.mdr1_DMR_siRNAs.bam\n";		
		print out "bedtools intersect -f .9 -a $file.siRNAs.q20.bam -b /scratch/gent/regions/wt-mdr1_endo_hyperDMRs.bed > $file.mdr1_DMR_siRNAs.q20.bam\n";		
		print out "samtools view -h -o $file.siRNAs.sam $file.siRNAs.bam\n";
		print out "samtools view -h -o $file.siRNAs.q20.sam $file.siRNAs.q20.bam\n";
		print out "samtools view -h -o $file.mdr1_DMR_siRNAs.sam $file.mdr1_DMR_siRNAs.bam\n";
		print out "samtools view -h -o $file.mdr1_DMR_siRNAs.q20.sam $file.mdr1_DMR_siRNAs.q20.bam\n";


		print out "bedtools coverage -F .9 -a ~/references/W22_miRNA.bed -b $file > $file.miR.cov\n";
		
		
		
		print out "samtools view -c $file\n";
		print out "samtools view -c $file.miRF.bam\n";
		print out "samtools view -c $file.miRF_tRNAF.bam\n";
		print out "samtools view -c $file.miRF_tRNAF_NORF.bam\n";
		print out "samtools view -c $file.siRNAs.bam\n";
		print out "samtools view -c $file.siRNAs.q20.bam\n";

		print out "rm $file.miRF_tRNAF_NORF.bam\n";		    		        
		print out "rm $file.miRF_tRNAF.bam\n";		    		        
		print out "rm $file.miRF.bam\n";		    		        
	
        print "qsub $file.sh\n";
    	system "qsub $file.sh";		
		close(out);	
}