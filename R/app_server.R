#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @importFrom magrittr `%>%`
#' @noRd
app_server <- function(input, output, session) {
  dado_cnes_basico <-  mod_data_cnes_server("data_cnes_1", dado_estab_cnes)
  mod_card_map_server('mapa_atencao_basica', dado_cnes_basico)
  mod_card_map_server_loc('mapa_atencao_basica_loc', dado_cnes_basico)
  mod_card_table_server("card_table_1", dado_cnes_basico)

  #'cards
  #' total
  #' 
 dados_card_primaria <- reactive({
      dadoi <- dado_cnes_basico()
      dadoi <- dadoi[!duplicated(dadoi$co_unidade),]
      total <- nrow(dadoi)
      hospital <- nrow(dadoi[which(dadoi$tp_unidade == 1),]) #modificado para Posto de saúde
      publico <- round(nrow(dadoi[which(dadoi$publico == 1),])*100/total,2)
      list(total, hospital, publico)

 })

 mod_cards_ui_server('card_total_primaria', 
        out1 = reactive(
      tagList(
        tags$h4(class = 'mb-0',
        dados_card_primaria()[[1]])
      )),
      out2 = 
      tagList(
       tags$p(class = 'mb-2', 'Total de estabelecimentos com Atenção Primária')
      )
      )

  #' posto de saúde
  #' 
  mod_cards_ui_server('card_hospital_primaria', 
        out1 = reactive(
      tagList(
        tags$h4(class = 'mb-0',
        dados_card_primaria()[[2]])
      )),
      out2 = 
      tagList(
       tags$p(class = 'mb-2', 'Qtd. de Postos de Saúde com Atenção Primária')
      )
      )

  #' publico
  #' 
  mod_cards_ui_server('card_publico_primaria', 
        out1 = reactive(
      tagList(
        tags$h4(class = 'mb-0',
        paste0(dados_card_primaria()[[3]],"%"))
      )),
      out2 = 
      tagList(
       tags$p(class = 'mb-2', 'Percentual de estabelecimentos da Atenção primária, na rede pública')
      )
      )

  #gráfico barra municípios
  output$graf_estab_municipio <- renderApexchart({dadoi <- dado_cnes_basico()
      dadoi <- dadoi[!duplicated(dadoi$co_unidade),]
      dadoi <- with(dadoi, as.data.frame(table(municipio), stringsAsFactors = F))
      dadoi <- dadoi[order(dadoi$Freq, decreasing = T),]
      if(nrow(dadoi) > 1){
        size <- '3000px'
        categoria <- dadoi$municipio
        dado <- dadoi$Freq
        }else{
          size <- 'auto'
          categoria <- list(dadoi$municipio[1])
          dado <- list(dadoi$Freq[1])
        }
      list(
        series = list(list(name = 'Estabelecimentos:',
                      data = dado))
                      ,
        chart = list(type = 'bar',
                      height = size
                       
                      )
                      ,
        plotOptions = list(
          bar = list(
            borderRadius = 4,
            borderRadiusApplication = 'end',
            horizontal = TRUE,
            dataLabels = list(position = 'top')
          )
        )
        ,
        dataLabels = list(enabled = F, style = list(colors = list('#000000')), offsetX = 20)
        ,
        xaxis = list(categories = categoria)
      )
        })


  #'---------------------------------
  #' cnes urgência
   dado_cnes_urgencia <-  mod_data_cnes_server("data_cnes_2", dado_estab_urgencia)
  mod_card_map_server('mapa_urgencia', dado_cnes_urgencia)
  mod_card_map_server_loc('mapa_urgencia_loc', dado_cnes_urgencia)
  mod_card_table_server("card_table_urg_1", dado_cnes_urgencia)

 #'cards
  #' total
  #' 
 dados_card_urgencia <- reactive({
      dadoi <- dado_cnes_urgencia()
      dadoi <- dadoi[!duplicated(dadoi$co_unidade),]
      total <- nrow(dadoi)
      hospital <- nrow(dadoi[which(dadoi$tp_unidade == 5),])
      publico <- round(nrow(dadoi[which(dadoi$publico == 1),])*100/total,2)
      list(total, hospital, publico)

 })

 mod_cards_ui_server('card_total_urgencia', 
        out1 = reactive(
      tagList(
        tags$h4(class = 'mb-0',
        dados_card_urgencia()[[1]])
      )),
      out2 = 
      tagList(
       tags$p(class = 'mb-2', 'Total de estabelecimentos com Urgência')
      )
      )

  #' posto de saúde
  #' 
  mod_cards_ui_server('card_hospital_urgencia', 
        out1 = reactive(
      tagList(
        tags$h4(class = 'mb-0',
        dados_card_urgencia()[[2]])
      )),
      out2 = 
      tagList(
       tags$p(class = 'mb-2', 'Qtd. de Hospitais com Urgência')
      )
      )

  #' publico
  #' 
  mod_cards_ui_server('card_publico_urgencia', 
        out1 = reactive(
      tagList(
        tags$h4(class = 'mb-0',
        paste0(dados_card_urgencia()[[3]],"%"))
      )),
      out2 = 
      tagList(
       tags$p(class = 'mb-2', 'Percentual de estabelecimentos com Urgência, na rede pública')
      )
      )

  #gráfico barra municípios
  output$graf_estab_urg_municipio <- renderApexchart({dadoi <- dado_cnes_urgencia()
      dadoi <- dadoi[!duplicated(dadoi$co_unidade),]
      dadoi <- with(dadoi, as.data.frame(table(municipio), stringsAsFactors = F))
      dadoi <- dadoi[order(dadoi$Freq, decreasing = T),]
      if(nrow(dadoi) > 1){
        size <- '3000px'
        categoria <- dadoi$municipio
        dado <- dadoi$Freq
        }else{
          size <- 'auto'
          categoria <- list(dadoi$municipio[1])
          dado <- list(dadoi$Freq[1])
        }
      list(
        series = list(list(name = 'Estabelecimentos:',
                      data = dado))
                      ,
        chart = list(type = 'bar',
                      height = size
                       
                      )
                      ,
        plotOptions = list(
          bar = list(
            borderRadius = 4,
            borderRadiusApplication = 'end',
            horizontal = TRUE,
            dataLabels = list(position = 'top')
          )
        )
        ,
        dataLabels = list(enabled = F, style = list(colors = list('#000000')), offsetX = 20)
        ,
        xaxis = list(categories = categoria)
      )
        })
  

}
