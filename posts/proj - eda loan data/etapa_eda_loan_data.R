
# Análise exploratória de dados: 

# Conjunto de dados: datasets/loan_data.csv
## https://www.kaggle.com/datasets/saramah/loan-data/data

# Pacotes e conjunto de dados ---------------------------------------------

library(tidyverse)
library(enoqueR)
library(gt)

dados = read_csv("datasets/loan_data.csv")


dados %>% enoqueR::overall_info()

dados %>% enoqueR::overall_tipos()

dados %>% View()

dados %>% variaveis() %>% gt() %>% fmt_number()


variaveis_pt <- c(
  "politica_credito" = "credit.policy",
  "proposito_emp" = "purpose",
  "taxa_juros" = "int.rate",
  "parcela_mensal" = "installment",
  "log_renda_anual" = "log.annual.inc",
  "indice_divida_renda" = "dti",
  "pontuacao_fico" = "fico",
  "dias_com_credito" = "days.with.cr.line",
  "saldo_rotativo" = "revol.bal",
  "taxa_utilizacao_rotativa" = "revol.util",
  "consultas_ultimos_6_meses" = "inq.last.6mths",
  "atrasos_ultimos_2_anos" = "delinq.2yrs",
  "registros_publicos_negativos" = "pub.rec"
)



dados <- dados %>% 
  rename(all_of(variaveis_pt)) %>% 
  mutate(proposito_emp = case_when(
    proposito_emp == "credit_card" ~ "Cartão de credito",
    proposito_emp == "debt_consolidation" ~ "Consolidação de divida",
    proposito_emp == "educational" ~ "Educacional",
    proposito_emp == "major_purchase" ~ "Compra grande",
    proposito_emp == "small_business" ~ "Pequeno Negócio",
    proposito_emp == "all_other" ~ "Outro",
    .default = proposito_emp
    ),
    politica_credito = fct(if_else(politica_credito == 1, "Sim", "Não"), levels = c("Não", "Sim"))
  )


dados %>% 
  enoqueR::tbl_resumo()


dados %>% 
  dplyr::sample_n(5000) %>% 
  enoqueR::eda_tabela_dataset_geral() %>% 
  gt()

dados %>% 
  enoqueR::eda_visual_dataset_cat()

dados %>% 
  enoqueR::eda_visual_dataset_densidade()

