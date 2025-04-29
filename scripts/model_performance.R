####################### SEE HOW THE MODEL PERFORMS ###########################
preds <- predict(model, smote_test)
Metrics::accuracy(smote_test$POSTSEASON, preds)
Metrics::precision(ifelse(smote_test$POSTSEASON == "S16", 1, 0),
                   ifelse(preds == "S16", 1, 0))
Metrics::recall(ifelse(smote_test$POSTSEASON == "S16", 1, 0),
                ifelse(preds == "S16", 1, 0))
probs <- predict(model, smote_test, type = "prob")[, "S16"]
# Convert ground truth to binary
truth_binary <- ifelse(smote_test$POSTSEASON == "S16", 1, 0)
# pred_binary <- ifelse(preds == "S16", 1, 0)
# Metrics::f1(truth_binary, pred_binary)
# Now calculate AUC
Metrics::auc(truth_binary, probs)

2 * Metrics::precision(
  ifelse(smote_test$POSTSEASON == "S16", 1, 0),
  ifelse(preds == "S16", 1, 0)
) * Metrics::recall(
  ifelse(smote_test$POSTSEASON == "S16", 1, 0),
  ifelse(preds == "S16", 1, 0)
) / (Metrics::recall(
  ifelse(smote_test$POSTSEASON == "S16", 1, 0),
  ifelse(preds == "S16", 1, 0)
) + Metrics::precision(
  ifelse(smote_test$POSTSEASON == "S16", 1, 0),
  ifelse(preds == "S16", 1, 0)
))

smote_test$preds <- preds
smote_test$probs <- probs # probability of being S16

# Filter for teams predicted to be Sweet 16
predicted_s16 <- smote_test %>%
  filter(preds == "S16") %>%
  arrange(desc(probs)) %>%
  select(team, probs, preds, POSTSEASON)

print(predicted_s16)


season_2020 <- cbb_data |>
  dplyr::filter(year == 2020) |>
  mutate(
    POSTSEASON =
      ifelse(POSTSEASON %in% c("Champions", "2ND", "F4", "E8"),
             "S16", POSTSEASON),
    team = as.factor(team)
  ) |>
  mutate(POSTSEASON = as.factor(ifelse(POSTSEASON != "S16", "NS16", "S16"))) |>
  select(-c(CONF, SEED))

season_2020_baked <- bake(smote_prep, new_data = season_2020,
                          composition = "data.frame")


preds_2020 <- predict(model, season_2020_baked)

season_2020$probs <- predict(model, season_2020_baked,
                             type = "prob")[, "S16"]
season_2020$preds <- predict(model, season_2020_baked)

predicted_s16_2020 <- season_2020 %>%
  #filter(probs > 0.1) %>%
  arrange(desc(probs)) %>%
  select(team, probs) %>%
  head(n=16)

print(predicted_s16_2020)
