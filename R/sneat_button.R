 #' sneat template for action button
 #' @import shiny
 #' 
 #' @export
 #' 
 #' 
 
 sneat_button <- function(inputId, label, icon = NULL, width = NULL, disabled = FALSE, 
    ...){
    button <- actionButton(inputId, label, icon, width, disabled, 
    ...)

    button <- tagAppendAttributes(button, class = 'btn_primary')
    button
      }