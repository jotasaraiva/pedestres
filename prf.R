library(tidyverse)

dados <- read_delim("data/datatran2022.csv", delim = ";")

pedestres_prf <- dados |> 
  filter(tipo_acidente == "Atropelamento de Pedestre")

pedestres_mortos <- pedestres_prf |> 
  filter(mortos > 0)

pedestres_fatais <- pedestres_prf |> 
  filter(classificacao_acidente == "Com V\xedtimas Fatais")

taxa <- nrow(pedestres_mortos)/nrow(pedestres_prf) * 100