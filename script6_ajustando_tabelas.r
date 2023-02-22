library(dplyr)

#transformar de acordo com o padrão
#socios_cnpj_2023: cnpj, cnpj_basico, razao_social, 
                    #identificador_de_socio, nome_socio, cnpj_cpf_socio, 
                    #qualificacao_socio, data_entrada_sociedade, pais,
                    # representante_legal, nome_representante, 
                    #qualificacao_representante_legal, faixa_etaria


#começando por socios------
socios_2023 <- read.csv("dados_finais/socios_filtrados.csv", sep = ",")
        
    #retirar coluna data, alterar nome cnpj.cpf_socio para cnpj_cpf_socio, add cnpj_inteiro
socios_2023 <- socios_2023 %>% 
                    select(-data) %>% 
                    rename(cnpj_cpf_socio = cnpj.cpf_socio)
    
        




#dados_cnpj_2023: cnpj, matriz_filial, razao_social, nome_fantasia,
                    #situacao_cadastral, data_situacao_cadastral, motivo_situacao_cadastral, 
                    #cnpj_basico, cnpj_ordem, cnpj_dv, nome_cidade_exterior,pais,data_inicio_atividades,
                    #cnae_fiscal,cnae_fiscal_secundaria,tipo_logradouro,logradouro,numero,complemento,bairro,cep, 
                    #uf,municipio, ddd1,telefone1,ddd2,telefone2,ddd_fax,fax,correio_eletronico,situacao_especial,
                    #data_situacao_especial,natureza_juridica,qualificao_responsavel,porte_empresa,
                    #ente_federativo_responsavel,capital_social,regiao,data,descricao_cnae_fiscal

#cnae: cnpj, cnae_secundario, data, descricao_cnae_subclasse, descricao_cnae_divisao
                    

    

 

