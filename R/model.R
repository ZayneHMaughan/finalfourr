#' The model created and used for predictions in this project.
#'
#' An XGBoost model created using parallelization under grid search. This
#'   considers all variables within the data. However, the data under went SMOTE
#'   transformation to train on other things.
#'
#' @format ## 'model'
#'   A list containing a trained model including the best tuning options,
#'    amongst other variables.
#'
#' @source "https://themis.tidymodels.org/reference/step_smote.html"
#' @source "https://topepo.github.io/caret/model-training-and-tuning.html"
