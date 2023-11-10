library(tidyverse)
library(microdatasus)

if (file.exists("data/datasus.Rda")) {
  load("data/datasus.Rda")
} else {
  datasus <- fetch_datasus(
    year_start = 2012,
    year_end = 2022,
    information_system = "SIM-DOEXT"
  )
  save(datasus, file = "data/datasus.Rda")
}

mortes_veic <- datasus |> 
  mutate(DTOBITO = dmy(DTOBITO)) |> 
  filter(
    year(DTOBITO) == 2022 &
    str_detect(CAUSABAS, paste(paste0("V", seq(0, 8, 1)), collapse = "|"))
  )

pedestres_datasus <- mortes_veic |> 
  filter(str_detect(CAUSABAS, "V0"))

taxa_2022 <- nrow(pedestres_datasus)/nrow(mortes_veic) * 100

mortos_por_mes_2022 <- nrow(pedestres_datasus)/12

mortes_veic_10anos <- datasus |> 
  mutate(DTOBITO = dmy(DTOBITO)) |> 
  filter(
      str_detect(CAUSABAS, paste(paste0("V", seq(0, 8, 1)), collapse = "|"))
  )

pedestres_datasus_10anos <- mortes_veic_10anos |> 
  filter(str_detect(CAUSABAS, "V0"))

taxa_10anos <- nrow(pedestres_datasus_10anos)/nrow(mortes_veic_10anos) * 100

mortos_por_mes_10anos <- nrow(pedestres_datasus_10anos)/(5*12)
