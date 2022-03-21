#!/usr/bin/perl

my @files = <*fastq.gz>;
for my $file (@files) {

    open out, '>', "$file.sh";
        print out "#!/bin/bash\n";
        print out "#SBATCH --job-name=$file\n";
        print out "#SBATCH --partition=batch\n";        
        print out "#SBATCH --ntasks=1\n";
        print out "#SBATCH --nodes=1\n";
        print out "#SBATCH --ntasks-per-node=1\n";
		print out "#SBATCH --constraint=AMD\n";
        print out "#SBATCH --time=50:00:00\n";
        print out "#SBATCH --mem=20gb\n";
        print out "#SBATCH --mail-user=gent@uga.edu\n";
        print out "#SBATCH --mail-type=BEGIN,END,NONE,FAIL,REQUEUE#SBATCH --mail-type=BEGIN,END,NONE,FAIL,REQUEUE\n";
		print out "module load cutadapt/2.8-GCCcore-8.3.0-Python-3.7.4\n";
      	print out "cutadapt -q 20 -a TGGAATTCTCGGGTGCCAAGG -e .05 -O 5 --discard-untrimmed -m 28 -M 33 -o $file.adapter_trimmed.fastq $file\n";
		print out "cutadapt -u 4 -o $file.mostly_trimmed.fastq.gz  $file.adapter_trimmed.fastq\n";
		print out "cutadapt -u -4 -o $file.trimmed.fastq.gz  $file.mostly_trimmed.fastq.gz\n";
		print out "cutadapt -o $file.trimmed.fasta $file.trimmed.fastq.gz\n";
		print out "rm $file*_trimmed*\n";		
        print "qsub $file.sh\n";
    	system "qsub $file.sh";		
		close(out);	
}