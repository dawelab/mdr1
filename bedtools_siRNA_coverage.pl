#!/usr/bin/perl

my @files = <*.sub.siRNAs.bam>;
for my $file (@files) {

    open out, '>', "$file.sh";
        print out "#!/bin/bash\n";
        print out "#SBATCH --job-name=$file\n";
        print out "#SBATCH --partition=highmem_p\n";        
        print out "#SBATCH --ntasks=1\n";
        print out "#SBATCH --nodes=1\n";
        print out "#SBATCH --ntasks-per-node=1\n";
        print out "#SBATCH --time=1:00:00\n";
        print out "#SBATCH --mem=200gb\n";
        print out "#SBATCH --mail-user=gent@uga.edu\n";
        print out "#SBATCH --mail-type=BEGIN,END,NONE,FAIL,REQUEUE#SBATCH --mail-type=BEGIN,END,NONE,FAIL,REQUEUE\n";
       	print out "module load BEDTools/2.29.2-GCC-8.3.0\n";
		#print out "samtools view -t /scratch/gent/genomes/W22-REFERENCE-NRGENE-2.0.fasta.fai -o $file.bam $file\n";
		print out "bedtools coverage -F .9 -a /scratch/gent/regions/wt-mdr1_endo_hyperDMRs.bed -b $file > $file.mdr1_DMRs.cov\n";
		print out "bedtools coverage -F .9 -a /scratch/gent/regions/wt-mdr1_endo_EMRs.bed -b $file > $file.mdr1_EMRs.cov\n";
		print out "bedtools coverage -F .9 -a /scratch/gent/regions/wt_endo_CHH_MRs.bed -b $file > $file.CHH_MRs.cov\n";		
        print "qsub $file.sh\n";
    	system "qsub $file.sh";		
		close(out);	
}


