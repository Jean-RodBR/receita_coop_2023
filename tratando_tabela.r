library(dplyr)


#importando dados_cnpj_2023 de dados_finais
dados_cnpj_2023 <- read.csv("/workspaces/receita_coop_2023/dados_finais/dados_cnpj_2023.csv",
                            sep = ",")

#pesquisando em todas as colunas um valor

dados_cnpj_2023  <- dados_cnpj_2023 %>% mutate_all(trimws) %>% tibble::as_tibble()
      
     write.csv(dados_cnpj_2023, "/workspaces/receita_coop_2023/dados_finais/dados_cnpj_2023.csv", row.names = FALSE)
                    
        