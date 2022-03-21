#!/usr/bin/perl

my @files = <*methylEMRs.bed>;
for my $file (@files) {
    open out, '>', "$file.sh";
        print out "#!/bin/bash\n";
        print out "#SBATCH --job-name=$file\n";
        print out "#SBATCH --partition=batch\n";        
        print out "#SBATCH --ntasks=1\n";
        print out "#SBATCH --nodes=1\n";
        print out "#SBATCH --ntasks-per-node=1\n";
		print out "#SBATCH --constraint=AMD\n";
        print out "#SBATCH --time=3:00:00\n";
        print out "#SBATCH --mem=90gb\n";
		print out "module load BEDTools/2.29.2-GCC-8.3.0\n";
       	print out "module load SAMtools/1.9-GCC-8.3.0\n";
		print out "wc -l $file\n"; 		       			       	
		print out "bedtools intersect -u -f .5 -a $file -b ~/references/W22_knob180.bed | wc -l\n"; 
		print out "bedtools intersect -u -f .5 -a $file -b ~/references/W22_TR-1.bed | wc -l\n"; 
		print out "bedtools intersect -u -f .5 -a $file -b ~/references/W22_CentC.bed | wc -l\n"; 
		print out "bedtools intersect -u -f .5 -a $file -b ~/references/W22_Gypsy.gff | wc -l\n"; 
		print out "bedtools intersect -u -f .5 -a $file -b ~/references/W22_Copia.gff | wc -l\n"; 
		print out "bedtools intersect -u -f .5 -a $file -b ~/references/W22_CACTA.gff | wc -l\n"; 
		print out "bedtools intersect -u -f .5 -a $file -b ~/references/W22_mutator.gff | wc -l\n"; 
		print out "bedtools intersect -u -f .5 -a $file -b ~/references/W22_hAT.gff | wc -l\n"; 
		print out "bedtools intersect -u -f .5 -a $file -b ~/references/W22_harbinger.gff | wc -l\n"; 
		print out "bedtools intersect -u -f .5 -a $file -b ~/references/W22_mariner.gff | wc -l\n";
		print out "bedtools intersect -u -f .5 -a $file -b ~/references/W22_Helitrons.gff | wc -l\n";       			
		print out "bedtools intersect -u -f .5 -a $file -b ~/references/W22_synt_genes.gff | wc -l\n";
		print out "bedtools intersect -u -f .5 -a $file -b ~/references/W22_RIL.gff | wc -l\n"; 
		print out "bedtools intersect -u -f .5 -a $file -b ~/references/W22_RIT.gff | wc -l\n"; 
		print out "bedtools intersect -u -f .5 -a $file -b ~/references/W22_SINE.gff | wc -l\n"; 
		print out "bedtools intersect -u -f .5 -a $file -b ~/references/W22_genes.gff | wc -l\n";
		print out "bedtools intersect -u -f .5 -a $file -b ~/references/W22_CDS.gff | wc -l\n"; 
		print out "bedtools intersect -u -f .5 -a $file -b ~/references/W22_introns.gff | wc -l\n"; 
		print out "bedtools intersect -u -f .5 -a $file -b ~/references/W22_MEGs.gff | wc -l\n"; 
		print out "bedtools intersect -u -f .5 -a $file -b ~/references/W22_PEGs.gff | wc -l\n";
		print out "bedtools intersect -u -f .5 -a $file -b ~/references/W22_synt_MEGs.gff | wc -l\n"; 
		print out "bedtools intersect -u -f .5 -a $file -b ~/references/W22_synt_PEGs.gff | wc -l\n"; 
		print out "bedtools intersect -u -f .5 -a $file -b ~/references/W22_synt_TE_genes.gff | wc -l\n";
		print out "bedtools intersect -u -f .5 -a $file -b ~/references/W22_synt_endosperm_genes.gff | wc -l\n";
		print out "bedtools intersect -u -f .5 -a $file -b ~/references/W22_RLX.gff | wc -l\n";
		print out "bedtools intersect -u -f .5 -a $file -b wt_endo-embryo_hyperDMRs.bed | wc -l\n"; 
		print out "bedtools intersect -u -f .5 -a $file -b wt_endo-tassel_hyperDMRs.bed | wc -l\n";
		print out "bedtools intersect -u -f .5 -a $file -b wt_endo-J664_leaf_hyperDMRs.bed | wc -l\n"; 
		print out "bedtools intersect -u -f .5 -a $file -b wt-mdr1_mat_endo_hyperDMRs.bed | wc -l\n"; 
	    print "sbatch $file.sh\n";
        system "sbatch $file.sh";
}