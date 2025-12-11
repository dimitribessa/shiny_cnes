#' cards_ui UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList uiOutput renderUI
mod_cards_ui_ui <- function(id, icon = 'bx bxs-truck') {
  ns <- NS(id)
  icon <- paste('icon-base',icon,'icon-lg')
  tagList(
    div(class = 'card card-border-shadow-primary h-100',
      div(class = 'card-body',
        div(class = "d-flex align-items-center mb-2",
          div(class = "avatar me-4",
            span(class = "avatar-initial rounded bg-label-primary",
              tags$i(class = icon))),
              uiOutput(ns('texto1'))
            )
            ,
            uiOutput(ns('texto2'))
            ))
  )
}

    
#' cards_ui Server Functions
#'
#' @noRd 
mod_cards_ui_server <- function(id, out1, out2){
  moduleServer(id, function(input, output, session){
    ns <- session$ns
    output$texto1 <- renderUI({out1()})
    output$texto2 <- renderUI({out2})

  })
}
    
## To be copied in the UI
# mod_cards_ui_ui("cards_ui_1")
    
## To be copied in the server
# mod_cards_ui_server("cards_ui_1")
