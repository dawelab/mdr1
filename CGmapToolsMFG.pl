#!/usr/bin/perl

my @files = <J644*.CGmap.gz>;
for my $file (@files) {
    open out, '>', "$file.sh";
        print out "#!/bin/bash\n";
        print out "#SBATCH --job-name=$file\n";
        print out "#SBATCH --partition=batch\n";        
        print out "#SBATCH --ntasks=1\n";
        print out "#SBATCH --nodes=1\n";
        print out "#SBATCH --ntasks-per-node=1\n";
		print out "#SBATCH --constraint=AMD\n";
        print out "#SBATCH --time=18:00:00\n";
        print out "#SBATCH --mem=10gb\n";
		print out "module load CGmapTools/0.1.2-foss-2019b\n";
		
		#print out "gunzip -c $file | cgmaptools mfg -r ~/references/W22_synt_genes_up.bed -c 1 -x CG > $file.W22_synt_genes.CG.up.mfg\n";
		#print out "gunzip -c $file | cgmaptools mfg -r ~/references/W22_synt_genes_up.bed -c 1 -x CHG > $file.W22_synt_genes.CHG.up.mfg\n";
		#print out "gunzip -c $file | cgmaptools mfg -r ~/references/W22_synt_genes_up.bed -c 1 -x CHH > $file.W22_synt_genes.CHH.up.mfg\n";

		#print out "gunzip -c $file | cgmaptools mfg -r ~/references/W22_synt_genes_down.bed -c 1 -x CG > $file.W22_synt_genes.CG.down.mfg\n";
		#print out "gunzip -c $file | cgmaptools mfg -r ~/references/W22_synt_genes_down.bed -c 1 -x CHG > $file.W22_synt_genes.CHG.down.mfg\n";
		#print out "gunzip -c $file | cgmaptools mfg -r ~/references/W22_synt_genes_down.bed -c 1 -x CHH > $file.W22_synt_genes.CHH.down.mfg\n";

		#print out "gunzip -c $file | cgmaptools mfg -r ~/references/W22_Gypsy_intact_up.bed -c 1 -x CG > $file.W22_Gypsy_intact.CG.up.mfg\n";
		#print out "gunzip -c $file | cgmaptools mfg -r ~/references/W22_Gypsy_intact_up.bed -c 1 -x CHG > $file.W22_Gypsy_intact.CHG.up.mfg\n";
		#print out "gunzip -c $file | cgmaptools mfg -r ~/references/W22_Gypsy_intact_up.bed -c 1 -x CHH > $file.W22_Gypsy_intact.CHH.up.mfg\n";

		#print out "gunzip -c $file | cgmaptools mfg -r ~/references/W22_Gypsy_intact_down.bed -c 1 -x CG > $file.W22_Gypsy_intact.CG.down.mfg\n";
		#print out "gunzip -c $file | cgmaptools mfg -r ~/references/W22_Gypsy_intact_down.bed -c 1 -x CHG > $file.W22_Gypsy_intact.CHG.down.mfg\n";
		#print out "gunzip -c $file | cgmaptools mfg -r ~/references/W22_Gypsy_intact_down.bed -c 1 -x CHH > $file.W22_Gypsy_intact.CHH.down.mfg\n";

		#print out "gunzip -c $file | cgmaptools mfg -r /scratch/gent/regions/wt_endo-embryo_hyperDMRs_UP_sort.bed -c 1 -x CG > $file.wt_endo-embryo_hyperDMR.CG.up.mfg\n";
		#print out "gunzip -c $file | cgmaptools mfg -r /scratch/gent/regions/wt_endo-embryo_hyperDMRs_UP_sort.bed -c 1 -x CHG > $file.wt_endo-embryo_hyperDMR.CHG.up.mfg\n";
		#print out "gunzip -c $file | cgmaptools mfg -r /scratch/gent/regions/wt_endo-embryo_hyperDMRs_UP_sort.bed -c 1 -x CHH > $file.wt_endo-embryo_hyperDMR.CHH.up.mfg\n";

		#print out "gunzip -c $file | cgmaptools mfg -r /scratch/gent/regions/wt_endo-embryo_hyperDMRs_DOWN_sort.bed -c 1 -x CG > $file.wt_endo-embryo_hyperDMR.CG.down.mfg\n";
		#print out "gunzip -c $file | cgmaptools mfg -r /scratch/gent/regions/wt_endo-embryo_hyperDMRs_DOWN_sort.bed -c 1 -x CHG > $file.wt_endo-embryo_hyperDMR.CHG.down.mfg\n";
		#print out "gunzip -c $file | cgmaptools mfg -r /scratch/gent/regions/wt_endo-embryo_hyperDMRs_DOWN_sort.bed -c 1 -x CHH > $file.wt_endo-embryo_hyperDMR.CHH.down.mfg\n";

		print out "gunzip -c $file | cgmaptools mfg -r /scratch/gent/regions/wt-mdr1_endo_hyperDMRs_UP_sort.bed -c 1 -x CG > $file.wt-mdr1_endo_hyperDMR.CG.up.mfg\n";
		print out "gunzip -c $file | cgmaptools mfg -r /scratch/gent/regions/wt-mdr1_endo_hyperDMRs_UP_sort.bed -c 1 -x CHG > $file.wt-mdr1_endo_hyperDMR.CHG.up.mfg\n";
		print out "gunzip -c $file | cgmaptools mfg -r /scratch/gent/regions/wt-mdr1_endo_hyperDMRs_UP_sort.bed -c 1 -x CHH > $file.wt-mdr1_endo_hyperDMR.CHH.up.mfg\n";

		print out "gunzip -c $file | cgmaptools mfg -r /scratch/gent/regions/wt-mdr1_endo_hyperDMRs_DOWN_sort.bed -c 1 -x CG > $file.wt-mdr1_endo_hyperDMR.CG.down.mfg\n";
		print out "gunzip -c $file | cgmaptools mfg -r /scratch/gent/regions/wt-mdr1_endo_hyperDMRs_DOWN_sort.bed -c 1 -x CHG > $file.wt-mdr1_endo_hyperDMR.CHG.down.mfg\n";
		print out "gunzip -c $file | cgmaptools mfg -r /scratch/gent/regions/wt-mdr1_endo_hyperDMRs_DOWN_sort.bed -c 1 -x CHH > $file.wt-mdr1_endo_hyperDMR.CHH.down.mfg\n";

	    #print out "gunzip -c $file | cgmaptools mfg -r /scratch/gent/regions/wt_endo-embryo_EMRs_UP_sort.bed -c 1 -x CG > $file.wt_endo-embryo_EMR.CG.up.mfg\n";
		#print out "gunzip -c $file | cgmaptools mfg -r /scratch/gent/regions/wt_endo-embryo_EMRs_UP_sort.bed -c 1 -x CHG > $file.wt_endo-embryo_EMR.CHG.up.mfg\n";
		#print out "gunzip -c $file | cgmaptools mfg -r /scratch/gent/regions/wt_endo-embryo_EMRs_UP_sort.bed -c 1 -x CHH > $file.wt_endo-embryo_EMR.CHH.up.mfg\n";

		#print out "gunzip -c $file | cgmaptools mfg -r /scratch/gent/regions/wt_endo-embryo_EMRs_DOWN_sort.bed -c 1 -x CG > $file.wt_endo-embryo_EMR.CG.down.mfg\n";
		#print out "gunzip -c $file | cgmaptools mfg -r /scratch/gent/regions/wt_endo-embryo_EMRs_DOWN_sort.bed -c 1 -x CHG > $file.wt_endo-embryo_EMR.CHG.down.mfg\n";
		#print out "gunzip -c $file | cgmaptools mfg -r /scratch/gent/regions/wt_endo-embryo_EMRs_DOWN_sort.bed -c 1 -x CHH > $file.wt_endo-embryo_EMR.CHH.down.mfg\n";

		print out "gunzip -c $file | cgmaptools mfg -r /scratch/gent/regions/wt-mdr1_endo_EMRs_UP_sort.bed -c 1 -x CG > $file.wt-mdr1_endo_EMR.CG.up.mfg\n";
		print out "gunzip -c $file | cgmaptools mfg -r /scratch/gent/regions/wt-mdr1_endo_EMRs_UP_sort.bed -c 1 -x CHG > $file.wt-mdr1_endo_EMR.CHG.up.mfg\n";
		print out "gunzip -c $file | cgmaptools mfg -r /scratch/gent/regions/wt-mdr1_endo_EMRs_UP_sort.bed -c 1 -x CHH > $file.wt-mdr1_endo_EMR.CHH.up.mfg\n";

		print out "gunzip -c $file | cgmaptools mfg -r /scratch/gent/regions/wt-mdr1_endo_EMRs_DOWN_sort.bed -c 1 -x CG > $file.wt-mdr1_endo_EMR.CG.down.mfg\n";
		print out "gunzip -c $file | cgmaptools mfg -r /scratch/gent/regions/wt-mdr1_endo_EMRs_DOWN_sort.bed -c 1 -x CHG > $file.wt-mdr1_endo_EMR.CHG.down.mfg\n";
		print out "gunzip -c $file | cgmaptools mfg -r /scratch/gent/regions/wt-mdr1_endo_EMRs_DOWN_sort.bed -c 1 -x CHH > $file.wt-mdr1_endo_EMR.CHH.down.mfg\n";


	    print "sbatch $file.sh\n";
        system "sbatch $file.sh";
}