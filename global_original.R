library(shiny)
library(shinydashboard)
library(dplyr)
library(dashboardthemes)
library(tm)
library(knitr)
library(wordcloud)
library(PerformanceAnalytics)
library(RTextTools)
library(caret)
library(e1071)
library(RColorBrewer)
library(quanteda)
library(dendextend)
library(shinythemes)
library(colorspace)
library(topicmodels)
library(stm)
library(striprtf)
library(readr)
library(htmltools)

text <- readRDS("blogdata.rds")

myCorpus<- corpus(text) 

blog <- list("Mother Jones" = "Mother Jones", "Factcheck.org" = "Factcheck.org", 
             "Michelle Malkin" = "Michelle Malkin", "Breitbart" = "Breitbart", 
             "Crooks and Liars" = "Crooks and Liars", "Politico" = "Politico", "Hot Air" = "Hot Air",
             "Daily Kos" = "Daily Kos")

bias <- list("Liberal" = "Liberal", "Conservative" = "Conservative", "Moderate" = "Moderate")

extra_words <- c("pic.twitter.com","oct","sept","aug","Mother", "Jones","Factcheck.org","Kos", 
                 "National", "Review" , "Breitbart","Crooks", "Liars" , "Politico",
                 't.co','October','https',"monday","tuesday","wednesday","thursday","friday",
                 "saturday","sunday","2018","19","24","27","29","30", "J","20","11","17",
                 "6","13","â","25","31","21","3","28","12","26","22","1","2","nov","@","16","t")

#topic model
meta_list <- list(blog = text$blog,
                  rating = text$bias)
blogcorpus <- corpus(as.character(text$text),
                     metacorpus = meta_list)
blog_dfm <- dfm(blogcorpus,
                remove = c(stopwords("english"),extra_words),
                stem = TRUE,
                remove_punct = TRUE)

rating <- blogcorpus$metadata[[1]]

#Dendrogram

text_sample <- text
text_sample$doc_id <- paste0(text_sample$bias,": ",text_sample$doc_id)
names(text_sample) <- c("doc_id", "text", "bias", "blog", "month")
myCorpus_sample<-corpus(text_sample)
sampledCorpus<-corpus_sample(myCorpus_sample, size = 100)
blog_dfm_sample <- dfm(sampledCorpus, 
                stem = TRUE, remove_punct = TRUE,
                remove = c(stopwords("english"),extra_words))
blog_weight<-dfm_weight(blog_dfm_sample, "prop")
blog_dist_mat <- textstat_dist(blog_weight, margin = "documents")
blog_cluster <- hclust(blog_dist_mat, method = "complete")


#STM model
stm_out <- readRDS("stm_out.rds")
stm_content <- readRDS("stm_content.rds")
effect_estimates <- estimateEffect(~ rating,
                                   stm_out,
                                   meta = meta_list,
                                   uncertainty = "Global")

topicchoice <- matrix(seq(1,85,1), nrow = 5)

stm_top_corr<-topicCorr(stm_out, method = c("simple"), cutoff = 0.5)

classifier <- readRDS("NBclassifier.rds")
train_words <- readRDS("train_words.RDS")
pred <- readRDS("NBpred.rds")

theme_custom <- readRDS("theme.rds")

df_test <- readRDS("df_test.rds")
conf_mat <- confusionMatrix(pred, df_test$bias)
data <- table("Predictions"= pred,  "Actual" = df_test$bias )
coul = colorRampPalette(brewer.pal(9, "Blues"))(9)

svmdata <- text[sample(1:1140,size=1140,replace=FALSE),]
svmmatrix <- create_matrix(svmdata, language="english", minDocFreq=1, maxDocFreq=Inf, 
                        minWordLength=3, maxWordLength=Inf, ngramLength=1, originalMatrix=NULL, 
                        removeNumbers=TRUE, removePunctuation=TRUE, removeSparseTerms=0, 
                        removeStopwords=TRUE,  stemWords=TRUE, stripWhitespace=TRUE, toLower=TRUE)
svm_kernels <- c("Linear" = "linear", "Polynomial" = "polynomial", 
                 "Radial Basis" = "radial", "Sigmoid" = "sigmoid")


doc <- c("321","40","55","106","100","218","94","206","1,140")
features <- c("11,456","4,933","7,456","6,703","8,387","15,698","8,533","13,654","53,546")
ideology <- c("Conservative","Conservative","Conservative","Liberal","Liberal","Liberal","Moderate","Moderate","")
blog_names <- c("Breitbart","Hot Air","Michelle Malkin","Crooks and Liars","Daily Kos","Mother Jones","Factcheck.org","Politico","Total")
data_descrip_table <- data_frame(blog_names,doc,features,ideology)
colnames(data_descrip_table) <- c("Blog","Documents","Features","Ideology")



# rsconnect::deployApp('~/Documents/text/shiny_app/',
#                           appName = "blog-text",
#                           account = "andrew-wohlfeil")
   
# https://andrew-wohlfeil.shinyapps.io/blog-text/
