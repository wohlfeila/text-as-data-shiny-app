pacman::p_load("tm","rvest","dplyr","XML","RCurl","quanteda","dendextend","colorspace")


scrape_cl <- function(page) {
  url <- paste0("https://crooksandliars.com/politics?page=", page)
  webpage <- read_html(url)
  x <- webpage %>% html_nodes("h2 a") %>% html_attr("href")
  x <- x[!grepl("cltv", x)]
  
  all_cl_texts <- c()
  all_cl_titles <- c()
  for (links in x) {
    cl_html <- read_html(paste0("https://crooksandliars.com/", links))
    cl_text <- cl_html %>% html_nodes("div p")
    cl_text_2 <- cl_text[-length(cl_text)]
    cl_text_2 <- cl_text_2 %>% html_text()
    cl_text_2 <- paste0(cl_text_2, collapse = " ")
    all_cl_texts <- c(all_cl_texts, cl_text_2)
    
    tmp_title <- cl_html %>% html_nodes("article header") %>% html_nodes("h2 a") %>% html_text()
    all_cl_titles <- c(all_cl_titles, tmp_title)
  }
  return(data.frame(title = all_cl_titles, text = all_cl_texts))
}

pages <- 1

all_cl_texts <- lapply(pages, scrape_cl)
all_cl_texts <- data.table::rbindlist(all_cl_texts)
cl_unique11 <- unique(all_cl_texts)
cl_unique11$bias <- "Liberal"
cl_unique11$blog <- "Crooks and Liars"
cl_unique11$month <- "November"

pages <- 2

all_cl_texts <- lapply(pages, scrape_cl)
all_cl_texts <- data.table::rbindlist(all_cl_texts)
cl_unique10 <- unique(all_cl_texts)
cl_unique10$bias <- "Liberal"
cl_unique10$blog <- "Crooks and Liars"
cl_unique10$month <- "October"


pages <- 3

all_cl_texts <- lapply(pages, scrape_cl)
all_cl_texts <- data.table::rbindlist(all_cl_texts)
cl_unique9 <- unique(all_cl_texts)
cl_unique9$bias <- "Liberal"
cl_unique9$blog <- "Crooks and Liars"
cl_unique9$month <- "September"

pages <- 4

all_cl_texts <- lapply(pages, scrape_cl)
all_cl_texts <- data.table::rbindlist(all_cl_texts)
cl_unique8 <- unique(all_cl_texts)
cl_unique8$bias <- "Liberal"
cl_unique8$blog <- "Crooks and Liars"
cl_unique8$month <- "August"

pages <- 5

all_cl_texts <- lapply(pages, scrape_cl)
all_cl_texts <- data.table::rbindlist(all_cl_texts)
cl_unique7 <- unique(all_cl_texts)
cl_unique7$bias <- "Liberal"
cl_unique7$blog <- "Crooks and Liars"
cl_unique7$month <- "July"

pages <- 6

all_cl_texts <- lapply(pages, scrape_cl)
all_cl_texts <- data.table::rbindlist(all_cl_texts)
cl_unique6 <- unique(all_cl_texts)
cl_unique6$bias <- "Liberal"
cl_unique6$blog <- "Crooks and Liars"
cl_unique6$month <- "June"

pages <- 7

all_cl_texts <- lapply(pages, scrape_cl)
all_cl_texts <- data.table::rbindlist(all_cl_texts)
cl_unique5 <- unique(all_cl_texts)
cl_unique5$bias <- "Liberal"
cl_unique5$blog <- "Crooks and Liars"
cl_unique5$month <- "May"

pages <- 8

all_cl_texts <- lapply(pages, scrape_cl)
all_cl_texts <- data.table::rbindlist(all_cl_texts)
cl_unique4 <- unique(all_cl_texts)
cl_unique4$bias <- "Liberal"
cl_unique4$blog <- "Crooks and Liars"
cl_unique4$month <- "April"

pages <- 9

all_cl_texts <- lapply(pages, scrape_cl)
all_cl_texts <- data.table::rbindlist(all_cl_texts)
cl_unique3 <- unique(all_cl_texts)
cl_unique3$bias <- "Liberal"
cl_unique3$blog <- "Crooks and Liars"
cl_unique3$month <- "March"

pages <- 10

all_cl_texts <- lapply(pages, scrape_cl)
all_cl_texts <- data.table::rbindlist(all_cl_texts)
cl_unique2 <- unique(all_cl_texts)
cl_unique2$bias <- "Liberal"
cl_unique2$blog <- "Crooks and Liars"
cl_unique2$month <- "February"

pages <- 11

all_cl_texts <- lapply(pages, scrape_cl)
all_cl_texts <- data.table::rbindlist(all_cl_texts)
cl_unique1 <- unique(all_cl_texts)
cl_unique1$bias <- "Liberal"
cl_unique1$blog <- "Crooks and Liars"
cl_unique1$month <- "January"

cl_final <- bind_rows(cl_unique1,cl_unique2,
                      cl_unique3,cl_unique4,
                      cl_unique5,cl_unique6,
                      cl_unique7,cl_unique8,
                      cl_unique9,cl_unique10,cl_unique10)

chr_bb<-apply(cl_final,2,nchar)[,2]
View(cl_final)

cl_final<- cl_final[-c(177),]

cl_final <- cl_final[!duplicated(cl_final$text), ]

saveRDS(cl_final, file = "cl_final.rds")

corpus <- corpus(cl_final)

extra_words <- c("pic.twitter.com","oct","sept","aug","Mother", "Jones","Factcheck.org", 
                 "National", "Review" , "Breitbart","Crooks", "Liars" , "Politico",
                 't.co','October','https',"monday","tuesday","wednesday","thursday","friday",
                 "saturday","sunday","2018","19","24","27","29","30", "J","20","11","17",
                 "6","13","25","31","21","3","28","12","26","22","1","2","nov","u.","@")

blog_dfm <- dfm(corpus,
                remove = c(stopwords("english"),extra_words),
                stem = TRUE,
                remove_punct = TRUE)

topfeatures(blog_dfm, 500)
