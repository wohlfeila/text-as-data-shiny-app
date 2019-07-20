pacman::p_load("tm","rvest","dplyr","XML","RCurl","quanteda","dendextend","colorspace")

scrape_politicalfactcheck <- function(month, year) {
  url <- paste0("https://www.factcheck.org/",year, "/",month, "/")
  webpage <- read_html(url)
  x <- webpage %>% html_nodes("h3 a") %>% html_attr("href")
  
  all_fc <- c()
  all_fc_titles <- c()
  for (links in x) {
    fc_html <- read_html(links)
    fc_text <- fc_html %>% html_nodes("div div")
    fc_text2 <- fc_text %>% html_nodes("div p")
    fc_text2 <- fc_text2[!grepl("p\\ class", fc_text2)] %>% html_text()
    fc_text3 <- fc_text %>% html_nodes("ul li")
    fc_text3 <- fc_text3[grepl("<li>", fc_text3)] %>% html_text()
    n <- length(fc_text2)
    fc_text <- c(fc_text2[-((n-2):n)], fc_text3)
    fc_text <- paste0(fc_text, collapse = " ")
    all_fc <- c(all_fc, fc_text)
    
    tmp_title <- fc_html %>% html_nodes("header h1") %>% html_text()
    all_fc_titles <- c(all_fc_titles, tmp_title)
  }
  
  return(data.frame(title = all_fc_titles, text = all_fc))
}

mons <- 1
all_fc_texts <- lapply(mons, scrape_politicalfactcheck, year = 2018)
all_fc_texts <- data.table::rbindlist(all_fc_texts)
fc_unique1<-unique(all_fc_texts)
fc_unique_text1 <- sub("Q: ","",fc_unique1$text)
fc_unique_text1 <- sub("A: ","",fc_unique_text1)
fc_unique_text1 <- sub("FactCheck.org Rating: ","",fc_unique_text1)
fc_unique1 <- data.frame("title" = fc_unique1$title, "text" = fc_unique_text1)
fc_unique1$bias <- "Moderate"
fc_unique1$blog <- "Factcheck.org"
fc_unique1$month <- "January"

mons <- 2
all_fc_texts <- lapply(mons, scrape_politicalfactcheck, year = 2018)
all_fc_texts <- data.table::rbindlist(all_fc_texts)
fc_unique2<-unique(all_fc_texts)
fc_unique_text2 <- sub("Q: ","",fc_unique2$text)
fc_unique_text2 <- sub("A: ","",fc_unique_text2)
fc_unique_text2 <- sub("FactCheck.org Rating: ","",fc_unique_text2)
fc_unique2 <- data.frame("title" = fc_unique2$title, "text" = fc_unique_text2)
fc_unique2$bias <- "Moderate"
fc_unique2$blog <- "Factcheck.org"
fc_unique2$month <- "Fedruary"

mons <- 3
all_fc_texts <- lapply(mons, scrape_politicalfactcheck, year = 2018)
all_fc_texts <- data.table::rbindlist(all_fc_texts)
fc_unique3<-unique(all_fc_texts)
fc_unique_text3 <- sub("Q: ","",fc_unique3$text)
fc_unique_text3 <- sub("A: ","",fc_unique_text3)
fc_unique_text3 <- sub("FactCheck.org Rating: ","",fc_unique_text3)
fc_unique3 <- data.frame("title" = fc_unique1$title, "text" = fc_unique_text3)
fc_unique3$bias <- "Moderate"
fc_unique3$blog <- "Factcheck.org"
fc_unique3$month <- "March"

mons <- 4
all_fc_texts <- lapply(mons, scrape_politicalfactcheck, year = 2018)
all_fc_texts <- data.table::rbindlist(all_fc_texts)
fc_unique4<-unique(all_fc_texts)
fc_unique_text4 <- sub("Q: ","",fc_unique4$text)
fc_unique_text4 <- sub("A: ","",fc_unique_text4)
fc_unique_text4 <- sub("FactCheck.org Rating: ","",fc_unique_text4)
fc_unique4 <- data.frame("title" = fc_unique4$title, "text" = fc_unique_text4)
fc_unique4$bias <- "Moderate"
fc_unique4$blog <- "Factcheck.org"
fc_unique4$month <- "April"

mons <- 5
all_fc_texts <- lapply(mons, scrape_politicalfactcheck, year = 2018)
all_fc_texts <- data.table::rbindlist(all_fc_texts)
fc_unique5<-unique(all_fc_texts)
fc_unique_text5 <- sub("Q: ","",fc_unique5$text)
fc_unique_text5 <- sub("A: ","",fc_unique_text5)
fc_unique_text5 <- sub("FactCheck.org Rating: ","",fc_unique_text5)
fc_unique5 <- data.frame("title" = fc_unique5$title, "text" = fc_unique_text5)
fc_unique5$bias <- "Moderate"
fc_unique5$blog <- "Factcheck.org"
fc_unique5$month <- "May"

