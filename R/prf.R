library(tidyverse)

# Importação
files <- here::here("data","acidentes",
                    list.files(here::here("data","acidentes")))

df <- read_delim(
  files,
  delim = ";",
  locale = locale(decimal_mark = ",",
                  encoding = "Latin1")
)

# Pedestres de 2018 a 2022
acidentes_pedestres <- df |> 
  mutate(ano = year(data_inversa)) |> 
  filter(tipo_envolvido == "Pedestre")

estados_pedestres <- acidentes_pedestres |> 
  summarise(.by = estado_fisico, n = n())

num_pedestres_mortos <- 
  estados_pedestres$n[estados_pedestres$estado_fisico == "Óbito"]

num_pedestres_acidentes <- nrow(acidentes_pedestres)

taxa_5anos <- num_pedestres_mortos/num_pedestres_acidentes

mortos_por_mes <- num_pedestres_mortos/(5*12)
mortos_por_dia <- num_pedestres_mortos/(5*365)

acidentes_veiculos <- df |> 
  mutate(ano = year(data_inversa)) |> 
  filter(tipo_envolvido %in% c("Condutor","Passageiro"))

estados_veiculos <- acidentes_veiculos |> 
  summarise(.by = estado_fisico, n = n())

num_veiculos_acidentes <- nrow(acidentes_veiculos)

num_veiculos_mortos <- 
  estados_veiculos$n[estados_veiculos$estado_fisico == "Óbito"]

mortos_veic_mes <- num_veiculos_mortos/(5*12)
mortos_veic_dia <- num_veiculos_mortos/(5*365)

taxa_veic <- num_veiculos_mortos/num_veiculos_acidentes

# Pedestres 2022
acidentes_pedestres2022 <- df |> 
  mutate(ano = year(data_inversa)) |> 
  filter(tipo_envolvido == "Pedestre" & ano == 2022)

estados_pedestres2022 <- acidentes_pedestres2022 |> 
  summarise(.by = estado_fisico, n = n())

num_pedestres_mortos2022 <- 
  estados_pedestres2022$n[estados_pedestres2022$estado_fisico == "Óbito"]

num_pedestres_acidentes2022 <- nrow(acidentes_pedestres2022)

taxa_2022 <- num_pedestres_mortos2022/num_pedestres_acidentes2022

mortos_por_mes2022 <- num_pedestres_mortos2022/12