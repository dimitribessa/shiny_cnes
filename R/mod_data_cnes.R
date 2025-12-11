#' data_cnes UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
#'
#' @export

mod_data_cnes_ui <- function(id) {
  ns <- NS(id)
  tagList(
    sneat_select(ns('ano'), 'Ano:', choices = c(2020:2025), selected = 2025),
    sneat_select(ns('municipio'), 'Municípios', choices = c('Todos', unique(dado_estab_cnes$municipio)), selected = 'Todos'),
    sneat_button(ns('atualizar'), 'Atualizar') 
  )
}
    
#' data_cnes Server Functions
#'
#' @noRd 
mod_data_cnes_server <- function(id,dado){
  moduleServer(id, function(input, output, session){
    ns <- session$ns

    eventReactive(input$atualizar, {
      dadoi <- dado
      if('co_motivo_desab' %in% names(dadoi)){
      dadoi <- dadoi[which(is.na(dadoi$co_motivo_desab)),]}
      if(input$municipio != "Todos"){dadoi <- dadoi[which(dadoi$municipio == input$municipio),]}
      dadoi[which(dadoi$ano == input$ano),]}, ignoreNULL = F)

  })
}
    
## To be copied in the UI
# mod_data_cnes_ui("data_cnes_1")
    
## To be copied in the server
# mod_data_cnes_server("data_cnes_1")
