library(dplyr)
    #juntar esbelecimentos com empresas

    #importar dados da pasta dados_finais
    estabelecimentos <- read.csv("/workspaces/receita_coop_2023/dados_finais/estabele.csv", sep = ",")
    empresas <- read.csv("/workspaces/receita_coop_2023/dados_finais/empresas_filtradas.csv", sep = ",") %>% select(-X, NOME)
    
    
    #transformando ambas em tibbles
    estabelecimentos <- tibble::as_tibble(estabelecimentos)
    empresas <- tibble::as_tibble(empresas)

    empresas %>% head(10)

    #juntando as tabelas com suffix
    dados_cnpj_2023 <- 
        left_join(estabelecimentos, empresas, 
            by = "cnpj_basico", 
            suffix = c("_estabelecimento", "_empresa"))

  
    #salvando a tabela
    write.csv(dados_cnpj_2023, "/workspaces/receita_coop_2023/dados_finais/dados_cnpj_2023.csv", row.names = FALSE)
    
    #juntar socios com socios qualificacao

    #importar dados da pasta dados_finais
    socios <- read.csv("/workspaces/receita_coop_2023/dados_finais/socios_filtrados.csv", sep = ",")
    socios_qualificacao <- read.csv("/workspaces/receita_coop_2023/dados_finais/df_socios_qualificacao.csv", sep = ",")

    #transformando ambas em tibbles
    socios <- tibble::as_tibble(socios) %>% rename(cod_qualificacao = qualificao_socio)
    socios_qualificacao <- tibble::as_tibble(socios_qualificacao)

    #juntando as tabelas com suffix
    socios_cnpj_2023 <- 
        left_join(socios, socios_qualificacao, 
            by = "cod_qualificacao", 
            suffix = c("_socios", "_socios_qualificacao"))


    #visualizando a tabela
    #socios_cnpj_2023 %>% View(10)

    #salvando a tabela
    write.csv(socios_cnpj_2023, "/workspaces/receita_coop_2023/dados_finais/socios_cnpj_2023.csv", row.names = FALSE)

    
