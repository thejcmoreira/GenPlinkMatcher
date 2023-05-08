# Load the ggplot2 package
library(ggplot2)
library(reshape2)

setwd("/Users/joelmoreira/Desktop/Msc_Bioinformatics/BINP29/PROJECT/")
my_list<- file("/Users/joelmoreira/Desktop/Msc_Bioinformatics/BINP29/PROJECT/var_list_file", "r")

while (length(one_line <- readLines(my_list, n = 1)) > 0){


file_path_1 <-paste("/Users/joelmoreira/Desktop/Msc_Bioinformatics/BINP29/PROJECT/", one_line, sep = "")

file_path_2 <-paste(file_path_1, ".txt", sep = "")

file_path_3 <-paste(one_line, ".png", sep = "")


df <- read.table(file_path_2)

# Melt the data frame into a long format
df_melted <- melt(df, id.vars = "V1", variable.name = "group", value.name = "value")

# Create the plot with ggplot
p<-ggplot(df_melted, aes(x = V1, y = value , fill = group)) +
  # Add the bars
  geom_bar(stat = "identity", position = "dodge", color = "black") +
  # Add a title and axis labels
  ggtitle("Bar Plot of Homozygous and Heterozygous matches of",one_line) +
  xlab("Ind_id") +
  ylab("Genes") +
  # Customize the fill colors and add a legend
  scale_fill_manual(name = "Legend", 
                    values = c("blue", "red"), 
                    labels = c("Homozygous", "Heterozygous")) +
  # Change the theme
  theme_minimal()
}
