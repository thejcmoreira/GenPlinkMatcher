library(shiny)
library(ggplot2)
library(reshape2)
library(leaflet)

# Define a list of countries with their corresponding data for the bar plots

my_list<- file("/Users/joelmoreira/Desktop/Msc_Bioinformatics/BINP29/PROJECT/JoelMoreira/Example_Input/var_list_file", "r")
countries_data <- list()

#Loop to get all the countries data
while (length(one_line <- readLines(my_list, n = 1)) > 0){
  
  
  file_path_1 <-paste("/Users/joelmoreira/Desktop/Msc_Bioinformatics/BINP29/PROJECT/", one_line, sep = "")
  
  file_path_2 <-paste(file_path_1, ".txt", sep = "")
  
  #i_var <- paste0('read.table("',file_path_2,'")',sep="")
  df <- read.table(file_path_2)
  df_melt<-melt(df, id.vars = "V1", variable.name = "group", value.name = "value")
  countries_data[[one_line]]<- df_melt
  
}


# Define the server
server <- function(input, output) {
  

  # Define the bar plot
  output$bar_plot <- renderPlot({
    
    # Get the selected country's data
    data <- countries_data[[input$country]]
  
    
    # Create a bar plot with ggplot2
    ggplot(data, aes(x = V1, y = value , fill = group)) +
      # Add the bars
      geom_bar(stat = "identity", position = "dodge", color = "black") +
      # Add a title and axis labels
      ggtitle("Bar Plot of Homozygous and Heterozygous matches") +
      xlab("Ind_id") +
      ylab("Genes") +
      # Customize the fill colors and add a legend
      scale_fill_manual(name = "Legend", 
                        values = c("blue", "red"), 
                        labels = c("Homozygous", "Heterozygous")) +
      # Change the theme
      theme_minimal()
    
  })
  
  output$download <- downloadHandler(
    filename = function() { paste('.png', sep='') },
    content = function(file) {
      ggsave(file, plot = {
        # Render the plot with the selected country's data
        data <- countries_data[[input$country]]
        ggplot(data, aes(x = V1, y = value, fill = group)) +
          geom_bar(stat = "identity", position = "dodge", color = "black") +
          ggtitle("Bar Plot of Homozygous and Heterozygous matches") +
          xlab("Ind_id") +
          ylab("Genes") +
          scale_fill_manual(name = "Legend", 
                            values = c("blue", "red"), 
                            labels = c("Homozygous", "Heterozygous")) +
          theme_minimal()
      }, dpi = 600)
    }
  )
}


