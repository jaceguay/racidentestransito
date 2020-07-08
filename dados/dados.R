library(tidyverse)
library(lubridate)
setwd("/home/jaceguay/Documentos/Projetos/posBigData/04 - Visualização de Dados/apresentação")

#rm(list = ls())
#ls(, all.names = TRUE)

# carregar csv
dados <- read.csv("dados.csv")
dados$mes <- as.factor(dados$mes)
dados$data <- ymd(dados$data)
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
View(agregado_mes)
write.csv(agregado_mes, file="agregado_mes.csv")

## Agrupar por esquina com tipo de ocorrência, horário
# substituír colisões para um único típo
dados$tipo <- as.character(dados$tipo)
dados$tipo <-
      case_when(
        grepl("colisão", dados$tipo) == TRUE ~ "colisão",
        grepl("choque", dados$tipo) == TRUE ~ "choque",
        TRUE ~ dados$tipo
      )
#dados$tipo <- as.factor(dados$tipo)
unique(dados$tipo)

# número de ocorrências por tipo na intersecao
agregado_intersecao.tipocorr <- dados %>%
    group_by(intersecao) %>%
    count("tipo" = tipo, name = "tipocorr") %>%
    subset(intersecao != "") %>%
    pivot_wider(names_from = tipo, values_from = tipocorr)

# agrupar horários em faixas
dados$hora_inteira <- as.numeric(substr(dados$hora, 1, 2))
dados$horafx <-
  cut(dados$hora_inteira, breaks = c(5, 9, 11, 14, 17, 20, 23),
      labels = c("5-9", "9-11", "11-14", "14-17", "17-20", "20-23"),
      include.lowest = TRUE)

# número de ocorrências por faixa horária na intersecao
agregado_intersecao.horario <- dados %>%
    group_by(intersecao) %>%
    count("horafx" = horafx, name = "horafxnum") %>%
    subset(intersecao != "") %>%
    pivot_wider(names_from = horafx, values_from = horafxnum)

# localização espacial intersecoes
agregado_intersecao.latlng <- dados %>%
    select(, c(intersecao, intersecaolongx, intersecaolaty)) %>%
    group_by(intersecao) %>%
    subset(intersecao != "") %>%
    distinct()

# tipo de veículo
dados2 <- read.csv("dbexpandido.csv")
View(dados2)
unique(dados2$tipoAutomo)
dados2$tipoAuto2 <-
  case_when(
    dados2$tipoAutomo == "Automóvel" ~ "veículo leve",
    dados2$tipoAutomo == "Caminhonete" ~ "veículo leve",
    dados2$tipoAutomo == "Camioneta" ~ "veículo leve",
    dados2$tipoAutomo == "Automóvel,Camioneta" ~ "veículo leve",
    dados2$tipoAutomo == "Utilitário" ~ "veículo leve",
    dados2$tipoAutomo == "Utilitário" ~ "veículo leve",
    dados2$tipoAutomo == "Ônibus" ~ "transp.coletivo",
    dados2$tipoAutomo == "Micro-ônibus" ~ "transp.coletivo",
    dados2$tipoAutomo == "Motoneta" ~ "motocicleta",
    dados2$tipoAutomo == "Motocicleta" ~ "motocicleta",
    TRUE ~ "veículo pesado"
  )
unique(dados2$tipoAuto2)
agregado_intersecao.tipoveic <- dados2 %>%
    group_by(intersecao) %>%
    count("tipoAuto2" = tipoAuto2, name = "tipoAuto2num") %>%
    subset(intersecao != "") %>%
    pivot_wider(names_from = tipoAuto2, values_from = tipoAuto2num)

# total horário e tipo de ocorrência por intersecao
View(agregado_intersecao.tipocorr)
View(agregado_intersecao.horario)
View(agregado_intersecao.tipoveic)
View(agregado_intersecao.latlng)

agregado_intersecao <- left_join(agregado_intersecao.latlng, agregado_intersecao.tipocorr, by = "intersecao")
agregado_intersecao <- left_join(agregado_intersecao, agregado_intersecao.horario, by = "intersecao")
agregado_intersecao <- left_join(agregado_intersecao, agregado_intersecao.tipoveic, by = "intersecao")

View(agregado_intersecao)
write.csv(agregado_intersecao, file="agregado_intersecao.csv")

## janeiro total ocorrências
agregado_mes[1:1, 1:2]

## Abril, soma dias da semana
abril_dias_semana <- dados %>%
    count("dia" = diaSemana, name = "total")
View(abril_dias_semana)
write.csv(abril_dias_semana, file="abril_dias_semana.csv")

## Abril, soma horas dia
abril_horario <- dados %>%
    count("hora" = hora_inteira, name = "total")
head(abril_horario)
View(abril_horario)
write.csv(abril_horario, file="abril_horario.csv")

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
View(top10.vias)
write.csv(top10.vias, file="top10.vias.csv")

# Top 20 vias e horário
top20 <- dados %>%
  count("cruzamento" = intersecao, name = "total") %>%
  arrange(desc(total)) %>%
  subset(cruzamento != "") %>%
  head(20)
View(top20)
write.csv(top20, file="top20.csv")

top10 <- dados %>%
    count("cruzamento" = intersecao, "hora" = hora_inteira, name = "total") %>%
    arrange(desc(total)) %>%
    subset(cruzamento != "") %>%
    group_by(cruzamento) %>%
    filter(cruzamento %in% top10.vias$cruzamento)

View(top10)
str(top10)

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

# Acumulativo data

janeiro <- subset(agregMesDia, agregMesDia$mes == 1)
janeiro$data <- ymd(paste('2019', janeiro$mes, janeiro$dia, sep = '-'))
janeiro$acum <- cumsum(janeiro$total)
janeiro$diasemana <-
  wday(ymd(paste('2019', janeiro$mes, janeiro$dia, sep = '-')),
       label = TRUE,
       locale = Sys.getlocale("LC_TIME"))
View(janeiro)

fevereiro <- subset(agregMesDia, agregMesDia$mes == 2)
fevereiro$data <- ymd(paste('2019', fevereiro$mes, fevereiro$dia, sep = '-'))
fevereiro$acum <- cumsum(fevereiro$total)
fevereiro$diasemana <-
  wday(ymd(paste(
    '2019', fevereiro$mes, fevereiro$dia, sep = '-'
  )),
  label = TRUE,
  locale = Sys.getlocale("LC_TIME"))

marco <- subset(agregMesDia, agregMesDia$mes == 3)
marco$data <- ymd(paste('2019', marco$mes, marco$dia, sep = '-'))
marco$acum <- cumsum(marco$total)
marco$diasemana <-
  wday(ymd(paste('2019', marco$mes, marco$dia, sep = '-')),
       label = TRUE,
       locale = Sys.getlocale("LC_TIME"))

abril <- subset(agregMesDia, agregMesDia$mes == 4)
abril$data <- ymd(paste('2019', abril$mes, abril$dia, sep = '-'))
abril$acum <- cumsum(abril$total)
abril$diasemana <-
  wday(ymd(paste('2019', abril$mes, abril$dia, sep = '-')),
       label = TRUE,
       locale = Sys.getlocale("LC_TIME"))

db_temporal <- rbind(janeiro,fevereiro,abril,marco)
View(db_temporal)
write.csv(db_temporal, file="db_temporal.csv")

# Análise
View(dados2)

# Mapa