#' card_table UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList
#' @importFrom dplyr left_join
#' @import reactable
#' 
mod_card_table_ui <- function(id, width="100%", height="100%", titulo = NULL) {
  ns <- NS(id)
  if(!is.null(titulo)){
    titulo <- tagList(
      tags$h4(class = 'card-title text-primary mb-3', titulo)
    )
  }
  tagList(
    card(
      titulo,
      reactableOutput(ns('tabela'), width = width, height = height)
    )
 
  )
}
    
#' card_table Server Functions
#' 
#' @noRd 


mod_card_table_server <- function(id, dado){
  moduleServer(id, function(input, output, session){
    ns <- session$ns
    
   
    output$tabela <- renderReactable({ 
      dadoi <- dado()
    dadoi <- dadoi[!duplicated(dadoi$co_unidade),c('no_fantasia',  'co_municipio_gestor','publico')]
    dadoi$publico <- ifelse(dadoi$publico == 1, 'Sim', 'Não')
    dadoi <- dplyr::left_join(dadoi, municipiosf[,c('cod6', 'Municipio')], by = c('co_municipio_gestor' = 'cod6'))
    #dadoi <- dadoi[c(1,3)]
    dadoi <- dadoi[-c(2,5)]
    
    names(dadoi) <- c('Nome do estabelecimento', 'É um estabelecimento público?', 'Município')
    
      reactable(dadoi, pagination = F)

    })
 
  })
}
    
## To be copied in the UI
# mod_card_table_ui("card_table_1")
    
## To be copied in the server
# mod_card_table_server("card_table_1")
