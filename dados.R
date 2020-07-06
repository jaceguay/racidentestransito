library(tidyverse)
library(lubridate)
setwd("/home/jaceguay/Documentos/Projetos/posBigData/04 - Visualização de Dados/apresentação")

#rm(list = ls())

# carregar csv
dados <- read.csv("dados.csv")
dados$mes <- as.factor(dados$mes)
dados$data <- ymd(dados$data)
dados$hora_inteira <- as.factor(substr(dados$hora, 1, 2))
dados$bairro <- as.factor(dados$bairro)
dados$dia_semana <- as.factor(dados$diaSemana)
dados$intersecao <- as.factor(dados$intersecao)

head(dados)
tail(dados)
str(dados)
summary(dados)
View(dados)

# agrupar por mes campo mes (character)
agregado_mes <- dados %>%
    count("mes" = mes, name = "ocorr") %>%
    arrange(match(mes, c(
        "Janeiro", "Fevereiro", "Março", "Abril"
    )))

# janeiro total ocorrências
agregado_mes[1:1, 1:2]

# Abril, soma dias da semana
abril_dias_semana <- dados %>%
    count("dia" = diaSemana, name = "total")
View(abril_dias_semana)

# Abril, soma horas dia
abril_horario <- dados %>%
    count("hora" = hora_inteira, name = "total")
head(abril_horario)
View(abril_horario)

# extra top 10 com filtro por nome
#top10b <- dados %>%
#    count("cruzamento" = intersecao, name = "total") %>%
#    arrange(desc(total)) %>%
#    subset(grepl("José", cruzamento))
#View(top10b)

# Top 10 vias e horário
top10.vias <- dados %>%
    count("cruzamento" = intersecao, name = "total") %>%
    arrange(desc(total)) %>%
    subset(cruzamento != "") %>%
    head(10)
View(top10.vias$cruzamento)

top10 <- dados %>%
    count("cruzamento" = intersecao, "hora" = hora_inteira, name = "total") %>%
    arrange(desc(total)) %>%
    subset(cruzamento != "") %>%
    group_by(cruzamento) %>%
    filter(cruzamento %in% top10.vias$cruzamento)

View(top10.horario)
str(top10.horario)

# Progressão ao longo de cada mês
agregMes <- dados %>% count(mes = month(dados$data), name = 'total')
View(agregMes)

agregMesDia <- dados %>%
  count(
    mes = month(dados$data),
    dia = day(dados$data),
    name = 'total'
  )
View(agregMesDia)

janeiro <- subset(agregMesDia, agregMesDia$mes == 1)
janeiro$acum <- cumsum(janeiro$total)
janeiro$diasemana <-
  wday(ymd(paste('2019', janeiro$mes, janeiro$dia, sep = '-')),
       label = TRUE,
       locale = Sys.getlocale("LC_TIME"))
View(janeiro)

fevereiro <- subset(agregMesDia, agregMesDia$mes == 2)
fevereiro$acum <- cumsum(fevereiro$total)
fevereiro$diasemana <-
  wday(ymd(paste(
    '2019', fevereiro$mes, fevereiro$dia, sep = '-'
  )),
  label = TRUE,
  locale = Sys.getlocale("LC_TIME"))

marco <- subset(agregMesDia, agregMesDia$mes == 3)
marco$acum <- cumsum(marco$total)
marco$diasemana <-
  wday(ymd(paste('2019', marco$mes, marco$dia, sep = '-')),
       label = TRUE,
       locale = Sys.getlocale("LC_TIME"))

abril <- subset(agregMesDia, agregMesDia$mes == 4)
abril$acum <- cumsum(abril$total)
abril$diasemana <-
  wday(ymd(paste('2019', abril$mes, abril$dia, sep = '-')),
       label = TRUE,
       locale = Sys.getlocale("LC_TIME"))

# Análise
dados2 <- read.csv("dbexpandido.csv")
View(dados2)

# Mapa