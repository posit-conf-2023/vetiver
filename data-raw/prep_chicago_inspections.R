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
  select(results, inspection_date, everything())

summary(inspections$inspection_date)

path1 <- here::here("data", "inspections.parquet")
path2 <- here::here("data", "inspections_monitoring.parquet")

inspections |> 
  filter(inspection_date < ymd("2022-01-01")) |>
  arrange(inspection_date) |> 
  write_parquet(path1)

inspections |> 
  filter(inspection_date >= ymd("2022-01-01")) |> 
  arrange(inspection_date) |> 
  write_parquet(path2)
