# server

shinyServer(
  function(input, output) {
    
    
    output$summary <- DT::renderDataTable({
      
      # Some control sequence: 
      
      validate(need(!is.null(input$file_input$datapath), 
                    "please upload your csv file!"))
      
      validate(need(length(input$varlist)>0,
                    "please select a variable"))
      
      # main
      generate_summary_stat(input$file_input$datapath, 
                            input$varlist)
      })
    
    output$plot <- renderPlotly({
      # Some control sequence: 
      validate(need(!is.null(input$file_input$datapath), 
                    "please upload your csv file!"))
      validate(need(!is.null(input$x_var),
                    "please specify x"))
      validate(need(!is.null(input$y_var),
                    "please specify y"))
      validate(need(input$x_var != input$y_var,
                    "please select different value for x and y!"))
      
      # main
      generate_plot(input$file_input$datapath,
                    input$x_var,
                    input$y_var)
    })
    
    output$outdata <- downloadHandler(
      filename = "Summary_statistics.csv",
      content = function(file) {
        write.csv(
          generate_summary_stat(input$file_input$datapath, 
                                input$varlist), 
          file,
          row.names = F)}
    )
      
  }
  
  
)



