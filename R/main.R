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

tabela <- data.frame(
  Indicador = c("Pedestres mortos por dia em 10 anos (DataSUS)",
                "Pedestres mortos por mês em 10 anos (DataSUS)",
                "Pedestres mortos por dia em 5 anos (PRF)",
                "Pedestres mortos por mês em 5 anos (PRF)",
                "Ocupantes de veículos mortos por dia em 5 anos (PRF)",
                "Ocupantes de veículos mortos por mês em 5 anos (PRF)"),
  Valor = c(dados_datasus$mortes_dia,
            dados_datasus$mortes_mes,
            taxas_pedestres_mortos$mortos_por_dia,
            taxas_pedestres_mortos$mortos_por_mes,
            taxas_ocupantes_mortos$mortos_por_dia,
            taxas_ocupantes_mortos$mortos_por_mes)
)

write_csv(tabela, file = "data/tabela_pedestres.csv")
