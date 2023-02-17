
#usando a lista de cnpj's obtidos no script 03, devo agora filtrar todas as tabelas 
#buscando o cnpj

library(data.table)
library(dplyr)

cnpjs <- read.csv("C:/Users/jeanalesibr/Desktop/Extract_receita/rf_2023/dados_finais/cnpj_save.csv")  
output_folder <- "C:/Users/jeanalesibr/Desktop/Extract_receita/rf_2023/dados_finais"
caminho_dados <- "C:/Users/jeanalesibr/Desktop/Extract_receita/rf_2023/dados_processamento"


# filtrar socios -----------------------------------------------------------------------------------------------------

socios_to_filter <- list.files(caminho_dados, pattern = ".*\\SOCIOCSV") #pegando as tabelas para filtrar

  socios_lista<-list()
  for(i in 1:length(socios_to_filter)){
    df <- fread(file.path(caminho_dados, socios_to_filter[[i]]),  encoding="Latin-1")

    socios_lista[[i]] <- inner_join(cnpjs, df, by = c("x"="V1"), multiple = "all")
  }
    
  
  socios_df <- do.call("rbind",socios_lista)
  colnames(socios_df) <- c("cnpj_basico","identificador_socio","nome_socio-razao_social","cnpj-cpf_socio",
                           "qualificao_socio","date_entrada_sociedade","pais","representante_legal","nome_representante",
                           "qualificao_representante","faixa_etaria")
  
  socios_df$data <- "02/2023"
  socios_df <- socios_df %>% select(data, everything())
  write.csv(socios_df, file=paste0(output_folder,"/","socios_filtrados.csv"), row.names = FALSE)
  
rm(df, socios_df, socios_lista,i, socios_to_filter)



#filtrar estabelecimentos----------------------------------------------------------------------------------------------


estabele_to_filter <- list.files(caminho_dados, pattern = ".*\\ESTABELE_parte") #pegando as tabelas para filtrar


  estabele_lista <- list()
  for(i in 1:length(estabele_to_filter)){
    df <- fread(file.path(caminho_dados, estabele_to_filter[[i]]),  encoding="Latin-1")
    df <- df[,-1] #contador atrapalhando
    estabele_lista[[i]] <- inner_join(cnpjs, df, by = c("x"="V1"))
  }
  
  
  estabele_df <- do.call("rbind", estabele_lista)
  colnames(estabele_df) <- 
    c("cnpj_basico","cnpj_ordem","cnpj_dv","identificador_matriz_filial","nome_fantasia",
      "situacao_cadastral","date_situacao_cadastral","motivo_situacao_cadastral","nome_cidade_no_exterior",
      "codigo_pais","date_inicio_atividade","cnae_fiscal_principal","cnae_fiscal_secundaria",
      "tipo_logradouro","logradouro","numero","complemento","bairro","cep","uf","municipio",
      "ddd","telefone_1","ddd2","telefone_2","ddd_fax","fax","correio_eletronico","situacao_especial","date_situacao_especial")
  
  
  estabele_df$data <- "02/2023"
  estabele_df <- estabele_df%>% select(data, everything())
  write.csv(estabele_df, file=paste0(output_folder,"/","estabele.csv"), row.names = F)
  
  rm(df, estabele_df, estabele_lista, estabele_to_filter, file)
  
  
#filtrar simples---------------------------------------------------------------------------------------------
  
 
  files_to_filter <- list.files(caminho_dados, pattern = ".*\\SIMPLES.CSV.D30114_parte_") #pegando as tabelas para filtrar
  
  simples_lista <- list()
  for(i in 1:length(files_to_filter)){
    df <- fread(file.path(caminho_dados, files_to_filter[[i]]),  encoding="Latin-1")
    df <- df[,-1] #contador atrapalhando
    simples_lista[[i]] <- inner_join(cnpjs, df, by = c("x"="V1"))
  }
  
  simples_df <- do.call("rbind",simples_lista)
  colnames(simples_df) <- c("cnpj_basico","opition_pelo_simples","date_opcion_simples","date_exclusion_simples",
                            "option_mei","date_option_mei","date_exclusion_mei")
  
  simples_df$data <- "02/2023"
  simples_df <- simples_df %>% select(data, everything())
  write.csv(simples_df, file=paste0(output_folder,"/","simples_filtrados.csv"), row.names = F)
  
  rm(df, simples_df, simples_lista,i, files_to_filter)



  #paises--------------  
  df_paises <- readr::read_delim("dados_processamento/F.K03200$Z.D30114.PAISCSV", 
                          delim = ";", escape_double = FALSE, locale = readr::locale(encoding = "ISO-8859-1"), 
                          trim_ws = TRUE)
  
  df_paises$data <- "02/2023"
  colnames(df_paises) <- c("codigo_pais","nome_pais","data")
  write.csv(df_paises, file=paste0(output_folder,"/","df_paises.csv"), row.names = F)
  
  rm(df_paises)
  #municipios------------------------
  df_municipios <- readr::read_delim("dados_processamento/F.K03200$Z.D30114.MUNICCSV", 
                                 delim = ";", escape_double = FALSE, locale = readr::locale(encoding = "ISO-8859-1"), 
                                 trim_ws = TRUE)
  colnames(df_municipios) <- c("cod_municipio","nome_municipio")
  df_municipios$data <- "02/2023"  
  write.csv(df_municipios, file=paste0(output_folder,"/","df_municipios.csv"), row.names = F)

  rm(df_municipios)
  #QUALIFICAÇÕES DE socios--------------------------------------------------------
  
  df_socios_descricao <- readr::read_delim("dados_processamento/F.K03200$Z.D30114.QUALSCSV", 
                                     delim = ";", escape_double = FALSE, locale = readr::locale(encoding = "ISO-8859-1"), 
                                     trim_ws = TRUE)
  colnames(df_socios_descricao) <- c("cod_qualificacao","qualificacao")
  df_socios_descricao$data <- "02/2023"  
  write.csv(df_socios_descricao, file=paste0(output_folder,"/","df_socios_qualificacao.csv"), row.names = F)  
  
  rm(df_socios_descricao)
  
  #Natureza Juridica--------------------------------------------------------
  
  df_NAT <- readr::read_delim("dados_processamento/F.K03200$Z.D30114.NATJUCSV", 
                                           delim = ";", escape_double = FALSE, locale = readr::locale(encoding = "ISO-8859-1"), 
                                           trim_ws = TRUE)
  colnames(df_NAT) <- c("cod_natureza_juridica","descricao")
  write.csv(df_NAT, file=paste0(output_folder,"/","natureza_juridica.csv"), row.names = F)  
  
  rm(df_NAT)
  # CNAEs--------------------------------------------------------
  
  df_CNAES <- readr::read_delim("dados_processamento/F.K03200$Z.D30114.CNAECSV", 
                              delim = ";", escape_double = FALSE, locale = readr::locale(encoding = "ISO-8859-1"), 
                              trim_ws = TRUE)
  colnames(df_CNAES) <- c("cod_cnae","descricao")
  write.csv(df_CNAES, file=paste0(output_folder,"/","cnaes.csv"), row.names = F)  
  
  rm(df_CNAES)  
  
  
  
  
rm(list = ls())


  
  