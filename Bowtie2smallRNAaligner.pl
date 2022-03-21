#!/usr/bin/perl

my @files = <*.trimmed.fastq.gz>;
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
        print out "#SBATCH --mem=10gb\n";
        print out "#SBATCH --mail-user=gent@uga.edu\n";
        print out "#SBATCH --mail-type=BEGIN,END,NONE,FAIL,REQUEUE#SBATCH --mail-type=BEGIN,END,NONE,FAIL,REQUEUE\n";
       	print out "module load Bowtie2/2.4.1-GCC-8.3.0\n";
       	print out "module load SAMtools/1.10-iccifort-2019.5.281\n";
       	#print out "module load BEDTools/2.29.2-GCC-8.3.0\n";
		print out "bowtie2 --very-sensitive -p 12 -x /scratch/gent/genomes/W22-REFERENCE-NRGENE-2.0.fasta -U $file | samtools view -F 4 -h -o $file.unsorted.bam\n";
		print out "samtools sort -o $file.bam $file.unsorted.bam\n";
        print "qsub $file.sh\n";
    	system "qsub $file.sh";		
		close(out);	
}