mons <- 6
all_fc_texts <- lapply(mons, scrape_politicalfactcheck, year = 2018)
all_fc_texts <- data.table::rbindlist(all_fc_texts)
fc_unique6<-unique(all_fc_texts)
fc_unique_text6 <- sub("Q: ","",fc_unique6$text)
fc_unique_text6 <- sub("A: ","",fc_unique_text6)
fc_unique_text6 <- sub("FactCheck.org Rating: ","",fc_unique_text6)
fc_unique6 <- data.frame("title" = fc_unique6$title, "text" = fc_unique_text6)
fc_unique6$bias <- "Moderate"
fc_unique6$blog <- "Factcheck.org"
fc_unique6$month <- "June"

mons <- 7
all_fc_texts <- lapply(mons, scrape_politicalfactcheck, year = 2018)
all_fc_texts <- data.table::rbindlist(all_fc_texts)
fc_unique7<-unique(all_fc_texts)
fc_unique_text7 <- sub("Q: ","",fc_unique7$text)
fc_unique_text7 <- sub("A: ","",fc_unique_text7)
fc_unique_text7 <- sub("FactCheck.org Rating: ","",fc_unique_text7)
fc_unique7 <- data.frame("title" = fc_unique7$title, "text" = fc_unique_text7)
fc_unique7$bias <- "Moderate"
fc_unique7$blog <- "Factcheck.org"
fc_unique7$month <- "July"

mons <- 8
all_fc_texts <- lapply(mons, scrape_politicalfactcheck, year = 2018)
all_fc_texts <- data.table::rbindlist(all_fc_texts)
fc_unique8<-unique(all_fc_texts)
fc_unique_text8 <- sub("Q: ","",fc_unique8$text)
fc_unique_text8 <- sub("A: ","",fc_unique_text8)
fc_unique_text8 <- sub("FactCheck.org Rating: ","",fc_unique_text8)
fc_unique8 <- data.frame("title" = fc_unique8$title, "text" = fc_unique_text8)
fc_unique8$bias <- "Moderate"
fc_unique8$blog <- "Factcheck.org"
fc_unique8$month <- "August"

mons <- 9
all_fc_texts <- lapply(mons, scrape_politicalfactcheck, year = 2018)
all_fc_texts <- data.table::rbindlist(all_fc_texts)
fc_unique9<-unique(all_fc_texts)
fc_unique_text9 <- sub("Q: ","",fc_unique9$text)
fc_unique_text9 <- sub("A: ","",fc_unique_text9)
fc_unique_text9 <- sub("FactCheck.org Rating: ","",fc_unique_text1)
fc_unique9 <- data.frame("title" = fc_unique9$title, "text" = fc_unique_text9)
fc_unique9$bias <- "Moderate"
fc_unique9$blog <- "Factcheck.org"
fc_unique9$month <- "September"

mons <- 10
all_fc_texts <- lapply(mons, scrape_politicalfactcheck, year = 2018)
all_fc_texts <- data.table::rbindlist(all_fc_texts)
fc_unique10<-unique(all_fc_texts)
fc_unique_text10 <- sub("Q: ","",fc_unique10$text)
fc_unique_text10 <- sub("A: ","",fc_unique_text10)
fc_unique_text10 <- sub("FactCheck.org Rating: ","",fc_unique_text10)
fc_unique10 <- data.frame("title" = fc_unique10$title, "text" = fc_unique_text10)
fc_unique10$bias <- "Moderate"
fc_unique10$blog <- "Factcheck.org"
fc_unique10$month <- "October"

mons <- 11
all_fc_texts <- lapply(mons, scrape_politicalfactcheck, year = 2018)
all_fc_texts <- data.table::rbindlist(all_fc_texts)
fc_unique11<-unique(all_fc_texts)
fc_unique_text11 <- sub("Q: ","",fc_unique11$text)
fc_unique_text11 <- sub("A: ","",fc_unique_text11)
fc_unique_text11 <- sub("FactCheck.org Rating: ","",fc_unique_text11)
fc_unique11 <- data.frame("title" = fc_unique11$title, "text" = fc_unique_text11)
fc_unique11$bias <- "Moderate"
fc_unique11$blog <- "Factcheck.org"
fc_unique11$month <- "Novemeber"


fc_final <- bind_rows(fc_unique1,fc_unique2,
                      fc_unique3,fc_unique4,
                      fc_unique5,fc_unique6,
                      fc_unique7,fc_unique8,
                      fc_unique9,fc_unique10,fc_unique11)

fc_final <- fc_final[!duplicated(fc_final$text), ]

chr_fc<-apply(fc_final,2,nchar)[,2]
View(chr_fc)
View(fc_final)

fc_final <- fc_final[-c(1),]

saveRDS(fc_final, file = "fc_final.rds")


corpus <- corpus(fc_final)

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
