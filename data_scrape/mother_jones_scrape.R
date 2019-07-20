pacman::p_load("tm","rvest","dplyr","XML","RCurl","quanteda","dendextend","colorspace")

scrape_mjones <- function(month, year) {
  url <- paste0("https://www.motherjones.com/politics/", year, "/", month, "/")
  webpage <- read_html(url)
  x <- webpage %>% html_nodes("h3 a") %>% html_attr("href")
  
  all_jones_texts <- c()
  all_jones_titles <- c()
  for (links in x) {
    jones_html <- read_html(links)
    jones_text <- jones_html %>% html_nodes("article p")
    jones_text <- jones_text[!grepl("p\\ class|iframe", jones_text)]
    jones_text <- jones_text %>% html_text()
    jones_text <- paste0(jones_text, collapse = " ")
    all_jones_texts <- c(all_jones_texts, jones_text)
    
    tmp_title <- jones_html %>% html_nodes("header h1") %>% html_text()
    all_jones_titles <- c(all_jones_titles, tmp_title)
  }
  return(data.frame(title = all_jones_titles, text = all_jones_texts))
}

mons <- 1
mj_texts <- lapply(mons, scrape_mjones, year = 2018)
all_jones_texts_df <- data.table::rbindlist(mj_texts)
mother_jones_unique1 <- unique(all_jones_texts_df)
mother_jones_unique1$bias <- "Liberal"
mother_jones_unique1$blog <- "Mother Jones"
mother_jones_unique1$month <- "January"

mons <- 2
mj_texts <- lapply(mons, scrape_mjones, year = 2018)
all_jones_texts_df <- data.table::rbindlist(mj_texts)
mother_jones_unique2 <- unique(all_jones_texts_df)
mother_jones_unique2$bias <- "Liberal"
mother_jones_unique2$blog <- "Mother Jones"
mother_jones_unique2$month <- "February"

mons <- 3
mj_texts <- lapply(mons, scrape_mjones, year = 2018)
all_jones_texts_df <- data.table::rbindlist(mj_texts)
mother_jones_unique3 <- unique(all_jones_texts_df)
mother_jones_unique3$bias <- "Liberal"
mother_jones_unique3$blog <- "Mother Jones"
mother_jones_unique3$month <- "March"

mons <- 4
mj_texts <- lapply(mons, scrape_mjones, year = 2018)
all_jones_texts_df <- data.table::rbindlist(mj_texts)
mother_jones_unique4 <- unique(all_jones_texts_df)
mother_jones_unique4$bias <- "Liberal"
mother_jones_unique4$blog <- "Mother Jones"
mother_jones_unique4$month <- "April"

mons <- 5
mj_texts <- lapply(mons, scrape_mjones, year = 2018)
all_jones_texts_df <- data.table::rbindlist(mj_texts)
mother_jones_unique5 <- unique(all_jones_texts_df)
mother_jones_unique5$bias <- "Liberal"
mother_jones_unique5$blog <- "Mother Jones"
mother_jones_unique5$month <- "May"

mons <- 6
mj_texts <- lapply(mons, scrape_mjones, year = 2018)
all_jones_texts_df <- data.table::rbindlist(mj_texts)
mother_jones_unique6 <- unique(all_jones_texts_df)
mother_jones_unique6$bias <- "Liberal"
mother_jones_unique6$blog <- "Mother Jones"
mother_jones_unique6$month <- "June"

mons <- 7
mj_texts <- lapply(mons, scrape_mjones, year = 2018)
all_jones_texts_df <- data.table::rbindlist(mj_texts)
mother_jones_unique7 <- unique(all_jones_texts_df)
mother_jones_unique7$bias <- "Liberal"
mother_jones_unique7$blog <- "Mother Jones"
mother_jones_unique7$month <- "July"

mons <- 8
mj_texts <- lapply(mons, scrape_mjones, year = 2018)
all_jones_texts_df <- data.table::rbindlist(mj_texts)
mother_jones_unique8 <- unique(all_jones_texts_df)
mother_jones_unique8$bias <- "Liberal"
mother_jones_unique8$blog <- "Mother Jones"
mother_jones_unique8$month <- "August"

mons <- 9
mj_texts <- lapply(mons, scrape_mjones, year = 2018)
all_jones_texts_df <- data.table::rbindlist(mj_texts)
mother_jones_unique9 <- unique(all_jones_texts_df)
mother_jones_unique9$bias <- "Liberal"
mother_jones_unique9$blog <- "Mother Jones"
mother_jones_unique9$month <- "September"

mons <- 10
mj_texts <- lapply(mons, scrape_mjones, year = 2018)
all_jones_texts_df <- data.table::rbindlist(mj_texts)
mother_jones_unique10 <- unique(all_jones_texts_df)
mother_jones_unique10$bias <- "Liberal"
mother_jones_unique10$blog <- "Mother Jones"
mother_jones_unique10$month <- "October"

mons <- 11
mj_texts <- lapply(mons, scrape_mjones, year = 2018)
all_jones_texts_df <- data.table::rbindlist(mj_texts)
mother_jones_unique11 <- unique(all_jones_texts_df)
mother_jones_unique11$bias <- "Liberal"
mother_jones_unique11$blog <- "Mother Jones"
mother_jones_unique11$month <- "November"


mj_final <- bind_rows(mother_jones_unique1,mother_jones_unique2,
                      mother_jones_unique3,mother_jones_unique4,
                      mother_jones_unique5,mother_jones_unique6,
                      mother_jones_unique7,mother_jones_unique8,
                      mother_jones_unique9,mother_jones_unique10,mother_jones_unique11)



chr_mj<-apply(mj_final,2,nchar)[,2]
View(chr_mj)
mj_final<- mj_final[-c(141,14,165),]

View(mj_final)

mj_final <- mj_final[!duplicated(mj_final$text), ]

saveRDS(mj_final, file = "mj_final.rds")

corpus <- corpus(mj_final)

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
