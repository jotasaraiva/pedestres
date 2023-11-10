extract_datasus <- function(df) {
  
  mortes_10anos <- rtdeaths |> 
    filter(ano_ocorrencia %in% seq(2012,2022,1))
  
  mortes_pedestres_10anos <- rtdeaths |> 
    filter(ano_ocorrencia %in% seq(2012,2022,1) & cod_modal == "V0")
  
  num_mortes_10anos <- nrow(mortes_10anos)
  num_mortes_pedestres_10anos <- nrow(mortes_pedestres_10anos)
  
  taxa_10anos <- num_mortes_pedestres_10anos/num_mortes_10anos
  
  mortes_por_mes <- num_mortes_pedestres_10anos/(12*10)
  mortes_por_dia <- num_mortes_pedestres_10anos/(10*365)
  
  return(list(
    mortes_dia = mortes_por_dia,
    mortes_mes = mortes_por_mes
  ))
}


extract_pedestres_prf <- function(df) {
  
  acidentes <- df |> 
    mutate(ano = year(data_inversa)) |> 
    filter(tipo_envolvido == "Pedestre")
  
  acidentes_est_fisicos <- acidentes |> 
    summarise(.by = estado_fisico, n = n())
  
  num_pedestres_mortos <- 
    acidentes_est_fisicos$n[acidentes_est_fisicos$estado_fisico == "Óbito"]

  num_pedestres_acidentes <- nrow(acidentes)
  
  return(list(
    pedestres_mortos = num_pedestres_mortos,
    pedestres_acidentes = num_pedestres_acidentes
  ))
}

extract_ocupantes_prf <- function(df) {
  
  acidentes <- df |> 
    mutate(ano == year(data_inversa)) |> 
    filter(tipo_envolvido %in% c("Condutor", "Passageiro"))
  
  acidentes_est_fisico <- acidentes |> 
    summarise(.by = estado_fisico, n = n())
  
  num_ocupantes_mortos <-
    acidentes_est_fisico$n[acidentes_est_fisico$estado_fisico == "Óbito"]
  
  num_ocupantes_acidentes <- nrow(acidentes)
  
  return(list(
    ocupantes_mortos = num_ocupantes_mortos,
    ocupantes_acidentes = num_ocupantes_acidentes
  ))
}