#this script counts read lengths from a sam file.
#it works on all files in a folder with the same ending
#it also counts the number of reads of each length and makes a summary of all files

##########################################################################################################
#USER INPUT 
##########################################################################################################


#sam folder
sam_folder = '/scratch/gent/siRNAs/'
 
#sam endings
ending = '.siRNAs.q20.sam'

#read lengths to count
min_length = 20
max_length = 25

#read lengths to extract into new files has to be entered below,
lengthA = 21
lengthB = 22
lengthC = 24
 

import glob
import os
os.chdir(sam_folder) 


#prep summary file
summary_path = sam_folder + '/' + 'lengths_summary' + ending + '.txt'
summary_file = open(summary_path, 'w')
summary_file.write('')
for l in range(min_length,max_length+1):
	summary_file.write('\t' + str(l))
summary_file.write('\n')



for filename in glob.glob('*' + ending):
	
	#INITIALIZE VARIABLES AND OPEN FILES
	counts = [0 for l in range(max_length + 1)]

	inFile = open(filename)

	
	#RUN THROUGH INPUT FILE, COUNT AND SORT READS
	
	for line in inFile:
		#skip header lines
		if line[0] == '@':
			pass
		#filter and count read lines
		else:
			read_length = len(line.split()[9])
			
			if read_length >= min_length:
				if read_length <= max_length:
					#increment read count
					counts[read_length] += 1 
			
	
	#WRITE LENGTH COUNTS TO SUMMARY FILE
	
	summary_file.write(filename)
	for l in range(min_length,max_length+1):
		summary_file.write('\t' + str(counts[l]))
	summary_file.write('\n')
	
	
	#CLOSE FILES
		
summary_file.close()

	
	