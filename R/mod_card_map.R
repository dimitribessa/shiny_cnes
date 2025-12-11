#' card_map UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList withTags div
#' @import leaflet
#' @import sf
#'
mod_card_map_ui <- function(id, title) {
  ns <- NS(id)
    
     tagList(
        #div(class = 'card',
       #  div(class = 'card-body mb-0 pb-1', 
        #   tags$h4(class = 'card-title text-primary mb-1',title)
       # )
       # ,
      leafletOutput(ns('mapa'))
    )
     #) 
  
}
    
#' card_map Server Functions
#'
#' @noRd 
mod_card_map_server <- function(id, dado){

  moduleServer(id, function(input, output, session){
    ns <- session$ns
   
   output$mapa <- renderLeaflet({
    dadoi <- dado()
    dadoi <- dadoi[!duplicated(dadoi$co_unidade),]
    dadoi <- with(dadoi, as.data.frame(table(co_municipio_gestor), stringsAsFactors = F))
    dadoi[,1] <- as.numeric(dadoi[,1])
    dados_mapa <- dplyr::left_join(municipiosf, dadoi, by = c('cod6' = 'co_municipio_gestor'))
        
   fill_color <- function(x){
          bins <- unique(as.vector(round(quantile(x, probs = c(0,0.30,0.50,0.7,0.85,0.95,1),na.rm = T),2))) #
          if(all(bins == 0)){bins <- NA; x[x == 0] <- NA}
          if(length(bins) == 1){bins <- c(0, bins)}
          pal <- colorBin("YlOrRd", domain = x, bins = bins)
          colorData <- pal(x)
          list(pal, colorData)
        }

    labellss <- sprintf(
  "<strong>%s</strong><br/> %s %s" , #  people / mi<sup>2</sup>",
   dados_mapa$Municipio, 'Quantidade de estabelecimentos: ', dados_mapa$Freq) |> lapply(htmltools::HTML)


  
     leaflet() |>
        addProviderTiles(providers$CartoDB.Positron,  options = providerTileOptions(minZoom = 7)) |>
        setView(lat = -27.5, lng = -51, zoom = 7)  |> clearControls() |> clearShapes() |>
        addPolygons(data = dados_mapa,  color = "#444444", fillColor =  fill_color(dados_mapa$Freq)[[2]], 
        stroke = T, smoothFactor = 0.5, fillOpacity = 0.8, weight = 1.5,
    highlight = highlightOptions(
    weight = 5,
    color = "#666",
    fillOpacity = 0.7,
    bringToFront = TRUE),
  label = labellss,
  labelOptions = labelOptions(
    style = list("font-weight" = "normal", padding = "3px 8px"),
    textsize = "12px",
    maxWidth = '200px',
    direction = "auto")) |> 
    
    addLegend(pal = fill_color(dados_mapa$Freq)[[1]], values = fill_color(dados_mapa$Freq)[[2]], opacity = 0.7,
     title = 'Qtd. de estabelecimentos',
  position = "bottomright", layerId="colorLegend2") 
         
         })
    
  })
}

#' card_map Server Functions by points
#'
#' @noRd 
mod_card_map_server_loc <- function(id, dado){

  moduleServer(id, function(input, output, session){
    ns <- session$ns
   
   output$mapa <- renderLeaflet({
    dadoi <- dado()
    dadoi <- dadoi[!duplicated(dadoi$co_unidade),]
    dados_mapa <- dadoi
    dados_mapa$nu_latitude <- as.numeric(dados_mapa$nu_latitude)
    dados_mapa$nu_longitude <- as.numeric(dados_mapa$nu_longitude)

    labellss <- sprintf(
  "<strong>%s</strong><br/> %s" , #  people / mi<sup>2</sup>",
   dados_mapa$municipio,  dados_mapa$no_fantasia) |> lapply(htmltools::HTML)

  leaflet() |>
        addProviderTiles(providers$CartoDB.Positron,  options = providerTileOptions(minZoom = 7)) |>
        setView(lat = -27.5, lng = -51, zoom = 7) |> 
        clearControls() |> clearShapes() |> clearMarkers() |>
       addCircleMarkers(data = dados_mapa, lng = ~nu_longitude, lat = ~nu_latitude, stroke = F, 
        radius = 4, fillOpacity = .6,
   label = labellss,
  labelOptions = labelOptions(
    style = list("font-weight" = "normal", padding = "3px 8px"),
    textsize = "12px",
    maxWidth = '200px',
    direction = "auto"))
         

   }) #end output mapa
  }) #end modlue server

} #end function


## To be copied in the UI
# mod_card_map_ui("card_map_1")
    
## To be copied in the server
# mod_card_map_server("card_map_1")
