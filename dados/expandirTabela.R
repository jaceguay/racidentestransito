# União, Duarte
dados <- read.csv("dados.csv")
{
dbexpandido <- dados[1, ]
j <- NROW(dados)
i <- 1
temp1 <- Sys.time()
for (i in 1:j) {
  linhanova <- dados[i, ]
  x <- linhanova$tipoenvolv
  a <- 1 + str_count(x, pattern = ",")
  if (a == 1) {
    print("linha simples: ")
    print(i)
    print("k = 1")
    dbexpandido <- rbind(dbexpandido,
                         data.frame(linhanova))
  }
  if (a == 2) { 
    k = 2
    num = 1 + str_count(linhanova$tipoenvolv, ",")
    x <- matrix(data=NA, nrow = 1, ncol = k, byrow = TRUE)
    x <- str_split(dados[i,]$idade, ",", n = num , simplify = TRUE)
    x
    x <- data.frame(x)
    num = 1 + str_count(linhanova$tipoenvolv, ",")
    y <- matrix(data=NA, nrow = 1, ncol = k, byrow = TRUE)
    y <- str_split(dados[i,]$genero, ",", n = num , simplify = TRUE)
    y
    y <- data.frame(y)
    num = 1 + str_count(linhanova$tipoenvolv, ",")
    z <- matrix(data=NA, nrow = 1, ncol = k, byrow = TRUE)
    z <- str_split(dados[i,]$tipoenvolv, ",", n = num , simplify = TRUE)
    z
    z <- data.frame(z)
    num = 1 + str_count(linhanova$tipoenvolv, ",")
    w <- matrix(data=NA, nrow = 1, ncol = k, byrow = TRUE)
    w <- str_split(dados[i,]$tipoAutomo, ",", n = num , simplify = TRUE)
    w
    w <- data.frame(w)
    linhanova$idade <- x[, 1]
    linhanova$genero <- y[, 1]
    linhanova$tipoenvolv <- z[, 1]
    linhanova$tipoAutomo <- w[, 1]
    dbexpandido <- rbind(dbexpandido,
                         data.frame(linhanova))
    linhanova$idade <- x[, 2]
    linhanova$genero <- y[, 2]
    linhanova$tipoenvolv <- z[, 2]
    linhanova$tipoAutomo <- w[, 2]
    dbexpandido <- rbind(dbexpandido,
                         data.frame(linhanova))
    print("linhas adicionadas: 2 ")
  }
  if (a == 3) {
    k <- 3
    num <- 1 + str_count(linhanova$tipoenvolv, ",")
    x <- matrix(data=NA, nrow = 1, ncol = k, byrow = TRUE)
    x <- str_split(dados[i,]$idade, ",", n = num , simplify = TRUE)
    x
    x <- data.frame(x)
    num <- 1 + str_count(linhanova$tipoenvolv, ",")
    y <- matrix(data=NA, nrow = 1, ncol = k, byrow = TRUE)
    y <- str_split(dados[i,]$genero, ",", n = num , simplify = TRUE)
    y
    y <- data.frame(y)
    num = 1 + str_count(linhanova$tipoenvolv, ",")
    z <- matrix(data=NA, nrow = 1, ncol = k, byrow = TRUE)
    z <- str_split(dados[i,]$tipoenvolv, ",", n = num , simplify = TRUE)
    z
    z <- data.frame(z)
    num = 1 + str_count(linhanova$tipoenvolv, ",")
    w <- matrix(data=NA, nrow = 1, ncol = k, byrow = TRUE)
    w <- str_split(dados[i,]$tipoAutomo, ",", n = num , simplify = TRUE)
    w
    w <- data.frame(w)
    linhanova$idade <- x[, 1]
    linhanova$genero <- y[, 1]
    linhanova$tipoenvolv <- z[, 1]
    linhanova$tipoAutomo <- w[, 1]
    dbexpandido <- rbind(dbexpandido,
                         data.frame(linhanova))
    linhanova$idade <- x[, 2]
    linhanova$genero <- y[, 2]
    linhanova$tipoenvolv <- z[, 2]
    linhanova$tipoAutomo <- w[, 2]
    dbexpandido <- rbind(dbexpandido,
                         data.frame(linhanova))
    linhanova$idade <- x[, 3]
    linhanova$genero <- y[, 3]
    linhanova$tipoenvolv <- z[, 3]
    linhanova$tipoAutomo <- w[, 3]
    dbexpandido <- rbind(dbexpandido,
                         data.frame(linhanova))
    print("linhas adicionadas: 3")
  }
  if (a == 4) {
    k <- 4
    num <- 1 + str_count(linhanova$tipoenvolv, ",")
    x <- matrix(data=NA, nrow = 1, ncol = k, byrow = TRUE)
    x <- str_split(dados[i,]$idade, ",", n = num , simplify = TRUE)
    x
    x <- data.frame(x)
    num <- 1 + str_count(linhanova$tipoenvolv, ",")
    y <- matrix(data=NA, nrow = 1, ncol = k, byrow = TRUE)
    y <- str_split(dados[i,]$genero, ",", n = num , simplify = TRUE)
    y
    y <- data.frame(y)
    num <- 1 + str_count(linhanova$tipoenvolv, ",")
    z <- matrix(data=NA, nrow = 1, ncol = k, byrow = TRUE)
    z <- str_split(dados[i,]$tipoenvolv, ",", n = num , simplify = TRUE)
    z
    z <- data.frame(z)
    num <- 1 + str_count(linhanova$tipoenvolv, ",")
    w <- matrix(data=NA, nrow = 1, ncol = k, byrow = TRUE)
    w <- str_split(dados[i,]$tipoAutomo, ",", n = num , simplify = TRUE)
    w
    w <- data.frame(w)
    linhanova$idade <- x[, 1]
    linhanova$genero <- y[, 1]
    linhanova$tipoenvolv <- z[, 1]
    linhanova$tipoAutomo <- w[, 1]
    dbexpandido <- rbind(dbexpandido,
                         data.frame(linhanova))
    linhanova$idade <- x[, 2]
    linhanova$genero <- y[, 2]
    linhanova$tipoenvolv <- z[, 2]
    linhanova$tipoAutomo <- w[, 2]
    dbexpandido <- rbind(dbexpandido,
                         data.frame(linhanova))                   
    linhanova$idade <- x[, 3]
    linhanova$genero <- y[, 3]
    linhanova$tipoenvolv <- z[, 3]
    linhanova$tipoAutomo <- w[, 3]
    dbexpandido <- rbind(dbexpandido,
                         data.frame(linhanova))
    linhanova$idade <- x[, 4]
    linhanova$genero <- y[, 4]
    linhanova$tipoenvolv <- z[, 4]
    linhanova$tipoAutomo <- w[, 4]
    dbexpandido <- rbind(dbexpandido,
                         data.frame(linhanova))
    print("linhas adicionadas: 4")
  }
  f <- c("bd :", i, "bdexpandido", NROW(dbexpandido))
  print(f)
}

### apagando linha inicial
dbexpandido <- dbexpandido[-1, ]

head(dbexpandido)
View(dbexpandido)
write.csv(dbexpandido, file="dbexpandido.csv")