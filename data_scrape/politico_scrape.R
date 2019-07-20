pacman::p_load("tm","rvest","dplyr","XML","RCurl","quanteda","dendextend","colorspace")



scrape_politico <- function(page) {
  url <- paste0("https://www.politico.com/story/", page)   
  webpage <- read_html(url)
  x <- webpage %>% html_nodes("h3 a") %>% html_attr("href")
  x <- x[!grepl("magazine", x)]
  
  all_politico_texts <- c()
  all_politico_titles <- c()
  for (links in x) {
    politico_html <- read_html(links)
    politico_text <- politico_html %>% html_nodes("div p")
    politico_text <- politico_text[!grepl("class", politico_text)]
    politico_text_2 <- politico_text[-length(politico_text)]
    politico_text_2 <- politico_text_2 %>% html_text()
    politico_text_2 <- paste0(politico_text_2, collapse = " ")
    all_politico_texts <- c(all_politico_texts, politico_text_2)
    
    tmp_title <- politico_html %>% html_nodes("header h1") %>% html_text()
    all_politico_titles <- c(all_politico_titles, tmp_title[2])
  }
  return(data.frame(title = all_politico_titles, text = all_politico_texts))
}

page<-1

all_politico_texts <- lapply(page, scrape_politico)
all_politico_texts <- data.table::rbindlist(all_politico_texts)
p_unique11<- unique(all_politico_texts)
p_unique11$bias <- "Moderate"
p_unique11$blog <- "Politico"
p_unique11$month <- "November"
t<- p_unique11$title
t<- sub(".*\n *(.*?) *\n.*", "\\1", t)
p_unique_final11<-data.frame("title" = t, "text" = p_unique11$text, "bias" = p_unique11$bias, 
                             "blog" = p_unique11$blog, "month" = p_unique11$month)
p_unique_final11<- p_unique_final11[-c(1:25),]

page<-2

all_politico_texts <- lapply(page, scrape_politico)
all_politico_texts <- data.table::rbindlist(all_politico_texts)
p_unique10<- unique(all_politico_texts)
p_unique10$bias <- "Moderate"
p_unique10$blog <- "Politico"
p_unique10$month <- "October"
t<- p_unique10$title
t<- sub(".*\n *(.*?) *\n.*", "\\1", t)
p_unique_final10<-data.frame("title" = t, "text" = p_unique10$text, "bias" = p_unique10$bias, 
                           "blog" = p_unique10$blog, "month" = p_unique10$month)
p_unique_final10<- p_unique_final10[-c(1:25),]

page<-3

all_politico_texts <- lapply(page, scrape_politico)
all_politico_texts <- data.table::rbindlist(all_politico_texts)
p_unique9<- unique(all_politico_texts)
p_unique9$bias <- "Moderate"
p_unique9$blog <- "Politico"
p_unique9$month <- "September"
t<- p_unique9$title
t<- sub(".*\n *(.*?) *\n.*", "\\1", t)
p_unique_final9<-data.frame("title" = t, "text" = p_unique9$text, "bias" = p_unique9$bias, 
                            "blog" = p_unique9$blog, "month" = p_unique9$month)
p_unique_final9<- p_unique_final9[-c(1:25),]

page<-4

all_politico_texts <- lapply(page, scrape_politico)
all_politico_texts <- data.table::rbindlist(all_politico_texts)
p_unique8<- unique(all_politico_texts)
p_unique8$bias <- "Moderate"
p_unique8$blog <- "Politico"
p_unique8$month <- "August"
t<- p_unique8$title
t<- sub(".*\n *(.*?) *\n.*", "\\1", t)
p_unique_final8<-data.frame("title" = t, "text" = p_unique8$text, "bias" = p_unique8$bias, 
                            "blog" = p_unique8$blog, "month" = p_unique8$month)
p_unique_final8<- p_unique_final8[-c(1:25),]

page<-5

all_politico_texts <- lapply(page, scrape_politico)
all_politico_texts <- data.table::rbindlist(all_politico_texts)
p_unique7<- unique(all_politico_texts)
p_unique7$bias <- "Moderate"
p_unique7$blog <- "Politico"
p_unique7$month <- "July"
t<- p_unique7$title
t<- sub(".*\n *(.*?) *\n.*", "\\1", t)
p_unique_final7<-data.frame("title" = t, "text" = p_unique7$text, "bias" = p_unique7$bias, 
                            "blog" = p_unique7$blog, "month" = p_unique7$month)
p_unique_final7<- p_unique_final7[-c(1:25),]

page<-6

all_politico_texts <- lapply(page, scrape_politico)
all_politico_texts <- data.table::rbindlist(all_politico_texts)
p_unique6<- unique(all_politico_texts)
p_unique6$bias <- "Moderate"
p_unique6$blog <- "Politico"
p_unique6$month <- "June"
t<- p_unique6$title
t<- sub(".*\n *(.*?) *\n.*", "\\1", t)
p_unique_final6<-data.frame("title" = t, "text" = p_unique6$text, "bias" = p_unique6$bias, 
                            "blog" = p_unique6$blog, "month" = p_unique6$month)
