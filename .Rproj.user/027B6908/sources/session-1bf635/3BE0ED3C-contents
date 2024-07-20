# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#
# 
# library(shiny)
library(tidyverse)
# Define server logic required to draw a histogram
server <- shinyServer(function(input, output) {
  
  select_data <- reactive({data_in %>%
      filter(geo %in% input$geo,
             industry %in% input$industry)    }) 
  
  tbl_ave_data <- reactive({select_data() %>%
      select(id, geo, industry, var_list$var_name) %>%
      group_by(geo, industry) %>%
      summarize(ghg_kilotonnes_per_employee_simulated = mean(ghg_kilotonnes_per_employee_simulated),
                age_simulated = mean(age_simulated),
                pct_women_simulated = mean(pct_women_simulated)) %>%
      ungroup() %>%
      mutate(id = "Average") %>%
      select(id, geo, industry, var_list$var_name)})
  
  chart_data <- reactive({select_data() %>%
      select(geo, industry, var_list$var_name) %>%
      pivot_longer(cols = var_list$var_name, names_to = "name", values_to = "value")})
  
  
  geo =       reactive(input$geo)
  industry =  reactive(input$industry)
  ghg =       reactive(input$ghg)
  employees = reactive(input$employees)
  emp_age =   reactive(input$emp_age)
  board =     reactive(input$board)
  women =     reactive(input$women)
  id =        reactive(input$id)
  
  tbl_values <- reactiveValues()
  tbl_for_saving <- reactiveValues()
  
  observe({tbl_values$data <- tbl_ave_data()})
  observe({tbl_for_saving$output_data <- select_data()})
  
  
  observeEvent(input$submit_user_response, {
    tbl_values$data <- tbl_values$data %>% 
      add_row(id = as.character(id()), 
              geo = as.character(geo()),
              industry = as.character(industry()),
              ghg_kilotonnes_per_employee_simulated = as.numeric(ghg())/as.numeric(employees()),
              age_simulated = as.numeric(emp_age()),
              pct_women_simulated = 100*(as.numeric(women())/as.numeric(board())))
  })
  
  
  output$tbl <- renderTable({
    
    tbl_values$data %>% 
      rename(`Employee Age`= age_simulated, Industry = industry, `GHG Emissions/Employee (tonnes)` = ghg_kilotonnes_per_employee_simulated, `Female Board Members (%)` = pct_women_simulated, ID = id, Geography=geo)
    
    
  }) # end tbl output
  
  
  
  output$distPlot <- renderPlot({
    
    # draw the histogram with the specified number of bins
    
    if(input$submit_user_response == 0){
      
      names_labs <- c('Employee Age', 'GHG Emissions/Employee (tonnes)', 'Female Board Members (%)')
      names(names_labs) <- c("age_simulated", "ghg_kilotonnes_per_employee_simulated", "pct_women_simulated")
      
      vcolours <- c("#5675D6", "#428953", "#CE2929")
      
    ggplot() +
      geom_histogram(data = chart_data(), aes(x=value, fill=name), binwidth = 1) +
      xlab("Value") + ylab("Counts") +
      facet_wrap(~name, ncol = 1, scales = "free" , labeller = labeller(name = names_labs)) +
      theme_minimal()+
      theme(strip.text.x = element_text(size = 24,  face = "bold"),
            strip.text.y = element_text(size = 24,  face = "bold"),
            axis.title.x = element_text(color="black", size=20),
            axis.title.y = element_text(color="black", size=20),
            axis.text = element_text(size = 16)) +
      scale_fill_manual(values= vcolours) +
      theme(legend.position="none")
      
    } else {
      
      responses_chart_data <- tibble(id = as.character(id()), 
                                     geo = as.character(geo()),
                                     industry = as.character(industry()),
                                     ghg_kilotonnes_per_employee_simulated = as.numeric(ghg())/as.numeric(employees()),
                                     age_simulated = as.numeric(emp_age()),
                                     pct_women_simulated = 100*(as.numeric(women())/as.numeric(board())))%>%
        select(geo, industry, id, var_list$var_name) %>%
        pivot_longer(cols = var_list$var_name, names_to = "name", values_to = "value")
      
      names_labs <- c('Employee Age', 'GHG Emissions/Employee (tonnes)', 'Female Board Members (%)')
      names(names_labs) <- c("age_simulated", "ghg_kilotonnes_per_employee_simulated", "pct_women_simulated")
      
      vcolours <- c("#5675D6", "#428953", "#CE2929")
      
      ggplot() +
        geom_histogram(data = chart_data(), aes(x=value, fill=name),  binwidth = 1) +
        geom_vline(data=responses_chart_data,
                   aes(xintercept=value), col="black", size=1, linetype=2) +
        facet_wrap(~name, ncol = 1, scales = "free" , labeller = labeller(name = names_labs)) +
        theme_minimal() +
        theme(strip.text.x = element_text(size = 24,  face = "bold"),
              strip.text.y = element_text(size = 24,  face = "bold"),
              axis.title.x = element_text(color="black", size=20),
              axis.title.y = element_text(color="black", size=20),
              axis.text = element_text(size = 16)) +
        scale_fill_manual(values= vcolours) +
        theme(legend.position="none") +
        ggtitle("How do you measure up?")
      
      
      
    }
  })
  
  # observeEvent(input$submit_user_response, {
  # 
  #   output$text <- renderText({ "Responses saved. Thank you." })
  # 
  #   })
  
# saving values
  
  observeEvent(input$submit_user_response, {
    tbl_for_saving$output_data <- tbl_for_saving$output_data %>% 
      add_row(id = as.character(id()), 
              geo = as.character(geo()),
              industry = as.character(industry()),
              ghg_kilotonnes_per_employee_simulated = as.numeric(ghg())/as.numeric(employees()),
              age_simulated = as.numeric(emp_age()),
              pct_women_simulated = 100*(as.numeric(women())/as.numeric(board())))%>%
      pivot_longer(cols = var_list$var_name, names_to = "name", values_to = "value")
    
    #write.csv(tbl_for_saving$output_data, "//mead03/MEAD_WORK_IN_PROGRESS/2022_API_ESG_shiny/ESG_prototype/example_saved_output/example_file.csv", row.names = FALSE)
    
    output$text <- renderText({ "Responses saved. Thank you." })
  })
  
  

}) # end server
