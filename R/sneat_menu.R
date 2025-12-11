 #' ui Sneat functions 

 #' @return html menu
 #' @import htmltools
 #' @export
 
  sneat_menunav <- function(...,id = 'layout-menu', logo = NULL){
    tagList(
        tags$aside(id= id,  class="layout-menu menu-vertical menu bg-menu-theme",
        tags$div(class = 'app-brand demo', logo),
        HTML('<div class="menu-divider mt-0"></div>
          <div class="menu-inner-shadow"></div>'),
        ...
        )
    )
  }

  sneat_logo <- function(...){
    tagList(
        ...
        ,
        HTML('<a href="javascript:void(0);" class="layout-menu-toggle menu-link text-large ms-auto">
              <i class="bx bx-chevron-left d-block d-xl-none align-middle"></i>
            </a>')
    )
  }

  sneat_menu <- function(...){
    tags$ul(class = "menu-inner py-1 nav", #`data-bs-toggle` = 'tab',
        role = 'tablist',
        ...
        ,
         tags$script(HTML("
      $('.menu .menu-item').on('click', function(){
      $('.menu').find('li.active').removeClass('active');
      $(this).addClass('active')});
      
   ")),
   tags$script(HTML("Shiny.bindGenericInputs = false;"))
   )
  }

  sneat_menuitem <- function(tabName, text, iclass = NULL, active = T, ...){
    ativo <- paste('menu-item nav-item', if(active){'active'})

    tagList(
      tags$li(class = ativo, 
        tags$a(href= paste0("#", tabName),
        id = paste0(tabName, '-menu'),
         class="menu-link nav-link",
         `data-toggle` = "tab",
         `data-target` = paste0("#", tabName),
        #`data-bs-value` = tabName,
         role = "tab",
         iclass,
         tags$div(class = 'text-truncate', `data-i18n` = text, 
         text)
        ),
        ...
      )
    )
  }

  
 sneat_tab_items <- function(...) {
  div(class = "layout-page",
  div(class = "tab-content", ...)
  )
}

 sneat_tab_item <- function(tabName = NULL, active = T, ...) {
  item_cl <- paste("tab-pane fade container-wrapper", if(active) 'active show')
  div(
    role = "tabpanel",
    class =  item_cl,
    id = tabName,
    `data-value` = tabName,
    div(class="container-xxl flex-grow-1 container-p-y",
    ...)
  )
}

 #' tab menu para os cards (add em 22-out-225, 22h)
 
 sneat_tab_card <- function(...){
    tags$ul(class = "nav nav-pills flex-wrap row-gap-2", #`data-bs-toggle` = 'tab',
        role = 'tablist',
        ...
        ,
        
   tags$script(HTML("Shiny.bindGenericInputs = false;"))
   )
  }

  sneattab_carditem <- function(tabName, text, active = T, ...){
    ativo <- paste('nav-item', if(active){'active'})

    tagList(
      tags$li(class = ativo, 
        tags$button(#href= paste0("#", tabName),
        #id = paste0(tabName, '-menu'),
         class= paste("nav-link", if(active){'active'}),
         `data-toggle` = "tab",
         `data-target` = paste0("#", tabName),
         `aria-controls` = tabName,
         `aria-selected` = if(active){'true'}else{'false'},
        #`data-bs-value` = tabName,
         role = "tab",
         `data-i18n` = text, 
         text)
        ,
        ...
      )
    )
  }
  

 sneat_tabcard_items <- function(...) {
  div(class = "tab-content", ...)
  
}

 sneat_tabcard_item <- function(tabName = NULL, active = T, ...) {
  item_cl <- paste("tab-pane fade", if(active) 'active show')
  div(
    role = "tabpanel",
    class =  item_cl,
    id = tabName,
    `data-value` = tabName,
    ...
  )
}
