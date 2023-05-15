library(shiny)
library(ggplot2)
library(reshape2)
library(leaflet)
my_list<- file("/Users/joelmoreira/Desktop/Msc_Bioinformatics/BINP29/PROJECT/JoelMoreira/Example_Input/var_list_file", "r")
countries_data <- list()

while (length(one_line <- readLines(my_list, n = 1)) > 0){
  
  
  file_path_1 <-paste("/Users/joelmoreira/Desktop/Msc_Bioinformatics/BINP29/PROJECT/", one_line, sep = "")
  
  file_path_2 <-paste(file_path_1, ".txt", sep = "")
  
  #i_var <- paste0('read.table("',file_path_2,'")',sep="")
  df <- read.table(file_path_2)
  df_melt<-melt(df, id.vars = "V1", variable.name = "group", value.name = "value")
  countries_data[[one_line]]<- df_melt
  
  # Melt the data frame into a long format
  # df_melted <- melt(df, id.vars = "V1", variable.name = "group", value.name = "value")
  
}

# Define the UI
ui <- fluidPage(
  
  # Add a title
  titlePanel("Bar Plots with the Ammount of Homozygous and Heterozygous gene matches"),
  
  # Add a sidebar layout
  sidebarLayout(
    
    # Add a sidebar panel for country selection
    sidebarPanel(
      
      # Add a select input for country selection
      selectInput("country", "Select a country:", choices = names(countries_data))
      
    ),
    
    # Add a main panel for the map and bar plot
    mainPanel(
      
      # Add a bar plot
      plotOutput("bar_plot"),
      downloadButton("download", "Download plot")
      
    )
    
  )
  
)

