install.packages("rvest")
library(rvest)
library(tidyverse)
library(xml2)

page <- read_html("https://www.n2yo.com/satellites/?c=52")
links <- page %>% html_nodes("a") %>% html_attr("href")

list_links <- url_absolute(links, "href")
#или links <- page %>% html_nodes("a") %>% html_attr("href")

links2 <- paste0('https://www.n2yo.com', list_links)
links3 <- links2[grepl('satellite', links2)]

#да все также, созданный урл пихаете в read_html и парсите, 
#там я видел, есть специальный блок с координатами
#по xpath его выковыриваете и всё

# для получения чисто названий
# html_text(links, trim = TRUE)
l1 <- read_html("https://www.n2yo.com/satellite/?s=25544")
d1 <- l1 %>% html_node("h1") %>% html_text("div h1")
d1
#[1] "STARLINK-1948"
d1.1 <-  l1 %>% html_node("pre") %>% html_text("pre class")
# [1] "\r\n1 46798U 20074BM  20312.75001157 -.01113198 +00000-0 -69021-2 0  9997
#\r\n2 46798 053.0487 091.2537 0001460 034.6445 339.5526 15.78837647001816\n"


#EXAMPLE------------------------------------------------------------------------

library(rvest)
top_url = "http://fccee.uvigo.es/es/profesorado.html"
page = read_html(top_url)
links = page %>% 
  html_nodes(".listado_fccee li a") %>% 
  html_attr("href")
datos <- list()
for(i in links){
  datos[[length(datos)+1]] <- i %>% 
    paste0("http://fccee.uvigo.es",.) %>%
    read_html() %>%
    html_nodes(".lista_fccee") %>% 
    html_table()
}

#fin----------------------------------------------------------------------------
datos <- list()

for (i in links3) {
datos[[length(datos)+1]] <- i %>%
read_html() %>%
html_nodes("h1") %>%
html_text("div h1")
}

 datos2 <- list()
for (i in links3) {
datos2[[length(datos2)+1]] <- i %>%
read_html() %>%
html_nodes("pre") %>%
html_text("pre class")
}

 d <- data.frame(t(sapply(dat,c))) #идиотим t -транспонирование ..
 e <- data.frame(t(sapply(dat2,c))) # кто ж знал
 f <- rbind(d,e)

 ft <- as.data.frame(t(as.matrix(f)))


