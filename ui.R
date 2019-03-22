
ui <- fluidPage(
  titlePanel("ROPG"), # Application title
  sidebarPanel(
    wellPanel(textInput("username", "Username"),
              passwordInput("passkey", "Password"),
              actionButton("retrieve_user", "Log in"),
              textOutput("messages")
              )
    ),
  mainPanel(
    fluidPage(
      tabsetPanel( id = "tabs",
        tabPanel("How to play",includeMarkdown('characters_panel.md'))
        )
      )
    )
  )
