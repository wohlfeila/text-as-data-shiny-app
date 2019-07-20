pacman::p_load("tm","rvest","dplyr","XML","RCurl","quanteda","dendextend","colorspace")

scrape_mm <- function(month, year) {
  url <- paste0("http://michellemalkin.com/", year, "/", month, "/")
  webpage <- read_html(url)
  x <- webpage %>% html_nodes("h2 a") %>% html_attr("href")
  
  all_mm_texts <- c()
  all_mm_titles <- c()
  for (links in x) {
    mm_html <- read_html(links)
    mm_text <- mm_html %>% html_nodes("div p")
    mm_text <- mm_text[!grepl("style", mm_text)]
    mm_text <- mm_text[!grepl("a href", mm_text)]
    mm_text <- mm_text[-1]
    mm_text <- mm_text[1:(length(mm_text)-6)]
    mm_text <- mm_text %>% html_text()
    mm_text <- paste0(mm_text, collapse = " ")
    all_mm_texts <- c(all_mm_texts, mm_text)
    
    tmp_title <- mm_html %>% html_nodes("h2 a") %>% html_text()
    all_mm_titles <- c(all_mm_titles, tmp_title[1])
  }
  return(data.frame(title = all_mm_titles, text = all_mm_texts))
}

mons <- 1
mm_texts <- lapply(mons, scrape_mm, year = 2018)
all_mm_texts_df <- data.table::rbindlist(mm_texts)
mm_unique1 <- unique(all_mm_texts_df)
mm_unique1$bias <- "Conservative"
mm_unique1$blog <- "Michelle Malkin"
mm_unique1$month <- "January"

mons <- 2
mm_texts <- lapply(mons, scrape_mm, year = 2018)
all_mm_texts_df <- data.table::rbindlist(mm_texts)
mm_unique2 <- unique(all_mm_texts_df)
mm_unique2$bias <- "Conservative"
mm_unique2$blog <- "Michelle Malkin"
mm_unique2$month <- "February"

mons <- 3
mm_texts <- lapply(mons, scrape_mm, year = 2018)
all_mm_texts_df <- data.table::rbindlist(mm_texts)
mm_unique3 <- unique(all_mm_texts_df)
mm_unique3$bias <- "Conservative"
mm_unique3$blog <- "Michelle Malkin"
mm_unique3$month <- "March"

mons <- 4
mm_texts <- lapply(mons, scrape_mm, year = 2018)
all_mm_texts_df <- data.table::rbindlist(mm_texts)
mm_unique4 <- unique(all_mm_texts_df)
mm_unique4$bias <- "Conservative"
mm_unique4$blog <- "Michelle Malkin"
mm_unique4$month <- "April"

mons <- 5
mm_texts <- lapply(mons, scrape_mm, year = 2018)
all_mm_texts_df <- data.table::rbindlist(mm_texts)
mm_unique5 <- unique(all_mm_texts_df)
mm_unique5$bias <- "Conservative"
mm_unique5$blog <- "Michelle Malkin"
mm_unique5$month <- "May"

mons <- 6
mm_texts <- lapply(mons, scrape_mm, year = 2018)
all_mm_texts_df <- data.table::rbindlist(mm_texts)
mm_unique6 <- unique(all_mm_texts_df)
mm_unique6$bias <- "Conservative"
mm_unique6$blog <- "Michelle Malkin"
mm_unique6$month <- "June"

mons <- 7
mm_texts <- lapply(mons, scrape_mm, year = 2018)
all_mm_texts_df <- data.table::rbindlist(mm_texts)
mm_unique7 <- unique(all_mm_texts_df)
mm_unique7$bias <- "Conservative"
mm_unique7$blog <- "Michelle Malkin"
mm_unique7$month <- "July"

mons <- 8
mm_texts <- lapply(mons, scrape_mm, year = 2018)
all_mm_texts_df <- data.table::rbindlist(mm_texts)
mm_unique8 <- unique(all_mm_texts_df)
mm_unique8$bias <- "Conservative"
mm_unique8$blog <- "Michelle Malkin"
mm_unique8$month <- "August"

mons <- 9
mm_texts <- lapply(mons, scrape_mm, year = 2018)
all_mm_texts_df <- data.table::rbindlist(mm_texts)
mm_unique9 <- unique(all_mm_texts_df)
mm_unique9$bias <- "Conservative"
mm_unique9$blog <- "Michelle Malkin"
mm_unique9$month <- "September"

mons <- 10
mm_texts <- lapply(mons, scrape_mm, year = 2018)
all_mm_texts_df <- data.table::rbindlist(mm_texts)
mm_unique10 <- unique(all_mm_texts_df)
mm_unique10$bias <- "Conservative"
mm_unique10$blog <- "Michelle Malkin"
mm_unique10$month <- "October"

mons <- 11
mm_texts <- lapply(mons, scrape_mm, year = 2018)
all_mm_texts_df <- data.table::rbindlist(mm_texts)
mm_unique11 <- unique(all_mm_texts_df)
mm_unique11$bias <- "Conservative"
mm_unique11$blog <- "Michelle Malkin"
mm_unique11$month <- "November"


mm_final <- bind_rows(mm_unique1,mm_unique2,
                      mm_unique3,mm_unique4,
                      mm_unique5,mm_unique6,
                      mm_unique7,mm_unique8,
                      mm_unique9,mm_unique10,mm_unique11)

chr_ha<-apply(mm_final,2,nchar)[,2]
View(chr_ha)

mm_final <- mm_final[!duplicated(mm_final$text), ]

mm_final <- mm_final[-c(54,2,26,12)]

View(mm_final)

saveRDS(mm_final, file = "mm_final.rds")

corpus <- corpus(mm_final)

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
