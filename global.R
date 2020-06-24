library(shinydashboard)
library(leaflet)
library(lubridate)
library(dplyr)
library(ggplot2)

### padronizando o tema do ggplot...
seta <- grid::arrow(length = grid::unit(0.2, "cm"), type = "open")
my_theme <- function (base_size = 14,
                      base_family = "Arial") {
  theme_bw(base_size = base_size, base_family = base_family) %+replace%
    theme(
      axis.ticks = element_blank(),
      axis.line = element_line(arrow = seta),
      legend.background = element_blank(),
      legend.key = element_blank(),
      panel.background = element_blank(),
      panel.border = element_blank(),
      strip.background = element_blank(),
      plot.background = element_blank(),
      complete = TRUE
    )
}

# valores
dados <-
  read.csv(
    "https://docs.google.com/spreadsheets/d/e/2PACX-1vTukBFwIgjXG73jrvr38ePIQOLqCrD5M5b6F8Kuff2A3QOAuWjeoWDqNWkoa8Q5SStEVN0vh47RokOt/pub?gid=684987162&single=true&output=csv",
    header = TRUE,
    stringsAsFactors = FALSE
  )
dados$longX <- as.numeric(gsub(',', '.', dados$longX))
dados$latY <- as.numeric(gsub(',', '.', dados$latY))
dados$tipo <- as.factor(dados$tipo)
dados$data <- ymd(dados$data)

agregMes <- dados %>% count(mes = month(dados$data), name = 'total')

agregMesDia <- dados %>%
  count(
    mes = month(dados$data),
    dia = day(dados$data),
    name = 'total'
  )

janeiro <- subset(agregMesDia, agregMesDia$mes == 1)
janeiro$acum <- cumsum(janeiro$total)
janeiro$diasemana <-
  wday(ymd(paste('2019', janeiro$mes, janeiro$dia, sep = '-')),
       label = TRUE,
       locale = Sys.getlocale("LC_TIME"))


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

# Todos os meses
plot1 <- ggplot(NULL, aes(dia, acum)) +
  geom_line(data = janeiro, aes(color = 'Janeiro')) +
  geom_line(data = fevereiro, aes(color = 'Fevereiro')) +
  geom_line(data = marco, aes(color = 'Março')) +
  geom_line(data = abril, aes(color = 'Abril')) +
  scale_colour_manual(
    '',
    breaks = c('Janeiro', 'Fevereiro', 'Março', 'Abril'),
    values = c('orange', 'green', 'red', 'blue')
  ) +
  xlab("dia") +
  scale_y_continuous('nºocorrências') +
  labs(title = 'Conjunto de dados') +
  my_theme()
plot1

# Mês atual e anterior
plot2 <- ggplot(NULL, aes(dia, acum)) +
  geom_line(data = marco, aes(color = 'Março')) +
  geom_line(data = abril, aes(color = 'Mês atual')) +
  scale_colour_manual('',
                      breaks = c('Mês atual', 'Março'),
                      values = c('red', 'green')) +
  scale_x_continuous(name = "dias", breaks = c(1, 5, 10, 15, 20, 25, 28, 31)) +
  scale_y_continuous('nºocorrências') +
  labs(title = 'Situação atual') +
  theme(axis.text.x = element_text(angle = -90, vjust = 0.5), ) +
  my_theme()
plot2

# histograma acidentes dia

# Boxplot todos meses dia da semana
