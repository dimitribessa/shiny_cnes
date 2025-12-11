 #' ui Sneat cards
 #' 
 #' @return card functions
 #' @import htmltools
 #' @export
 #' 
  
  card_h100 <- function(...){
    tagList(
        div(class = 'card h-100',
            div(class = 'card-body', 
            ...))
    )
  }

  card <- function(...){
    tagList(
        div(class = 'card', style = 'max-height: 450px;',
            div(class = 'card-body', style = 'overflow-y: auto;', 
            ...))
    )
  }