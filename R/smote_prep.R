#' A specific preparation that transforms the data for predictions.
#'
#' Using the `recipes` package, this preparation ensures that the data is in
#' a format suitable for the trained model to make predictions. This includes
#' SMOTE resampling and variable transformations.
#'
#' @format A `recipe` object, typically including 11 components such as
#' term info, variable roles, blueprint, template data, and more.
#'
#' @source \url{https://recipes.tidymodels.org/}
#' @source \url{https://workflows.tidymodels.org/}
"smote_prep"
