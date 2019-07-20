pacman::p_load("tm","rvest","dplyr","XML","RCurl","quanteda","dendextend","colorspace")



  url <- paste0("https://hotair.com/archive/")
  webpage <- read_html(url)
  x <- webpage %>% html_nodes("h2 a") %>% html_attr("href")
  
  all_ha_texts <- c()
  all_ha_titles <- c()
  for (links in x) {
    ha_html <- read_html(links)
    ha_text <- ha_html %>% html_nodes("div p")
    ha_text <- ha_text[-1]
    ha_text <- ha_text[!grepl("class | </p>", ha_text)]
    ha_text <- ha_text %>% html_text()
    ha_text <- paste0(ha_text, collapse = " ")
    all_ha_texts <- c(all_ha_texts, ha_text)
    
    tmp_title <- ha_html %>% html_nodes("div h1") %>% html_text()
    all_ha_titles <- c(all_ha_titles, tmp_title)
  }
  

all_ha_texts<-data.frame("title" = all_ha_titles, "text" = all_ha_texts, stringsAsFactors = FALSE)

ha_unique1<- unique(all_ha_texts)
ha_unique1$bias <- "Conservative"
ha_unique1$blog <- "Hot Air"
ha_unique1$month <- "October"
names(ha_unique1) <- c("title", "text", "bias", "blog","month")

ha_unique1 <-data.frame(ha_unique1, stringsAsFactors = FALSE)

class(ha_unique1$text)

chr_ha<-apply(ha_unique1,2,nchar)[,2]
View(ha_unique1)

ha_unique1 <- ha_unique1[!duplicated(ha_unique1$text), ]

saveRDS(ha_unique1, file = "ha_final.rds")


corpus <- corpus(ha_unique1)

extra_words <- c("pic.twitter.com","oct","sept","aug","Mother", "Jones","Factcheck.org", 
                 "National", "Review" , "Breitbart","Crooks", "Liars" , "Politico",
                 't.co','October','https',"monday","tuesday","wednesday","thursday","friday",
                 "saturday","sunday","2018","19","24","27","29","30", "J","20","11","17",
                 "6","13","25","31","21","3","28","12","26","22","1","2","nov","u.","@","16","t")


blog_dfm <- dfm(corpus,
                remove = c(stopwords("english"),extra_words),
                stem = TRUE,
                remove_punct = TRUE)

topfeatures(blog_dfm, 500)

