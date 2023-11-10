library(tidyverse)
library(roadtrafficdeaths)
source("R/scripts.R")

files <- here::here("data","acidentes",
                    list.files(here::here("data","acidentes")))

prf <- read_delim(
  files,
  delim = ";",
  locale = locale(decimal_mark = ",",
                  encoding = "Latin1")
)

dados_datasus <- extract_datasus(year_start = 2012, year_end = 2021)

dados_prf_pedestres <- extract_pedestres_prf(prf)

dados_prf_ocupantes <- extract_ocupantes_prf(prf)

taxas_pedestres_mortos <- list(
  mortos_por_mes = (dados_prf_pedestres$pedestres_mortos)/(5*12),
  mortos_por_dia = (dados_prf_pedestres$pedestres_mortos)/(5*365)
)

taxas_ocupantes_mortos <- list(
  mortos_por_mes = (dados_prf_ocupantes$ocupantes_mortos)/(5*12),
  mortos_por_dia = (dados_prf_ocupantes$ocupantes_mortos)/(5*365)
)