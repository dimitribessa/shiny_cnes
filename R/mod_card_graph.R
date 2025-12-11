#' card_graph UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_card_graph_ui <- function(id,  width="100%", height="100%", titulo = NULL) {
  ns <- NS(id)
  if(!is.null(titulo)){
    titulo <- tagList(
      tags$h4(class = 'card-title text-primary mb-3', titulo)
    )
  }
  tagList(
    card(
      titulo,
      apexchartOutput(ns('chart'), width = width, height = height)
    )
 
  )
}
    
#' card_graph Server Functions
#'
#' @noRd 
mod_card_graph_server <- function(id, dado){
  moduleServer(id, function(input, output, session){
    ns <- session$ns
    
    output$chart <- renderApexchart({dado})
  })
}
    
## To be copied in the UI
# mod_card_graph_ui("card_graph_1")
    
## To be copied in the server
# mod_card_graph_server("card_graph_1")
