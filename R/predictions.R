#' Predict the Sweet Sixteen
#'
#' This function takes the model and predicts the Sweet 16 for a
#' season's worth of data.
#' @name predict_s16_teams
#' @importFrom dplyr mutate select arrange desc
#' @importFrom recipes bake
#' @import themis
#' @import stats
#' @import xgboost
#' @param year A given year to describe the data
#'
#' @return a table of teams that we predict will mmake the sweet 16
#'
#' @export

utils::globalVariables(c("CONF", "SEED", "smote_prep", "model", "probs",
                         "cbb_data", "POSTSEASON", "head"))

predict_s16_teams <- function(year) {
  if (year %in% unique(cbb_data$year)) {
    season_data <- cbb_data |>
      dplyr::filter(year == !!year) |>
      dplyr::mutate(
        POSTSEASON =
          ifelse(POSTSEASON %in% c("Champions", "2ND", "F4", "E8"),
            "S16", POSTSEASON
          ),
        team = as.factor(team)
      ) |>
      dplyr::mutate(
        POSTSEASON = as.factor(ifelse(POSTSEASON != "S16", "NS16", "S16"))
      ) |>
      dplyr::select(-c(CONF, SEED))

    season_data_baked <- bake(smote_prep,
      new_data = season_data,
      composition = "data.frame"
    )

    season_data$probs <- predict(model, season_data_baked,
      type = "prob"
    )[, "S16"]
    season_data$preds <- predict(model, season_data_baked)

    predicted_s16 <- season_data |>
      dplyr::filter(probs > 0.5) |>
      dplyr::arrange(desc(probs)) |>
      dplyr::select(team, probs) |>
      head(16)

    predicted_s16
  } else {
    season_data <- cbbdata:::cbb_torvik_ratings() |>
      dplyr::filter(year == !!year)

    season_data_baked <- bake(smote_prep,
      new_data = season_data,
      composition = "data.frame"
    )

    season_data$probs <- predict(model,
      season_data_baked,
      type = "prob"
    )[, "S16"]

    season_data$preds <- predict(model, season_data_baked)

    predicted_s16 <- season_data |>
      dplyr::filter(probs > 0.5) |>
      dplyr::arrange(desc(probs)) |>
      dplyr::select(team, probs) |>
      head(16)

    predicted_s16
  }
}
