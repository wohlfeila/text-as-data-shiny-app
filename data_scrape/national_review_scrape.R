pacman::p_load("tm","rvest","dplyr","XML","RCurl","quanteda","dendextend","colorspace")

#NATIONAL REVIEW
scrape_nationalreview <- function(month, year) {
  url <- paste0("https://www.nationalreview.com/", year, "/", month, "/")
  webpage <- read_html(url)
  x <- webpage %>% html_nodes("h4 a") %>% html_attr("href")
  
  all_national_texts <- c()
  all_national_titles <- c()
  for (link in x) {
    national_html <- read_html(link)
    national_text <- national_html %>% html_nodes("p") 
    national_text <- national_text[!grepl("p\\ class|National\\ Review", national_text)]
    national_text <- national_text %>% html_text()
    national_text <- paste0(national_text, collapse = " ")
    all_national_texts <- c(all_national_texts, national_text)
    
    tmp_title <- national_html %>% html_node("div h1") %>% html_text()
    all_national_titles <- c(all_national_titles, tmp_title)
  }
  return(data.frame(title = all_national_titles, text = all_national_texts))
}

mons <- 1
all_national_texts <- lapply(mons, scrape_nationalreview, year = 2018)
all_national_texts <- data.table::rbindlist(all_national_texts)
national_unique1<-unique(all_national_texts) 
national_unique1$bias <- "Conservative"
national_unique1$blog <- "National Review"
national_unique1$month <- "Janruary"

mons <- 2
all_national_texts <- lapply(mons, scrape_nationalreview, year = 2018)
all_national_texts <- data.table::rbindlist(all_national_texts)
national_unique2<-unique(all_national_texts) 
national_unique2$bias <- "Conservative"
national_unique2$blog <- "National Review"
national_unique2$month <- "Fedruary"

mons <- 3
all_national_texts <- lapply(mons, scrape_nationalreview, year = 2018)
all_national_texts <- data.table::rbindlist(all_national_texts)
national_unique3<-unique(all_national_texts) 
national_unique3$bias <- "Conservative"
national_unique3$blog <- "National Review"
national_unique3$month <- "March"

mons <- 4
all_national_texts <- lapply(mons, scrape_nationalreview, year = 2018)
all_national_texts <- data.table::rbindlist(all_national_texts)
national_unique4<-unique(all_national_texts) 
national_unique4$bias <- "Conservative"
national_unique4$blog <- "National Review"
national_unique4$month <- "April"

mons <- 5
all_national_texts <- lapply(mons, scrape_nationalreview, year = 2018)
all_national_texts <- data.table::rbindlist(all_national_texts)
national_unique5<-unique(all_national_texts) 
national_unique5$bias <- "Conservative"
national_unique5$blog <- "National Review"
national_unique5$month <- "May"

mons <- 6
all_national_texts <- lapply(mons, scrape_nationalreview, year = 2018)
all_national_texts <- data.table::rbindlist(all_national_texts)
national_unique6<-unique(all_national_texts) 
national_unique6$bias <- "Conservative"
national_unique6$blog <- "National Review"
national_unique6$month <- "June"

mons <- 7
all_national_texts <- lapply(mons, scrape_nationalreview, year = 2018)
all_national_texts <- data.table::rbindlist(all_national_texts)
national_unique7<-unique(all_national_texts) 
national_unique7$bias <- "Conservative"
national_unique7$blog <- "National Review"
national_unique7$month <- "July"

mons <- 8
all_national_texts <- lapply(mons, scrape_nationalreview, year = 2018)
all_national_texts <- data.table::rbindlist(all_national_texts)
national_unique8<-unique(all_national_texts) 
national_unique8$bias <- "Conservative"
national_unique8$blog <- "National Review"
national_unique8$month <- "August"

mons <- 9
all_national_texts <- lapply(mons, scrape_nationalreview, year = 2018)
all_national_texts <- data.table::rbindlist(all_national_texts)
national_unique9<-unique(all_national_texts) 
national_unique9$bias <- "Conservative"
national_unique9$blog <- "National Review"
national_unique9$month <- "September"

mons <- 10
all_national_texts <- lapply(mons, scrape_nationalreview, year = 2018)
all_national_texts <- data.table::rbindlist(all_national_texts)
national_unique10<-unique(all_national_texts) 
national_unique10$bias <- "Conservative"
national_unique10$blog <- "National Review"
national_unique10$month <- "October"


nr_final <- bind_rows(national_unique1,national_unique2,
                      national_unique3,national_unique4,
                      national_unique5,national_unique6,
                      national_unique7,national_unique8,
                      national_unique9,national_unique10)


chr_nr<-apply(national_unique,2,nchar)[,2]
View(chr_nr)

national_unique[70,]

national_unique<-national_unique[-c(70)]

View(national_unique)

national_unique$title[2]