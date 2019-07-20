pacman::p_load("tm","rvest","dplyr","XML","RCurl","quanteda")

url <- paste0("https://www.dailykos.com/user/main/history")
webpage <- read_html(url)
x <- webpage %>% html_nodes("td a") %>% html_attr("href")
x <- x[!grepl("user",x)]
x <- x[-1]

all_dk_texts <- c()

for (links in x) {
  dk_url <- paste0("https://www.dailykos.com",links)
  dk_html <- read_html(dk_url)
  dk_text <- dk_html %>% html_nodes("div p")
  dk_text <- dk_text %>% html_text()
  dk_text <- paste0(dk_text, collapse = " ")
  all_dk_texts <- c(all_dk_texts, dk_text)
} 

dk_tmp_title <- ("https://www.dailykos.com/user/main/history")
dk__title_html <- read_html(dk_tmp_title)
dk_title <- dk__title_html %>% html_nodes("td a")
dk_title <- dk_title[!grepl("author", dk_title)]
dk_title <- dk_title[-1]
dk_title <- sub(".*/-", "", dk_title)
dk_title <- gsub('.{4}$', '', dk_title)


all_dk <- c(dk_title, all_dk_texts)
all_dk <- data.frame(title = dk_title, text = all_dk_texts)

View(all_dk)
saveRDS(dk_text, "dk_final.rds")


dk_text <- readRDS("dk_final.rds")
dk_text$bias <- "Liberal"
dk_text$blog <- "Daily Kos"
dk_text$month <- "November"
