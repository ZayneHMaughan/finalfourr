#' The model created and used for predictions in this project.
#'
#' An XGBoost model created using parallelization under grid search. This
#' considers all variables within the data. However, the data underwent SMOTE
#' transformation before training.
#'
#' @format A trained model object, typically from the `parsnip` or `caret`
#'   package.
#'
#' @source \url{https://themis.tidymodels.org/reference/step_smote.html}
#' @source \url{https://topepo.github.io/caret/model-training-and-tuning.html}
"model"
