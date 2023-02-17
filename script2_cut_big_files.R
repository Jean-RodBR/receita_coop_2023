#REFAZENDO--------------------------
library(data.table)

#VOU CORTA OS ARQUIVOS MUITO GRANDES QUE NÃO CONSIGO PROCESSAR DIREITO
#NO CASO SÃO OS COM TERMINAÇÃO ESTABELE E SIMPLES
#JUNTO TUDO EM UMA LISTA E MANDO CORTAR TUDO DE UMA VEZ

dados_caminho <- "C:/Users/jeanalesibr/Desktop/Extract_receita/rf_2023/dados_processamento"

files_to_filter <-  list.files(dados_caminho, pattern = c(".*\\ESTABELE")) 
files_to_filter <- c(files_to_filter, list.files(dados_caminho, pattern = c(".*\\SIMPLES.CSV")))

                             
#mecanismo de separação--------------------------------------------------------------------------------------

for(j in 1:length(files_to_filter)){
  index <- 0
  counter <- 0
  total <- 0
  chunks <- 1000000
  fileName <- file.path(dados_caminho, files_to_filter[[j]])
  
  repeat{
    # With fread file is opened in each iteration
    dataChunk <- fread(input = fileName, nrows=chunks, header=FALSE, skip = chunks*index,  encoding="Latin-1") #,fill = TRUE,                 
    
    # Create a new file name and write to it. You can have your own logic for file names
    write.csv(dataChunk, file = paste0(dados_caminho,"/",files_to_filter[[j]],"_parte_",index,"cut",".csv"))
    
    #check if file end has been reached and break from repeat
    if(nrow(dataChunk) < chunks){
      break
    }
    
    #increment the index to read next chunk
    index = index+1
    
  }
  
}


#apagando os dados originais já depois de cortados---------------------------------------------------------
  file.remove(file.path(dados_caminho, files_to_filter))
  rm(list = ls())








