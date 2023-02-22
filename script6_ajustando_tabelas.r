library(dplyr)
    #juntar esbelecimentos com empresas

    #importar dados da pasta dados_finais
    estabelecimentos <- read.csv("/workspaces/receita_coop_2023/dados_finais/estabele.csv", sep = ",")
    empresas <- read.csv("/workspaces/receita_coop_2023/dados_finais/empresas_filtradas.csv", sep = ",")


    #transformando ambas em tibbles
    estabelecimentos <- tibble::as_tibble(estabelecimentos)
    empresas <- tibble::as_tibble(empresas)

    #juntando as tabelas com suffix
    dados_cnpj_2023 <- 
        left_join(estabelecimentos, empresas, 
            by = "cnpj_basico", 
            suffix = c("_estabelecimento", "_empresa"))

    #salvando a tabela
    write.csv(dados_cnpj_2023, "/workspaces/receita_coop_2023/dados_finais/dados_cnpj_2023.csv", row.names = TRUE)
    
