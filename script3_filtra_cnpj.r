library(dplyr)
library(data.table)
library(bit64)


caminho_dados <- "RECEITA_COOP_2023/dados_processamento"
files_to_filter <- list.files(caminho_dados, pattern = ".*\\EMPRECSV") #pegando as tabelas para filtrar
output_folder <- "RECEITA_COOP_2023/dados_finais"


#filtrando cnpjs das coops pela natureza juridica
df_list <- list()
for(i in 1:length(files_to_filter)){
  df <-  fread(file.path(caminho_dados, files_to_filter[[i]]), nrows=10000000, encoding="Latin-1") %>% tibble::as_tibble()
  
  df <- df %>% 
          filter(V3 %in%  c("2143", "2330")) #natureza juridica
  df_list[[i]] <- df
  
  print(i)
 
}

  empresas_filtrado <- do.call("rbind",df_list)

  colnames(empresas_filtrado) <- c("cnpj_basico","NOME","NATUREZA_JURIDICA",
                                      "QUALIFICACAO_DO_RESPONSAVEL",
                                      "CAPITAL_SOCIAL","PORTE","ENTE_FEDERATIVO_RESPONSAVEL")
  
  write.csv(empresas_filtrado, file=paste0(output_folder,"/","empresas_filtradas",".csv"))
  
  #selecionando apenas cnpj's para filtros posteriores
  cnpj_save <- empresas_filtrado$cnpj_basico %>% as.character()
  write.csv(cnpj_save, file=paste0(output_folder,"/","cnpj_save",".csv"), row.names = FALSE)
  
  rm(list=ls())
  
  