p_unique_final6<- p_unique_final6[-c(1:25),]

page<-7

all_politico_texts <- lapply(page, scrape_politico)
all_politico_texts <- data.table::rbindlist(all_politico_texts)
p_unique5<- unique(all_politico_texts)
p_unique5$bias <- "Moderate"
p_unique5$blog <- "Politico"
p_unique5$month <- "May"
t<- p_unique5$title
t<- sub(".*\n *(.*?) *\n.*", "\\1", t)
p_unique_final5<-data.frame("title" = t, "text" = p_unique5$text, "bias" = p_unique5$bias, 
                            "blog" = p_unique5$blog, "month" = p_unique5$month)
p_unique_final5<- p_unique_final5[-c(1:25),]

page<-8

all_politico_texts <- lapply(page, scrape_politico)
all_politico_texts <- data.table::rbindlist(all_politico_texts)
p_unique4<- unique(all_politico_texts)
p_unique4$bias <- "Moderate"
p_unique4$blog <- "Politico"
p_unique4$month <- "April"
t<- p_unique4$title
t<- sub(".*\n *(.*?) *\n.*", "\\1", t)
p_unique_final4<-data.frame("title" = t, "text" = p_unique4$text, "bias" = p_unique4$bias, 
                            "blog" = p_unique4$blog, "month" = p_unique4$month)
p_unique_final4<- p_unique_final4[-c(1:25),]

page<-9

all_politico_texts <- lapply(page, scrape_politico)
all_politico_texts <- data.table::rbindlist(all_politico_texts)
p_unique3<- unique(all_politico_texts)
p_unique3$bias <- "Moderate"
p_unique3$blog <- "Politico"
p_unique3$month <- "March"
t<- p_unique3$title
t<- sub(".*\n *(.*?) *\n.*", "\\1", t)
p_unique_final3<-data.frame("title" = t, "text" = p_unique3$text, "bias" = p_unique3$bias, 
                            "blog" = p_unique3$blog, "month" = p_unique3$month)
p_unique_final3<- p_unique_final3[-c(1:25),]

page<-10

all_politico_texts <- lapply(page, scrape_politico)
all_politico_texts <- data.table::rbindlist(all_politico_texts)
p_unique2<- unique(all_politico_texts)
p_unique2$bias <- "Moderate"
p_unique2$blog <- "Politico"
p_unique2$month <- "February"
t<- p_unique2$title
t<- sub(".*\n *(.*?) *\n.*", "\\1", t)
p_unique_final2<-data.frame("title" = t, "text" = p_unique2$text, "bias" = p_unique2$bias, 
                            "blog" = p_unique2$blog, "month" = p_unique2$month)
p_unique_final2<- p_unique_final2[-c(1:25),]

page<-11

all_politico_texts <- lapply(page, scrape_politico)
all_politico_texts <- data.table::rbindlist(all_politico_texts)
p_unique1<- unique(all_politico_texts)
p_unique1$bias <- "Moderate"
p_unique1$blog <- "Politico"
p_unique1$month <- "January"
t<- p_unique1$title
t<- sub(".*\n *(.*?) *\n.*", "\\1", t)
p_unique_final1<-data.frame("title" = t, "text" = p_unique1$text, "bias" = p_unique1$bias, 
                            "blog" = p_unique1$blog, "month" = p_unique1$month)
p_unique_final1<- p_unique_final1[-c(1:25),]

p_final <- bind_rows(p_unique_final1,p_unique_final2,
                     p_unique_final3,p_unique_final4,
                     p_unique_final5,p_unique_final6,
                     p_unique_final7,p_unique_final8,
                     p_unique_final9,p_unique_final10,p_unique_final11)

chr_bb<-apply(p_final,2,nchar)[,2]
View(chr_bb)

p_final<- p_final[-c(328),]

p_final <- p_final[!duplicated(p_final$text), ]

saveRDS(p_final, file = "p_final.rds")

corpus <- corpus(p_final)

extra_words <- c("pic.twitter.com","oct","sept","aug","Mother", "Jones","Factcheck.org", 
                 "National", "Review" , "Breitbart","Crooks", "Liars" , "Politico",
                 't.co','October','https',"monday","tuesday","wednesday","thursday","friday",
                 "saturday","sunday","2018","19","24","27","29","30", "J","20","11","17",
                 "6","13","25","31","21","3","28","12","26","22","1","2","nov","u.","@","16")

blog_dfm <- dfm(corpus,
                remove = c(stopwords("english"),extra_words),
                stem = TRUE,
                remove_punct = TRUE)

topfeatures(blog_dfm, 500)
