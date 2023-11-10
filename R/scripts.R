extract_datasus <- function(year_start, year_end) {
  
  if(year_end < year_start) {
    return(stop("year_start greater than year_end"))
  } else {
    mortes_por_anos <- rtdeaths |> 
      filter(ano_ocorrencia %in% seq(year_start,year_end,1))
    
    mortes_pedestres_por_anos <- rtdeaths |> 
      filter(ano_ocorrencia %in% seq(year_start,year_end,1) & cod_modal == "V0")
    
    num_mortes <- nrow(mortes_por_anos)
    num_mortes_pedestres <- nrow(mortes_pedestres_por_anos)
    
    taxa_anos <- num_mortes_pedestres/num_mortes
    
    mortes_por_mes <- num_mortes_pedestres/(12*10)
    mortes_por_dia <- num_mortes_pedestres/(10*365)
    
    return(list(
      mortes_dia = mortes_por_dia,
      mortes_mes = mortes_por_mes
    ))
  }
}


extract_pedestres_prf <- function(df) {
  
  acidentes <- df |>
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