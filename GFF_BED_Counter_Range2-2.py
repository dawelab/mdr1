#This script counts reads from a bed file that start within coordinates or set of coordinates determined by a GFF file. 
#It also counts the number of bases from each read that overlap with the coordinates or set of coordinates determined by a GFF file
#All bed files in the folder will be processed, one at a time. 
#WARNING coverage will be underestimated in adjacent bed features because if a read spans two features, only the left portion is counted.  
#Only coordinates on chromosomes 1 through 10 are considered. 
#The Bed file and the GFF file must be sorted by chromosome: 1 through 10, followed by non-numeric chromosomes
#This script is derived from GFF_BED_Counter_Range.py. 



##########################################################################################################
#USER INPUT 
##########################################################################################################

bin_size = 100 #length of bin in bp
bin_start = -1499 #start position of first bin relative to edge position of feature. "-" means upstream. Inclusive.
bin_end = 3000 #end position of last bin relative to edge of feature. "-" means upstream. Inclusive.

#location of input and output files
in_path = "/scratch/gent/regions"

#location and name of GFF file:
GFF_path = '/home/gent/references/W22_synt_genes.gff'

#file endings
ending = "MRs.bed"

#Which end?
upstream_edge = False #Indicates which edge of feature defines bins




##############################################################################################################
#I/O
##############################################################################################################

import glob
import os
os.chdir(in_path)


