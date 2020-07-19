# codigo para artigo sobre auxilio emergencial 

#Search Twitter 

library(twitteR)
library(wordcloud)
library(SnowballC)
library(tm)
source('config_twitter_access.R')

setup_twitter_oauth(consumer_key,
                    consumer_secret_key,
                    access_token,
                    access_token_secret)

tweets <- searchTwitter("#caixatemnaofunciona",n = 1000, lang = "pt")

text <- sapply(tweets, function(x) x$getText())

corpus <- Corpus(VectorSource(text))  

dados.texto <- TermDocumentMatrix(corpus,
                                  control = list(removePunctuation = TRUE,
                                                 removeNumbers = TRUE, tolower = TRUE))


dados.matrix <- as.matrix(dados.texto)

dados.freq <- sort(rowSums(dados.matrix), decreasing = TRUE)

dados.df <- data.frame(term = names(dados.freq) , freq = dados.freq)

library(tidyverse)


wordcloud(dados.df$term, dados.df$freq,  min.freq = 5, max.words = 200,random.order = F, colors = brewer.pal(8, 'Dark2'))

dados1 <- dados.df %>% filter(dados.df$freq > 100)
