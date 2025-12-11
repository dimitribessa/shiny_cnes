#' tab atencao primaria
#'
#' @description A tab of 
#' 
#' @noRd
#' 
#' @importFrom shiny tagList fluidRow tags column
#' 
#' @export
#' 
 load('data/dado_estab_cnes.rda')

 tab_primaria <- sneat_tab_item('primaria', active = T,
          tagList( 
            fluidRow(
                column(5,
                tags$h4('CNES - Atenção primária', class = 'mb-0 display-4 text-primary')),
                column(7,
                tags$div(
                  class = 'd-flex flex-row float-right',
                  mod_data_cnes_ui("data_cnes_1")
                ))) #end row
              ,

              fluidRow(class = 'pb-4',
                column(4,
                mod_cards_ui_ui('card_total_primaria','bx bxs-home-heart')),
                column(4,
                mod_cards_ui_ui('card_hospital_primaria', 'bx bxs-book-add')),
                column(4,
                mod_cards_ui_ui('card_publico_primaria' , 'bx  bx-book-open'))
              )
              ,
            fluidRow(
              column(7,
              tags$div(class = 'card',
               tags$div(class = 'card-header nav-align-top',
                sneat_tab_card(
                      sneattab_carditem('mapa_1', 'Cloroplético', active = T),
                      sneattab_carditem('mapa_2', 'Localização', active = F)
                    )
                  )
                  ,
                  sneat_tabcard_items(
                  sneat_tabcard_item('mapa_1', active = T,
              mod_card_map_ui('mapa_atencao_basica')
                  )
                  ,
                  sneat_tabcard_item('mapa_2', active = F,
              mod_card_map_ui('mapa_atencao_basica_loc')
                  )
                  ) #end tabcard_items
              )#end card
              )
              ,
              column(5,
              card(
                 tags$h4(class = 'card-title text-primary mb-3', 'Qtd. de estabelecimentos por município'),
                 apexchartOutput('graf_estab_municipio')
              )
              )
              ,
              column(12,
              tags$div(class = 'pt-6',
              mod_card_table_ui("card_table_1")
              )
              )
             
              
            )
            )#end taglist
            ) #end tab item