for filename in glob.glob(in_path + '/*' + ending):
	Bed_path = filename
	if upstream_edge:
		out_path = filename[:-len(ending)] + '_' + GFF_path[GFF_path.rindex('/') + 1:] + '_upstream.txt'
	else:
		out_path = filename[:-len(ending)] + '_' + GFF_path[GFF_path.rindex('/') + 1:] + '_downstream.txt'



	#GFF columns of interest
	GFF_start_col = 3
	GFF_end_col = 4 
	GFF_orient_col = 6

	################################################################################################################
	#Define Bed_Extractor to identify reads in each bin and write them to a new file
	################################################################################################################
	def Bed_Extractor(i):

		#I/O
		Bed_file = open(Bed_path) #File with reads
		GFF_file = open(GFF_path) #File with coordinates in GFF format
	
		#initialize sense_counter and antisense_counters
		sense_counter = 0
		antisense_counter = 0 
	
		#get first GFF_feature

		GFF_cols = GFF_file.readline().strip().split()
		try:
			GFF_chr = int(GFF_cols[0])
		except ValueError:
			GFF_chr = 1000000000000000000000000

		GFF_orient = GFF_cols[GFF_orient_col]
		if upstream_edge:
			if GFF_orient == '+':
				GFF_start = int(GFF_cols[GFF_start_col]) + (bin_start + i*bin_size)
			else:
				GFF_start = int(GFF_cols[GFF_end_col]) - (bin_start + (i+1)*bin_size - 1)
		else:
			if GFF_orient == '+':
				GFF_start  = int(GFF_cols[GFF_end_col]) + (bin_start + i*bin_size)
			else:
				GFF_start = int(GFF_cols[GFF_start_col]) - (bin_start + (i+1)*bin_size - 1)
		GFF_end = GFF_start + bin_size - 1	 
		
		#Bring in one line at a time from file with reads and parse out individivual columns
		for Bed_line in Bed_file:
			read_has_potential = False #assume this read is not from chromosome 1-10
			Bed_cols = Bed_line.strip().split('\t') 

			try:
				Bed_chr = int(Bed_cols[0])
				read_has_potential = True
			except ValueError:
				pass
			
			Bed_start = int(Bed_cols[1]) + 1
			Bed_end = int(Bed_cols[2]) 
			Bed_orient = Bed_cols[5]	
		
		
			#Determine whether read overlaps with a GFF feature
		
			if read_has_potential:
				while read_has_potential: 
			
					#check whether read is on the right chromosome
					if Bed_chr == GFF_chr: 
			
						#check whether read is far enough to the right
						if Bed_start >= GFF_start or Bed_end >= GFF_start:
					
							#check if read starts within GFF feature
							if Bed_start <= GFF_end:
								read_has_potential = False
								
								#CALCULATE OVERLAP
							
								#For sense
								if Bed_orient == GFF_orient:	
									if Bed_start < GFF_start:
										if Bed_end > GFF_end:
											sense_counter += GFF_end - GFF_start + 1 #read extends past both edge of GFF feature
										else:
											sense_counter += Bed_end - GFF_start + 1 #read extends past left edge of GFF feature	
									else:
										if Bed_end > GFF_end:
											sense_counter += GFF_end - Bed_start + 1 #read extends past right edge of GFF feature
										else:
											sense_counter += Bed_end - Bed_start + 1 #read is entirely contained within GFF feature
								
								#For antisense
								else:	
									if Bed_start < GFF_start:
										if Bed_end > GFF_end:
											antisense_counter += GFF_end - GFF_start + 1 #read extends past both edge of GFF feature
										else:
											antisense_counter += Bed_end - GFF_start + 1 #read extends past left edge of GFF feature	
									else:
										if Bed_end > GFF_end:
											antisense_counter += GFF_end - Bed_start + 1 #read extends past right edge of GFF feature
										else:
											antisense_counter += Bed_end - Bed_start + 1 #read is entirely contained within GFF feature					
															
						
						
							#if read starts past the end of GFF object, compare with next GFF feature
							else:
								#get the chromosome and coordinates from next GFF feature
								GFF_cols = GFF_file.readline().strip().split()
							
								if len(GFF_cols) > 0:
									try:
										GFF_chr = int(GFF_cols[0])
										GFF_orient = GFF_cols[GFF_orient_col]
										if upstream_edge:
											if GFF_orient == '+':
												GFF_start = int(GFF_cols[GFF_start_col]) + (bin_start + i*bin_size)
											else:
												GFF_start = int(GFF_cols[GFF_end_col]) - (bin_start + (i+1)*bin_size - 1)
										else:
											if GFF_orient == '+':
												GFF_start  = int(GFF_cols[GFF_end_col]) + (bin_start + i*bin_size)
											else:
												GFF_start = int(GFF_cols[GFF_start_col]) - (bin_start + (i+1)*bin_size - 1)
										GFF_end = GFF_start + bin_size - 1	 
									
									#if chromosome is Unknown, Mitochondria, or Chloroplast, 
									except ValueError:
										GFF_chr = 10000000000000000000000
										read_has_potential = False
								else:
									GFF_chr = 10000000000000000000000
									read_has_potential = False
								
						#if read is to the left of entire gff feature, break out of while loop and get next read 
						else:
							read_has_potential = False
			
					elif Bed_chr > GFF_chr:
						#get the chromosome and coordinates from next GFF feature
						GFF_cols = GFF_file.readline().strip().split()
						try:
							GFF_chr = int(GFF_cols[0])
							GFF_orient = GFF_cols[GFF_orient_col]
							if upstream_edge:
								if GFF_orient == '+':
									GFF_start = int(GFF_cols[GFF_start_col]) + (bin_start + i*bin_size)
								else:
									GFF_start = int(GFF_cols[GFF_end_col]) - (bin_start + (i+1)*bin_size - 1)
							else:
								if GFF_orient == '+':
									GFF_start  = int(GFF_cols[GFF_end_col]) + (bin_start + i*bin_size)
								else:
									GFF_start = int(GFF_cols[GFF_start_col]) - (bin_start + (i+1)*bin_size - 1)
							GFF_end = GFF_start + bin_size - 1	 
									
						#if chromosome is Unknown, Mitochondria, or Chloroplast, 
						except ValueError:
							GFF_chr = 10000000000000000000000
							read_has_potential = False
						
					#if there are no more features on Bed_chr, get new read
					else:
						read_has_potential = False

				#stop when first ten chromosomes are done. 
			#else:
			#	break

		out_file.write(str(bin_start + i*bin_size) + '\t' + str(sense_counter) + '\t' + str(antisense_counter) + '\t' + str(sense_counter + antisense_counter) + '\n')
	
		#close files
		Bed_file.close()
		GFF_file.close()


	#################################################################################################################
	#Run each bin through Bed_Extractor function
	################################################################################################################
	out_file = open(out_path, 'w') #Write-to file
	out_file.write('bin start\tsense overlap\tantisense overlap\ttotal overlap\n')

	for i in range((bin_end + 1 - bin_start)//bin_size):
		Bed_Extractor(i)
	


	################################################################################################################
	#Close I/O
	################################################################################################################
	out_file.close()

