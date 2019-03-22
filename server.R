source("helpers.R", local = TRUE)
source("postgres.R", local = TRUE)

server <- function(input, output, session) {
    observeEvent(input$retrieve_user, {
    
    if(loginTest(input$username, input$passkey)) {
      output$messages <- renderText({"Logged in"})
      appendTab(inputId = "tabs", # characters tab -----
                # target = "howtoplay",
                tabPanel("Characters", 
                         fluidPage(
                           includeMarkdown('characters_panel.md')
                           )
                         )
                )       # characters tab
      appendTab(inputId = "tabs", # campaign tab -----
                # target = "Characters",
                tabPanel("Campaigns", 
                         fluidPage(
                           includeMarkdown('campaigns_panel.md')
                           )
                         )
                ) # campaign tab
      appendTab(inputId = "tabs", # Rules tab -----
                # target = "Campaigns",
                tabPanel("Rules", 
                         fluidPage(
                           includeMarkdown('full_rules.md')
                           )
                         )
                ) # Rules tab
    } else {
      output$messages <- renderText({"Username and/or password not found"})
        }
    }) # Render additional tabs on login
  
  }

