library(caret)
library(themis)
library(xgboost)
library(Metrics)
###################### Adjust Data if needed ##################################
data <- cbb_data |>
  dplyr::filter(year != "2020") |>
  mutate(
    POSTSEASON =
      ifelse(POSTSEASON %in% c("Champions", "2ND", "F4", "E8"),
             "S16", POSTSEASON),
    team = as.factor(team)
  ) |>
  mutate(POSTSEASON = as.factor(ifelse(POSTSEASON != "S16", "NS16", "S16"))) |>
  select(-c(CONF, SEED))


train_data <- data |>
  dplyr::filter(!year %in% c(2024)) |>
  mutate(across(where(is.character), as.factor))

test_data <- data |>
  dplyr::filter(year %in% c(2024)) |>
  mutate(across(where(is.character), as.factor))

######################## SMOTE FOR THE DATA AND THE MODEL ######################
smote_recipe <- recipe(POSTSEASON ~ ., data = train_data) |>
  update_role(team, new_role = "id") |>
  step_rm(games.y, games.x, wins, losses, min) |>
  step_smote(POSTSEASON)

# Prep only once on training data
smote_prep <- prep(smote_recipe, retain = TRUE)

# Apply to training data
smote_train <- juice(smote_prep)

# Apply the same transformations to test data
smote_test <- bake(smote_prep, new_data = test_data)

####################### Model ##########################

library(doParallel)

# Detect number of cores and create cluster
cl <- makeCluster(parallel::detectCores() - 1)  # Leave 1 core free
registerDoParallel(cl)

xgb_grid <- expand.grid(
  nrounds = c(200),
  max_depth = c(6),
  eta = c(0.1),
  gamma = c(0),
  colsample_bytree = c(0.7),
  min_child_weight = c(1),
  subsample = c(0.7)
)

set.seed(24)
repeated_oob <- trainControl(
  method = "repeatedcv",
  number = 10,
  repeats = 3,
  classProbs = TRUE,
  summaryFunction = twoClassSummary,
  savePredictions = "final"
)


model <- train(POSTSEASON ~ .,
  data = smote_train |> select(-team),
  trControl = repeated_oob,
  method = "xgbTree",
  metric = "ROC",
  tuneGrid = xgb_grid
)

model$bestTune

stopCluster(cl)
registerDoSEQ()

usethis::use_data(model, overwrite = TRUE)
usethis::use_data(smote_prep, overwrite = TRUE)
