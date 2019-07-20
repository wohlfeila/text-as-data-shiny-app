library(dplyr)
library(quanteda)

setwd("~/Documents/text/shiny_app")

mj_text <- readRDS("mj_final.rds")
fc_text <- readRDS("fc_final.rds")
bb_text <- readRDS("bb_final.rds")
cl_text <- readRDS("cl_final.rds")
p_text <- readRDS("p_final.rds")
ha_text <- readRDS("ha_final.rds")
mm_text <- readRDS("mm_final.rds")
dk_text <- readRDS("dk_final.rds")

bb_text <- bb_text[,1:5]

tmp <- bind_rows(mj_text,fc_text,bb_text,cl_text,p_text,ha_text,mm_text,dk_text)
names(tmp) <- c("doc_id", "text", "bias", "blog","month")
head(tmp)

corpus <- corpus(tmp)
summary(corpus)

##saveRDS(tmp, file = "blogdata.rds")
##saveRDS(corpus, file = "blogcorpus.rds")

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

### add 'extra_words' in all of app dfm
#get more hot air
#once data is final - re-run STM - do before next week


#Data Description code

lib = corpus_subset(corpus, bias == "Liberal")
conserv = corpus_subset(corpus, bias == "Conservative")
moder = corpus_subset(corpus, bias == "Moderate")

bb = corpus_subset(corpus, blog == "Breitbart")
cl = corpus_subset(corpus, blog == "Crooks and Liars")
fc = corpus_subset(corpus, blog == "Factcheck.org")
ha = corpus_subset(corpus, blog == "Hot Air")
mj = corpus_subset(corpus, blog == "Mother Jones")
mm = corpus_subset(corpus, blog == "Michelle Malkin")
p = corpus_subset(corpus, blog == "Politico")
d = corpus_subset(corpus, blog == "Daily Kos")

dfm(lib)
dfm(conserv)
dfm(moder)
dfm(bb)
dfm(cl)
dfm(fc)
dfm(ha)
dfm(mj)
dfm(mm)
dfm(p)
dfm(d)

p("The data for this project came from seven political blog across the political spectrum.
I split the data into liberal, conservative, and moderate blogs.  The liberal blog data came from Mother Jones, Crooks and Liars and the Daily Kos.
The conservative blog data came from Breitbart, Hot Air, and Michelle Malkin.  The moderate blog data came from Politico and Factcheck.org.
The goal was to get a similar amount of data for each political bias.  The liberal blogs consist of 424 documents with 20,738 features.
The conservative blogs consist of 416 documents and 16,012 features.  The moderate blogs consist of 300 documents and 16,796 features.
For each idology, the data was scraped between January 2018 and November 2018, just prior to the election.
For each blog, stop words and puncuation were removed and Quanteda's stemming function was applied to the whole corpus to reduce the number of words with the same meaning.
There were additional, extra_words, removed from the corpus. They were terms like https, t.co, and three letter month abbreviations which ended up just being a date stamp.
")

doc <- c("321","40","55","106","100","218","94","206","1,140")
features <- c("11,456","4,933","7,456","6,703","8,387","15,698","8,533","13,654","53,546")
blog_names <- c("Breitbart","Hot Air","Michelle Malkin","Crooks and Liars","Daily Kos","Mother Jones","Factcheck.org","Politico","Total")
data_descrip_table <- data_frame(blog_names,doc,features)
colnames(data_descrip_table) <- c("Blog","Documents","Features")


knitr::kable(data_descrip_table)

