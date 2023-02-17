#script descompactação de arquivos - OPCIONAL

library(data.table)

#Descompactando tudo-----------------------
endereco_dados_entrada <- "RECEITA_COOP_2023/dados_entrada"
lista_arquivos_compactados  <- list.files(endereco_dados_entrada) 


  for(arquivo in lista_arquivos_compactados ){
    unzip(
          file.path(endereco_dados_entrada, arquivo),
          exdir = ("RECEITA_COOP_2023/dados_processamento")
          )
  }

# fim descompactacao ------------------------------------------------------

  

  