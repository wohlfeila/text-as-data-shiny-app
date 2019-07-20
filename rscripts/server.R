shinyServer(function(input,output,session){
  
  observeEvent(input$numberoftopics, {
    n <- input$numberoftopics
    updateSelectInput(session, "topiclm", choices = 1:n)
  })
    df_subset<- reactive({
      a <- corpus_subset(myCorpus, blog %in% input$selection)
      b = dfm(a, remove = c(stopwords("english"),extra_words), remove_punct = TRUE, stem = TRUE, tolower = TRUE)
      return(b)
    })
    
    output$plot <- renderPlot({
      # Change when the "update" button is pressed...
      input$update
      # ...but not for anything else
      isolate({
        withProgress({
          setProgress(message = "Processing corpus...")
      textplot_wordcloud(df_subset(), min_count = input$freq, max_words=input$max,
                    color=brewer.pal(8, "Dark2"))
        })
      })
    })
    
      output$distPlot <- renderPlot ({
        plot(blog_cluster)
        rect.hclust(blog_cluster, k = as.numeric(input$dgclust), border = "red")
    })
      
    
      keyp<- reactive({
        key_corpus <- corpus_subset(myCorpus, 
                                  blog %in% c(input$key1, input$key2))
        key_dfm <- dfm(key_corpus, groups = "blog", remove = c(stopwords("english"),extra_words), 
                     remove_punct = TRUE, stem = TRUE)
        result_keyness <- textstat_keyness(key_dfm, target = input$key1)
        
        return(result_keyness)
        
      })
 
       output$keyPlot <- renderPlot ({
         textplot_keyness(keyp(), margin = 0.05, labelsize = 5)
      
        })
       
       lda_rv <- reactiveVal(NULL)
       
       topmod<- reactive({
         blog_dfm_trimmed<- dfm_trim(blog_dfm, min_termfreq = input$topicmod)
         rowTotals <- apply(blog_dfm_trimmed , 1, sum) 
         dfm_new   <- blog_dfm_trimmed[rowTotals> 0, ]
         lda_out <- LDA(dfm_new, input$numberoftopics, method = "VEM")
         lda_rv(lda_out)
         most_likely_topics <- topics(lda_out)
         return(terms(lda_out, 10))
         
       })
       
       output$topic <- renderTable({

         input$gotopic # Re-run when button is clicked
         
         isolate(print(topmod()))
       
       })
       
       topmodlm<- reactive({
         topic_prop <- lda_rv()@gamma[,as.integer(input$topiclm)]
         reg_out <- lm(topic_prop ~ rating)
         return(reg_out)
       })
       
       output$topiclmreg <- renderPrint(summary(topmodlm()))
       
       output$selected_var <- renderText({ 
         paste("",input$var)
       })
       
       stmodel <- reactive({
         plot(effect_estimates,
              covariate = "rating",
              topics = as.numeric(input$structure),
              method = "difference",
              n = 10,
              model = stm_out,
              cov.value1 = "Liberal",
              cov.value2 = "Conservative",
              xlim = c(-.25, .25),
              xlab = "More Conservative ... More Liberal",
              main = "Effect of Liberal vs. Conservative",
              labeltype = "prob",
              verbose.labels = FALSE)
       })
       
       output$structuralplot <- renderPlot({
         
         input$gostrutopic # Re-run when button is clicked
         
         isolate(stmodel())
         
       })
      
      output$topicfreqplot <- renderPlot(plot(stm_out, type = "summary", n = 10, xlim = c(0, .2)))  
      
      output$structuralwordplot <- renderPlot({

        plot(stm_content, type = "perspectives", topics = as.numeric(input$wordstm))
        
      })
      
      output$structuralwordplot1 <- renderPlot({
        
        plot(stm_content, type = "labels", topics = as.numeric(input$wordstm))
        
      })
      
        output$contents <- renderUI({

          inFile <- input$file1
          
          if (is.null(inFile))
            return(NULL)
          
          newdata <-read_lines(inFile$datapath)
          newdatacorpus <- corpus(newdata)
          newdatadfm <- dfm(newdatacorpus, 
                               stem = TRUE, remove_punct = TRUE,
                               remove = c(stopwords("english")))
          newwords <- newdatadfm@Dimnames$features
          newwordsYN <- ifelse(train_words %in% newwords, "Yes", "No")
          tmp <- matrix(newwordsYN, nrow = 1)
          colnames(tmp) <- train_words
          rownames(tmp) <- "input_doc"
          pred <- as.character(predict(classifier, newdata=tmp))
          if (pred == "Liberal") {
            valueBox(value = pred, subtitle = "Classification", icon = icon("check"), width = 8, color = "blue")
          } else if (pred == "Conservative") {
            valueBox(value = pred, subtitle = "Classification", icon = icon("check"), width = 8, color = "red")
          } else {
            valueBox(value = pred, subtitle = "Classification", icon = icon("check"), width = 8, color = "purple")
          }
        })
        
        output$NBpredtable <- renderImage({
          filename <- normalizePath("www/NBCM.png")
          list(src = filename)
        }, deleteFile = FALSE)
          
        
        output$NBheatmap <- renderPlot({
          
          heatmap(data, scale="column", col = coul,cexRow = 1.5,
                  cexCol = 1.5, margins = c(10,10), xlab = "Predicted", ylab = "Actual")
          
        })        
      
        output$NBlegend <- renderPlot({
          
          plot(NULL ,xaxt='n',yaxt='n',bty='n',ylab='',xlab='', xlim=0:1, ylim=0:1)
          legend("topleft", legend =c('0-16%', '17-32%', '33-49%',
                                      '50-66%', '67-83%','84-100%'), pch=15, pt.cex=4, cex=1.5, bty='n',
                 col = c('#eff3ff', '#c6dbef', '#9ecae1', '#6baed6', '#3182bd', '#08519c'))
          mtext("Percent Classification", at=0.2, cex=1)
          
        }) 
        
        svmtrain<- reactive({
          create_container(svmmatrix, svmdata$bias, 
                           trainSize=as.numeric(1:input$svmfreq),virgin=FALSE)
        })
        
        runsvm<- reactive({
          svmmodel <- train_models(svmtrain(), algorithms="SVM", kernel = input$svmkernel)
          svmresults <- classify_models(svmtrain(), svmmodel)
          svm_label <- svmresults$SVM_LABEL
          actual_label <- svmtrain()@testing_codes
          cm <- confusionMatrix(data = table(svm_label,actual_label))
          return(list(cm,svmresults))
        })
        
        output$finalsvm <- renderPlot({
          
          input$gosvm # Re-run when button is clicked
          
          textplot(      #wrap textplot around capture.output
            capture.output(     #capture output of confusionMatrix in text format
              isolate(print(runsvm()[[1]]))  #your original code here
            )      #close capture.output
          )
          
        })
        
        output$svmplot <- renderPlot({
         
           input$gosvm
          
          isolate(plot(runsvm()[[2]], main = "SVM Model Results", ylab = "SVM Probability", xlab = "SVM Label"))
          
        })
        
        output$blogtable <- renderTable(data_descrip_table, striped = TRUE, bordered = TRUE)
        

})


