import argparse
import re
import os

parser = argparse.ArgumentParser(
        description="Summarizes a Calibre summary report into a csv file.")

parser.add_argument("--targetPath", "-t", required=True,
                    help="Summaries Path. All .summary files inside that path and its subdirectories will be parsed")

parser.add_argument("--waivableList", "-w", required=False,
                    help="A file that contains white space separated list of waivable violations")

parser.add_argument("--outputDirectory", "-o", required=False,
                    help="Output Directory")

args = parser.parse_args()
summaryFolder = args.targetPath
outputDirectory = args.outputDirectory
if outputDirectory is None:
    outputDirectory = summaryFolder
waiveList=[]
if args.waivableList is not None:
    waivableListFileOpener = open(args.waivableList,"r")
    waiveList = waivableListFileOpener.read().split()
    waivableListFileOpener.close()

header = "RULE,Waivable,COUNT 1, COUNT 2\n"

def getListOfFiles(dirName):
    # create a list of file and sub directories
    # names in the given directory
    listOfFile = os.listdir(dirName)
    allFiles = list()
    # Iterate over all the entries
    for entry in listOfFile:
        # Create full path
        fullPath = os.path.join(dirName, entry)
        # If entry is a directory then get the list of files in this directory
        if os.path.isdir(fullPath):
            allFiles = allFiles + getListOfFiles(fullPath)
        else:
            allFiles.append(fullPath)
    return allFiles


def extractSummary(summaryFile):
    summaryFileOpener = open(summaryFile,"r")
    summaryContent = summaryFileOpener.read().split("\n")
    summaryFileOpener.close()
    outputFile = outputDirectory+'/'+os.path.basename(summaryFile)+'.csv'

    splitter = "----------------------------------------------------------------------------------"
    ruleCheckString = "RULECHECK RESULTS STATISTICS"

    beginFlag = False

    outputFileOpener = open(outputFile, "w+")
    outputFileOpener.write(header)
    outputFileOpener.close()            

    for line in summaryContent:
        if line.find(ruleCheckString) != -1:
            beginFlag = True
        
        if beginFlag:
            if line == splitter:
                break

            rule = re.findall(r'RULECHECK (\S+)\s*.*\s*TOTAL Result Count = (\d+)\s*\((\d+)\)', line)

            if len(rule) == 1:
                ruleName = rule[0][0]
                waivable= 'no'
                if ruleName in waiveList:
                    waivable='yes'
                outputFileOpener = open(outputFile, "a+")
                outputFileOpener.write(str(",".join((ruleName, waivable,rule[0][1],rule[0][2])))+'\n')
                outputFileOpener.close()            
                
                mainOutputFileOpener = open(mainOutputFile, "a+")
                mainOutputFileOpener.write(str(",".join((ruleName, waivable,rule[0][1],rule[0][2])))+'\n')
                mainOutputFileOpener.close()  

mainOutputFile = outputDirectory+'/'+os.path.dirname(summaryFolder+'/')+'_merged.csv'

mainOutputFileOpener = open(mainOutputFile, "w+")
mainOutputFileOpener.write(header)
mainOutputFileOpener.close()            

files = getListOfFiles(summaryFolder)
for f in files:
    extension = os.path.splitext(f)[1]
    if extension == '.summary':
        extractSummary(f)
