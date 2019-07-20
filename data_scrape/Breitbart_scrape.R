pacman::p_load("tm","rvest","dplyr","XML","RCurl","quanteda","dendextend","colorspace")


scrape_bb <- function(month, year, day) {
  url <- paste0("https://www.breitbart.com/politics/", year, "/", month, "/", day, "/")
  webpage <- read_html(url)
  x <- webpage %>% html_nodes("h2 a") %>% html_attr("href")
  
  all_bb_texts <- c()
  all_bb_titles <- c()
  for (links in x) {
    bb_html <- read_html(links)
    bb_text <- bb_html %>% html_nodes("div p")
    bb_text <- bb_text[1:(length(bb_text)-4)]
    bb_text <- bb_text[!grepl("class | id", bb_text)]
    bb_text <- bb_text[!grepl("a href", bb_text)]
    bb_text <- bb_text %>% html_text()
    bb_text <- paste0(bb_text, collapse = " ")
    all_bb_texts <- c(all_bb_texts, bb_text)
    
    tmp_title <- bb_html %>% html_nodes("header h1") %>% html_text()
    all_bb_titles <- c(all_bb_titles, tmp_title)
  }
  return(data.frame(title = all_bb_titles, text = all_bb_texts))
}

#gsub("\\\n\\\t\\\t\\\t.*", "", bb_text)

mons <-1
all_bb_texts <- lapply(mons, scrape_bb, year = 2018, day = 20)
all_bb_texts <- data.table::rbindlist(all_bb_texts)
bb_unique1<- unique(all_bb_texts)
bb_unique1$bias <- "Conservative"
bb_unique1$blog <- "Breitbart"
bb_unique1$month <- "Janruary"

mons <-2
all_bb_texts <- lapply(mons, scrape_bb, year = 2018, day = 20)
all_bb_texts <- data.table::rbindlist(all_bb_texts)
bb_unique2<- unique(all_bb_texts)
bb_unique2$bias <- "Conservative"
bb_unique2$blog <- "Breitbart"
bb_unique2$month <- "February"

mons <-3
all_bb_texts <- lapply(mons, scrape_bb, year = 2018, day = 20)
all_bb_texts <- data.table::rbindlist(all_bb_texts)
bb_unique3<- unique(all_bb_texts)
bb_unique3$bias <- "Conservative"
bb_unique3$blog <- "Breitbart"
bb_unique3$month <- "March"

mons <-4
all_bb_texts <- lapply(mons, scrape_bb, year = 2018, day = 20)
all_bb_texts <- data.table::rbindlist(all_bb_texts)
bb_unique4<- unique(all_bb_texts)
bb_unique4$bias <- "Conservative"
bb_unique4$blog <- "Breitbart"
bb_unique4$month <- "April"

mons <-5
all_bb_texts <- lapply(mons, scrape_bb, year = 2018, day = 20)
all_bb_texts <- data.table::rbindlist(all_bb_texts)
bb_unique5<- unique(all_bb_texts)
bb_unique5$bias <- "Conservative"
bb_unique5$blog <- "Breitbart"
bb_unique5$month <- "May"

mons <-6
all_bb_texts <- lapply(mons, scrape_bb, year = 2018, day = 20)
all_bb_texts <- data.table::rbindlist(all_bb_texts)
bb_unique6<- unique(all_bb_texts)
bb_unique6$bias <- "Conservative"
bb_unique6$blog <- "Breitbart"
bb_unique6$month <- "June"

mons <-7
all_bb_texts <- lapply(mons, scrape_bb, year = 2018, day = 20)
all_bb_texts <- data.table::rbindlist(all_bb_texts)
bb_unique7<- unique(all_bb_texts)
bb_unique7$bias <- "Conservative"
bb_unique7$blog <- "Breitbart"
bb_unique7$month <- "July"

mons <-8
all_bb_texts <- lapply(mons, scrape_bb, year = 2018, day = 20)
all_bb_texts <- data.table::rbindlist(all_bb_texts)
bb_unique8<- unique(all_bb_texts)
bb_unique8$bias <- "Conservative"
bb_unique8$blog <- "Breitbart"
bb_unique8$month <- "August"

mons <-9
all_bb_texts <- lapply(mons, scrape_bb, year = 2018, day = 20)
all_bb_texts <- data.table::rbindlist(all_bb_texts)
bb_unique9<- unique(all_bb_texts)
bb_unique9$bias <- "Conservative"
bb_unique9$blog <- "Breitbart"
bb_unique9$month <- "September"

mons <-10
all_bb_texts <- lapply(mons, scrape_bb, year = 2018, day = 20)
all_bb_texts <- data.table::rbindlist(all_bb_texts)
bb_unique10<- unique(all_bb_texts)
bb_unique10$bias <- "Conservative"
bb_unique10$blog <- "Breitbart"
bb_unique10$month <- "October"

mons <-11
all_bb_texts <- lapply(mons, scrape_bb, year = 2018, day = 2)
all_bb_texts <- data.table::rbindlist(all_bb_texts)
bb_unique11<- unique(all_bb_texts)
bb_unique11$bias <- "Conservative"
bb_unique11$blog <- "Breitbart"
bb_unique11$month <- "Novemeber"

View(bb_unique)  

bb_final <- bind_rows(bb_unique1,bb_unique2,
                      bb_unique3,bb_unique4,
                      bb_unique5,bb_unique6,
                      bb_unique7,bb_unique8,
                      bb_unique9,bb_unique10,bb_unique11)

bb_final$chr <- apply(bb_final,2,nchar)[,2]
bb_final<- bb_final[order(chr),]
bb_final <- bb_final[-c(1:53,6:7)]


chr_bb<-apply(bb_final,2,nchar)[,2]
View(chr_bb)
View(bb_final)



saveRDS(bb_final, file = "bb_final.rds")

corpus <- corpus(bb_final)

extra_words <- c("pic.twitter.com","oct","sept","aug","Mother", "Jones","Factcheck.org", 
                 "National", "Review" , "Breitbart","Crooks", "Liars" , "Politico",
                 't.co','October','https',"monday","tuesday","wednesday","thursday","friday",
                 "saturday","sunday","2018","19","24","27","29","30", "J","20","11","17",
                 "6","13","25","31","21","3","28","12","26","22","1","2","nov","u.")

blog_dfm <- dfm(corpus,
                remove = c(stopwords("english"),extra_words),
                stem = TRUE,
                remove_punct = TRUE)

topfeatures(blog_dfm, 500)

