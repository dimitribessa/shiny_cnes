 #' Create custom HTML dependencies
#' 
#' @return An htmlDependency object
#' @export
 
 sneat_tools <- function(){

  htmltools::htmlDependency(
    name = "sneat",
    version = "1.0",
    src = c(file = system.file("app/www", package = "golem.sneattemplate")),#'inst/app/www',
    script = list("assets/vendor/libs/jquery/jquery.js",'assets/vendor/libs/popper/popper.js',
            'assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.js','assets/vendor/js/menu.js',
            'assets/js/main.js','assets/js/dashboards-analytics.js', 'vendor/libs/apex-charts/apexcharts.js')
  )
 }

 #' @export
 # Bootstrap 4 dependencies
 bs4_deps <- function(){htmlDependency(
  name = "Bootstrap",
  version = "4.6.2",
  src = c(href = "https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/"), # "https://stackpath.bootstrapcdn.com/bootstrap/5.3.2/"), #
  script = "js/bootstrap.bundle.min.js",
  stylesheet = 'css/bootstrap.min.css'
)
 }
