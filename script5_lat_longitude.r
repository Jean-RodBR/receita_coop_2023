#script 6
#adicionando latitude e longitude de cada municipío

library(dplyr)
library(readr)

  muni_lat_long <- read_csv("municipios-2023.csv", 
                            col_types = cols(siafi_id = col_character())) 
  df_municipios <- read_csv("dados_finais/df_municipios.csv", 
                            col_types = cols(cod_municipio = col_character()))

  df_municipios <- df_municipios %>% left_join(muni_lat_long, by = c("cod_municipio"="siafi_id"))
  df_municipios <- df_municipios %>% select(data, cod_municipio, codigo_ibge, codigo_uf, nome_municipio, nome, everything())

  
  write.csv(df_municipios, 
                   file=paste0("C:/Users/jeanalesibr/Desktop/Extract_receita/rf_2023/dados_finais","/","df_municipios.csv"),
                      row.names = F) 

  
  
  
  rm(df_municipios, muni_lat_long)

  
  
  
  
  