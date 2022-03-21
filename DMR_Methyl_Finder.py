#This script will divide a CGmapTools intersect file into bins of a defined size
#and find bins that are differentially methylated between the two input maps (DMRs).
#Only bins passing coverage criteria will be considered. 
#Methylation is calculated as average of the methylation values of all cytosines in region, not weighted by number of reads
#All bins with passing coverage AND at sufficient level of methylation in at least one of the two samples to be called a DMR will also be output as eligible methylation regions (EMRs)
#Output formats for each region as follows:
#1 Chromosome
#2 Start position (0-based)
#3 End position (exclusive)
#4 Sample1 methylation
#5 Sample2 methylation
#6 Sample1 coverage
#7 Sample2 coverage
#8 informative cytosines

###############################################################################
#USER INPUT
###############################################################################

#Input file name and path
inPath = '/scratch/gent/merged_maps/wt-mdr1_endo_CHG.gz'

#prefix for output files 
outPrefix = 'wt-mdr1_endo_CHG_3X'

#Region size in bp. (larger than read length means multiple reads usually required for 1X coverage)
binSize = 200

#Minimum read coverage of informative cytosines in region (cytosines that contribute to methylation values)
minCov = 3

#Minimum number of informative cytosines in region 
minCountC = 5 

#Minimum absolute difference in methylation between values to qualify as a DMR (value2 - value1, exclusive)
minAbsDif = .20

#Minimum relative difference in methylation between values to qualify as a DMR (value1/value2, exclusive)
minRelDif = .5


##############################################################################
#INITIALIZE STUFF
##############################################################################

import gzip
import math

#Open files
inFile = gzip.open(inPath, 'rb')
summaryFile = open(outPrefix + '_DMR_summary.txt', 'w')
hyperDMRFile = open(outPrefix + '_hyperDMRs.txt', 'w')
hypoDMRFile = open(outPrefix + '_hypoDMRs.txt', 'w')
EMRFile = open(outPrefix + '_methylEMRs.txt', 'w')

#Region type counts (for summary at end)
hyperDMRs = 0
hypoDMRs = 0
EMRs = 0
 
#list of meth values and coverage for each cytosine for each pair of samples for each region
regionMeths1 = []
regionMeths2 = []
regionCoverages1 = []
regionCoverages2 = []
newRegion = False #Use this later to decide whether to reset above lists

##############################################################################
#GET VALUES FROM FIRST LINE OF FILE
##############################################################################
line = inFile.readline()
columns = line.strip().split()
chr = str(columns[0])[2:-1]
print(chr)
bp = int(columns[2])
regionStart = int(binSize*math.floor(bp/binSize)) + 1 #CGmaps use 1-based annotation

regionMeths1.append(float(columns[5]))
regionMeths2.append(float(columns[8]))
regionCoverages1.append(float(columns[7]))
regionCoverages2.append(float(columns[10]))


####################################################################################
#GET VALUES FROM REST OF FILE, LINE-BY-LINE, AND PROCESS EACH REGION EXCEPT LAST ONE
####################################################################################

for line in inFile:
	columns = line.strip().split()
	bp = int(columns[2]) #Get position of current cytosine 
	
	if str(columns[0])[2:-1] == chr: #Check whether current cytosine is on same chromosome as previous one.
	
		if bp < regionStart + binSize: #Append methylation and coverage values if still in same region
			regionMeths1.append(float(columns[5]))
			regionMeths2.append(float(columns[8]))
			regionCoverages1.append(float(columns[7]))
			regionCoverages2.append(float(columns[10]))		
		else: 
			newRegion = True
			
	else: #New chromosome means new region and need to reset chromosome name
		newRegion = True
		chr = str(columns[0])[2:-1]
		print(chr)
					
	if newRegion: #If new region, process previous one
			
		#Test for eligibility based on coverage and number of informative cytosines
		coverageAve1 = sum(regionCoverages1)/len(regionCoverages1) 
		if coverageAve1 >= minCov:
			coverageAve2 = sum(regionCoverages2)/len(regionCoverages2)	
			if coverageAve2 >= minCov:
				countC = len(regionCoverages1)
				if countC >= minCountC:
				
					#Get average methylation for eligible regions from each sample
					methAve1 = sum(regionMeths1)/countC
					methAve2 = sum(regionMeths2)/countC
					
					#Only regions with methylation above the minAbsDif value qualify to be EMRs
					if methAve1 >= minAbsDif or methAve2 >= minAbsDif:
						regionLine = chr + '\t' + str(regionStart-1) + '\t' + str(regionStart + binSize - 1) + '\t' + str(round(methAve1,3)) + '\t' + str(round(methAve2,3)) + '\t' + str(round(coverageAve1,2)) + '\t' + str(round(coverageAve2,2)) + '\t' + str(countC) + '\n'
						EMRFile.write(regionLine) #write region details to eligible methylation regions file 
						EMRs += 1 #count number of eligible methylation regions
					
					#Test for differential methylation
					hyper = False #assume this is not a hyperDMR to skip "if" statements later
					if methAve2 != 0: #avoid division by zero
						if methAve2 - methAve1 > minAbsDif:
							if methAve1/methAve2 < minRelDif:
								hyperDMRFile.write(regionLine) #write region details to hyperDMR file
								hyperDMRs += 1  #count number of hyperDMRs
								hyper = True
					if hyper == False: #only do next steps if region not already identified as hyperDMR
						if methAve1 != 0: #avoid division by zero
							if methAve1 - methAve2 > minAbsDif:
								if methAve2/methAve1 < minRelDif:
									hypoDMRFile.write(regionLine) #write region details to hypoDMR file
									hypoDMRs += 1  #count number of hypoDMRs
		
		#Reset meths and coverages to include only the values from the most recent position	
		regionMeths1 = [float(columns[5])] 
		regionMeths2 = [float(columns[8])]
		regionCoverages1 = [float(columns[7])] 
		regionCoverages2 = [float(columns[10])]
		regionStart = int(binSize*math.floor(bp/binSize)) + 1 #CGmaps use 1-based annotation
		newRegion = False


