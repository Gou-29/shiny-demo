# global
# libraries

library(shiny)
library(tidyverse)
library(DT)
library(shinydashboard)
library(plotly)

# functions:

generate_summary_stat <- function(input, var_list){
  
  df <- read.csv(input) %>% as.tibble()
  
  df <- df[,-1]
  
  df <- 
    df %>% 
    summary() %>% 
    as.data.frame() %>% 
    as.tibble() %>% 
    select(-1) %>% 
    mutate(Var2 = str_trim(as.character(Var2))) %>% 
    separate(Freq, sep = ":", into = c("stat", "value")) %>% 
    mutate(stat = str_trim(as.character(stat)),
           value= as.numeric(value)) %>% 
    pivot_wider(names_from = stat,
                values_from = value) %>% 
    rename(Variable = Var2)  %>% 
    filter(Variable %in% var_list)
  
  return(df)
}

generate_plot <- function(input, x_var, y_var){
  
  df <- read.csv(input) %>% as.tibble()
  
  df <- df[,-1]
  
  plot <- 
    df %>% 
    select(x_var,y_var) %>% 
    ggplot(aes_string(x = x_var, y = y_var)) + 
    geom_point(alpha = 0.5) + 
    geom_smooth(method = "lm", se = F, alpha = 0.5)
  
  plot <- ggplotly(plot)
  
  return(plot)
  
}
