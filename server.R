
server <- function(input, output, session) {
    observeEvent(input$retrieve_user, {
      testvector <- transpose(as.data.table(c(input$username, input$password)))
      if(NROW(merge(testvector,
                    matrixa, 
                    by.x = c("V1", "V2"), 
                    by.y = c("email", "password")))==1){
           # characters tab -----
            insertTab(inputId = "tabs",
                      target = "How to Play",
                      tabPanel("Characters", 
                               fluidPage(
                                 includeMarkdown('characters_panel.md')
                                 )
                               )
                      )
           # campaign tab -----
            insertTab(inputId = "tabs",
                      target = "Characters",
                      tabPanel("Campaigns", 
                               fluidPage(
                                 includeMarkdown('campaigns_panel.md')
                                 )
                               )
                      )
           # characters tab -----
            insertTab(inputId = "tabs",
                      target = "Campaigns",
                      tabPanel("Rules", 
                               fluidPage(
                                 includeMarkdown('full_rules.md')
                                 )
                               )
            )
           } else {textOutput("Username and/or password not found")}
        }) # Render additional tabs on login
    observeEvent(input$create_user {
      # check if username is unique
      if (input$username %in% )

    }) # Add unique username and pass to database
  }