####################################################################################
#PROCESS LAST REGION IN FILE
####################################################################################

#Test for eligibility based on coverage and number of informative cytosines
coverageAve1 = sum(regionCoverages1)/len(regionCoverages1) 
if coverageAve1 >= minCov:
	coverageAve2 = sum(regionCoverages2)/len(regionCoverages2)	
	if coverageAve2 >= minCov:
		countC = len(regionCoverages1)
		if countC >= minCountC:
		
			#Get average methylation for eligible regions from each sample
			methAve1 = sum(regionMeths1)/countC
			methAve2 = sum(regionMeths2)/countC
			
			#Only regions with methylation above the minAbsDif value qualify to be EMRs
			if methAve1 >= minAbsDif or methAve2 >= minAbsDif:
				regionLine = chr + '\t' + str(regionStart-1) + '\t' + str(regionStart + binSize - 1) + '\t' + str(round(methAve1,3)) + '\t' + str(round(methAve2,3)) + '\t' + str(round(coverageAve1,2)) + '\t' + str(round(coverageAve2,2)) + '\t' + str(countC) + '\n'
				EMRFile.write(regionLine) #write region details to eligible methylation regions file 
				EMRs += 1 #count number of eligible methylation regions
		
			#Test for differential methylation
			hyper = False #assume this is not a hyperDMR to skip "if" statements later
			if methAve2 != 0: #avoid division by zero
				if methAve2 - methAve1 > minAbsDif:
					if methAve1/methAve2 < minRelDif:
						hyperDMRFile.write(regionLine) #write region details to hyperDMR file
						hyperDMRs += 1  #count number of hyperDMRs
						hyper = True
			if hyper == False: #only do next steps if region not already identified as hyperDMR
				if methAve1 != 0: #avoid division by zero
					if methAve1 - methAve2 > minAbsDif:
						if methAve2/methAve1 < minRelDif:
							hypoDMRFile.write(regionLine) #write region details to hypoDMR file
							hypoDMRs += 1  #count number of hypoDMRs


####################################################################################
#CREATE SUMMARY FILE
#####################################################################################

summaryFile.write('Input file name: ' + inPath[inPath.rindex('/') + 1:] + '\n')
summaryFile.write('Methylation is calculated as average of the methylation values of all cytosines in region. It is not weighted by number of reads\n')
summaryFile.write('Region size: ' + str(binSize) + '\n')
summaryFile.write('#Minimum read coverage of informative cytosines in region: ' + str(minCov) + '\n')
summaryFile.write('#Minimum number of informative cytosines in region: ' + str(minCountC) + '\n')
summaryFile.write('Minimum absolute difference in methylation between values to qualify as a DMR (value2 - value1, exclusive) ' + str(minAbsDif) + '\n')
summaryFile.write('Minimum relative difference in methylation between values to qualify as a DMR (value1/value2, exclusive) ' + str(minRelDif) + '\n')
summaryFile.write('Region file formats\n')
summaryFile.write('Chromosome\tStart position (0-based)\tEnd position (exclusive)\tSample1 methylation\tSample2 methylation\tSample1 coverage\tSample2 coverage\tinformative cytosines\n')
summaryFile.write('Region counts\n')
summaryFile.write('hyperDMRs\t' + str(hyperDMRs) + '\n')
summaryFile.write('hypoDMRs\t' + str(hypoDMRs) + '\n')
summaryFile.write('methylEMRs\t' + str(EMRs) + '\n')


####################################################################################
#CLOSE FILES
#####################################################################################

inFile.close()
summaryFile.close()
hyperDMRFile.close()
hypoDMRFile.close()
EMRFile.close()
