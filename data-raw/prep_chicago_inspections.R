library(tidyverse)
library(arrow)
library(pins)

board <- board_connect_url(c(
  inspection_data = 'https://colorado.posit.co/rsc/inspection_data/'
))

inspections_raw <- board |> pin_read("inspection_data")

inspections <- 
  as_tibble(inspections_raw) |> 
  mutate(across(c("facility_type", "risk", "results"), as.factor),
         inspection_date = ymd(inspection_date)) |> 
  select(results, inspection_date, everything()) |> 
  filter(inspection_date >= "2018-07-01")

summary(inspections$inspection_date)

path1 <- here::here("data", "inspections.parquet")
path2 <- here::here("data", "inspections_monitoring.parquet")

inspections |> 
  filter(inspection_date < ymd("2023-01-01")) |>
  arrange(inspection_date) |> 
  write_parquet(path1)

inspections |> 
  filter(inspection_date >= ymd("2023-01-01")) |> 
  arrange(inspection_date) |> 
  write_parquet(path2)

library(tidymodels)
set.seed(123)
inspect_split <- inspections |> 
  filter(inspection_date < ymd("2023-01-01")) |>
  arrange(inspection_date) |> 
  initial_split(prop = 0.8)

inspect_train <- training(inspect_split)
inspect_test <- testing(inspect_split)

inspection_rec <- 
  recipe(results ~ facility_type + risk + total_violations + inspection_date, 
         data = inspect_train) |> 
  step_date(inspection_date, features = c("month", "year"), keep_original_cols = FALSE)

inspect_fit <-
  workflow(
    inspection_rec, 
    rand_forest(mode = "classification", trees = 1e3)
  ) |> 
  fit(data = inspect_train)

augment(inspect_fit, new_data = slice_sample(inspect_test, n = 10)) |> 
  select(-aka_name)

library(vetiver)
library(pins)

v <- vetiver_model(inspect_fit, "julia.silge/chicago-inspections-rstats")
board <- board_connect()
board |> vetiver_pin_write(v)

vetiver_deploy_rsconnect(
  board = board, 
  name = "julia.silge/chicago-inspections-rstats",
  predict_args = list(type = "prob", debug = TRUE),
  account = "julia.silge",
  appName = "chicago-inspections-rstats-model-api",
  forceUpdate = TRUE
)
