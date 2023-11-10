library(tidyverse)
library(roadtrafficdeaths)

mortes_10anos <- rtdeaths |> 
  filter(ano_ocorrencia %in% seq(2012,2022,1))

mortes_pedestres_10anos <- rtdeaths |> 
  filter(ano_ocorrencia %in% seq(2012,2022,1) & cod_modal == "V0")

num_mortes_10anos <- nrow(mortes_10anos)
num_mortes_pedestres_10anos <- nrow(mortes_pedestres_10anos)

taxa_10anos <- num_mortes_pedestres_10anos/num_mortes_10anos

mortes_por_mes <- num_mortes_pedestres_10anos/(12*10)
mortes_por_dia <- num_mortes_pedestres_10anos/(10*365)
