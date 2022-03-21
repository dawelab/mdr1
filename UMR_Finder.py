#This script will divide a CGmapTools CGmap file into bins of a defined size
#and find bins that are unmethylated in particular sequence contexts.
#Only bins passing coverage criteria will be considered. 
#Methylation is calculated as average of the methylation values of all cytosines in region, not weighted by number of reads
#All bins with passing coverage will also be output as eligible methylation regions (EMRs)
#Output formats for each region as follows:
#1 Chromosome
#2 Start position (0-based)
#3 End position (exclusive)
#4 Methylation average for region (by informative cytosine in region, not weighted by reads)
#5 Sample1 coverage
#6 Number informative cytosines

###############################################################################
#USER INPUT
###############################################################################

#Input file name and path
inPath = '/scratch/gent/merged_maps/w-EM.CGmap.gz'

#prefix for output files 
outPrefix = 'w-EM_CHG.2_2X_unsorted'

#Region size in bp. (larger than read length means multiple reads usually required for 1X coverage)
binSize = 200

#Minimum read coverage of informative cytosines in region (cytosines that contribute to methylation values)
minCov = 2

#Minimum number of informative cytosines in region 
minCountC = 5 

#Maximum methylation to qualify as a UMR, exclusive)
maxMeth = .2

#Contexts to evaluate. Both can be set to the same one 
context1 = 'CHG'
context2 = 'CHG'

##############################################################################
#INITIALIZE STUFF
##############################################################################

import gzip
import math

#Open files
inFile = gzip.open(inPath, 'rb')
summaryFile = open(outPrefix + '_UMR_summary.txt', 'w')
UMRFile = open(outPrefix + '_UMRs.txt', 'w')

#Region type counts (for summary at end)
UMRs = 0
 
#list of meth values and coverage for each cytosine for each pair of samples for each region
regionMeths = []
regionCoverages = []
newRegion = False #Use this later to decide whether to reset above lists

##############################################################################
#GET VALUES FROM FIRST LINE OF FILE
##############################################################################

line = inFile.readline()
columns = line.strip().split()
chr = columns[0].decode("utf-8")
bp = int(columns[2])
regionStart = int(binSize*math.floor(bp/binSize)) + 1 #CGmaps use 1-based annotation
context =  columns[3].decode("utf-8")
print(chr)

if context == context1 or context == context2:
	regionMeths.append(float(columns[5]))
	regionCoverages.append(float(columns[7]))


####################################################################################
#GET VALUES FROM REST OF FILE, LINE-BY-LINE, AND PROCESS EACH REGION EXCEPT LAST ONE
####################################################################################

for line in inFile:
	columns = line.strip().split()
	bp = int(columns[2]) #Get position of current cytosine 
	
	if columns[0].decode("utf-8") == chr: #Check whether current cytosine is on same chromosome as previous one.
	
		if bp < regionStart + binSize: #Append methylation and coverage values if still in same region and if in allowed context
			context = columns[3].decode("utf-8")
			if context == context1 or context == context2:
				regionMeths.append(float(columns[5]))
				regionCoverages.append(float(columns[7]))
		else: 
			newRegion = True
			
	else: #New chromosome means new region and need to reset chromosome name
		newRegion = True
		chr = columns[0].decode("utf-8")
					
	if newRegion: #If new region, process previous one
		#Test for eligibility based on coverage and number of informative cytosines
		countC = len(regionCoverages)
		if countC >= minCountC:
			coverageAve = sum(regionCoverages)/countC
			if coverageAve >= minCov:
				
				#Get average methylation for region
				methAve = sum(regionMeths)/countC
				regionLine = chr + '\t' + str(regionStart - 1) + '\t' + str(regionStart + binSize - 1) + '\t' + str(round(methAve,3)) + '\t' + str(round(coverageAve,2)) + '\t' + str(countC) + '\n'
			
				#If methylation low enough, write region to new file.
				if methAve < maxMeth:
					UMRFile.write(regionLine) #write region details to hyperDMR file
					UMRs += 1  #count number of hyperDMRs

		#Reset meths and coverages to include only the values from the most recent position	
		regionMeths = []
		regionCoverages = []
		regionStart = int(binSize*math.floor(bp/binSize)) + 1 #CGmaps use 1-based annotation
		if context == context1 or context == context2:
			regionMeths.append(float(columns[5]))
			regionCoverages.append(float(columns[7]))
		newRegion = False

####################################################################################
#PROCESS LAST REGION IN FILE
####################################################################################

#Test for eligibility based on coverage and number of informative cytosines
countC = len(regionCoverages)
if countC >= minCountC:
	coverageAve = sum(regionCoverages1)/len(countC) 
	if coverageAve >= minCov:		
		#Get average methylation for region
		methAve = sum(regionMeths)/countC
		regionLine = chr + '\t' + str(regionStart - 1) + '\t' + str(regionStart + binSize - 1) + '\t' + str(round(methAve,3)) + '\t' + str(round(coverageAve,2)) + '\t' + str(countC) + '\n'
	
		#If methylation low enough, write region to new file.
		if methAve < maxMeth:
			UMRFile.write(regionLine) #write region details to hyperDMR file
			UMRs += 1  #count number of hyperDMRs

####################################################################################
#CREATE SUMMARY FILE
#####################################################################################

summaryFile.write('Input file name: ' + inPath[inPath.rindex('/') + 1:] + '\n')
summaryFile.write('Methylation is calculated as average of the methylation values of all cytosines in region. It is not weighted by number of reads\n')
summaryFile.write('Region size: ' + str(binSize) + '\n')
summaryFile.write('Minimum read coverage of informative cytosines in region: ' + str(minCov) + '\n')
summaryFile.write('Minimum number of informative cytosines in region: ' + str(minCountC) + '\n')
summaryFile.write('Maximum average methylation value for region to qualify as a UMR (exclusive) ' + str(maxMeth) + '\n')
summaryFile.write('Region file formats\n')
summaryFile.write('Chromosome\tStart position (0-based)\tEnd position (exclusive)\tSample1 methylation\tSample2 methylation\tSample1 coverage\tSample2 coverage\tinformative cytosines\n')
summaryFile.write('Region counts\n')
summaryFile.write('UMRs\t' + str(UMRs) + '\n')

####################################################################################
#CLOSE FILES
#####################################################################################

inFile.close()
summaryFile.close()
UMRFile.close()
