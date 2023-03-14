# PLINK_PopGen_Project
Population Genetics Tool developed during BINP29

In this GitHub page is possible to find:
- Input files used and given as example.
- Python code with the actual tool.
- Bash script that will separate by country the output of the tool.
- R shiny server with some statistical data (http://127.0.0.1:3667)


The prompt for this work was to:
"Write & code that reads a user’s plink file (.ped format) and a plink file with similar data but for multiple individuals (same .ped format). Report the number of homozygotes and heterozygotes matches of the user with each individual."

In order to try your data in this tool you need to have 2 .ped files - 1 with just one individual and 1 with multiple individuals.

These can be obtained by: 
  > plink2 -bfile <Name> --recode ped
  
  > grep "IND_ID" multi.ped > individual.ped
  
  Once you have both of your files you can run the python tool by:
  > python3 PopGen.py user_individual_file.ped multi_individual_file.ped outputfile.txt
  
  Where the output will be a 3 column file containing the individual id, the number of homozygous matches and the number of heterozygous matches.
  
  To run the bash script to separate the previous output by countries (or by any given list if changed):

Get the list of the countries present on ped file
> cat ./PLINK_files/multi_file.ped | cut -f1 | sort -u > var_list_file

Run Group_Country.sh
> chmod +x Group_Country.sh

> ./Group_Country.sh


To check the brief statistical analysis given as example you can open (http://127.0.0.1:3667) and edit the files in R shiny directory for your data.

Devoloped by: Joel Moreira
