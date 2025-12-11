 #' sneat template for select input
 #' @import shiny
 #' 
 #' @export
 #' 
  
 sneat_select <- function(inputId, label, choices, selected = NULL, multiple = FALSE, 
    selectize = TRUE, width = NULL, size = NULL){

    select <- selectInput(
            inputId, label, choices, selected , multiple, 
    selectize, width, size)

    select$children[[1]] <- tagAppendAttributes(select$children[[1]], class = 'form-label', from = inputId)
    select
      }
