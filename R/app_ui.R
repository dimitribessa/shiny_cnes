#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @import shiny magrittr
#' @noRd
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),

    tags$body(
      tags$div(class = "layout-wrapper layout-content-navbar",
        tags$div(class = 'layout-container',
        sneat_menunav(logo = logo_model(),
          sneat_menu(
            sneat_menuitem( 'primaria', 'Atenção primária',iclass = NULL, active = T),
            sneat_menuitem('urgencia', 'Urgência', iclass = NULL, active = F)
          ))
          ,
          sneat_tab_items(
            tab_primaria
            ,
            tab_urgencia
          )
        
        )
      )
      ,
      HTML(
        ' <!-- Bootstrap 4 JS and dependencies -->
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
     '
      )
    )#end body


  )
}

#' Add external Resources to the Application
#'
#' This function is internally used to add external
#' resources inside the Shiny application.
#'
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function() {
  add_resource_path(
    "www",
    app_sys("app/www")
  )

  tags$head(
    #favicon(),
  #  bundle_resources(
  #    path = app_sys("app/www"),
  #    app_title = "golem.sneattemplate"
  #  )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert()
    #,
    
    #fonts
    htmltools::tags$link( rel="preconnect", href="https://fonts.googleapis.com"),
    htmltools::tags$link(rel="preconnect", href="https://fonts.gstatic.com"),
    htmltools::tags$link(href="https://fonts.googleapis.com/css2?family=Public+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&display=swap",
      rel="stylesheet")

    ,
    htmltools::tags$link( rel="stylesheet" , href="www/assets/vendor/fonts/iconify-icons.css"),
    #css
    htmltools::tags$link(rel="stylesheet", href="www/assets/vendor/css/core.css"),
    htmltools::tags$link( rel="stylesheet", href="www/assets/css/demo.css"),
    #vendors css
    htmltools::tags$link(rel="stylesheet", href="www/assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css"),
    #helpers
    htmltools::tags$script( src="www/assets/vendor/js/helpers.js"),
    htmltools::tags$script( src="www/assets/js/config.js")
    ,
    bs4_deps()
    ,
    HTML('<script>
        // Add this to ensure proper initialization with our custom classes
        $(document).ready(function() {
            $(".menu-link").on("click", function(e) {
                e.preventDefault();
                $(this).tab("show");
            });
        });
    </script>')
  
  )
}
