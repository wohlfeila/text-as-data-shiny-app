shinyUI(
  dashboardPage(title = "Text As Data App", 
    #dashboardHeader(title = HTML(paste(icon('paragraph'),'Text As Data Project'))),
    dashboardHeader(title = tagList(img(src="pic.jpg", height=30), "Text As Data Project"), 
                    titleWidth = 250),
    dashboardSidebar(
      width = 250,
      sidebarMenu(
      menuItem("Introduction", tabName = "introduction",icon = icon("info")),
      menuItem("Model Description", tabName = "modeloutput",icon = icon("list")),
      menuItem("Latent Dirichlet Allocation", tabName = "lda",icon = icon("text-width")),
      menuItem("Structural Topic Model", tabName = "stm",icon = icon("terminal")),
      menuItem("Naive Bayes", tabName = "naivebayes",icon = icon("spinner")),
      menuItem("Support Vector Machine", tabName = "svm",icon = icon("code")),
      menuItem("Word Cloud", tabName = "wordcloud",icon = icon("cloud")),
      menuItem("Keyness Plot", tabName = "keynessplot",icon = icon("bar-chart")),
      menuItem("Dendrogram", tabName = "dendrogram",icon = icon("sitemap")),
      menuItem("Discussion and Conclusions", tabName = "dandc",icon = icon("comments"))
      
      )
      
    ),
    dashboardBody(
      theme_custom,
      tags$style(HTML("
    .tabbable > .nav > li > a                  {background-color: rgb(229,226,224,1);  color:black}
    .tabbable > .nav > li[class=active]    > a {background-color: rgb(0,45,114); color:white}
    .js-irs-0 .irs-single, .js-irs-0 .irs-bar-edge, .js-irs-0 .irs-bar {background: rgb(0,45,114)}
    .js-irs-1 .irs-single, .js-irs-1 .irs-bar-edge, .js-irs-1 .irs-bar {background: rgb(0,45,114)}
    .js-irs-2 .irs-single, .js-irs-2 .irs-bar-edge, .js-irs-2 .irs-bar {background: rgb(0,45,114)}
    .js-irs-3 .irs-single, .js-irs-3 .irs-bar-edge, .js-irs-3 .irs-bar {background: rgb(0,45,114)}
    .js-irs-4 .irs-single, .js-irs-4 .irs-bar-edge, .js-irs-4 .irs-bar {background: rgb(0,45,114)}
  ")),
      tabItems(
        tabItem(tabName = "introduction",
                h2("Welcome to my Text as Data final project"),
                fluidPage(
                  mainPanel(
                    tabsetPanel(
                      tabPanel("Introduction",
                               br(),
                               p("Since the 104th congress and the “Gingrich Revolution”, political speech has become 
                                  increasingly polarizing (Gentzkow et al (2016)).  Newt Gingrich has been widely credited as playing 
                                  a significant role in precipitating a combative approach to political speech.  This is 
                                  important because of the relationship between political speech and public opinion.  
                                  Every American consumes political speech in one form or another.  An influential source, 
                                  are political blogs, which can vary from liberal to conservative and everything in between.   
                                  These outlets have considerable influence over how the general population views political parties and their policy.")
                                  ,br(), 
                                p("The goal of this application is to analyze blog publications to see, who is speaking, what they are saying and how they are saying it.  
                                  Multiple models will be presented along with visualizations, which will aid in answering each of those questions.   
                                  The idea here is not to present novel ways of solving these problems, but to progress ways of creating interactive visualizations to analyze political text.  
                                 As you move through the application, descriptions of the model and instructions on how to interact with the visualization will be presented. ")
                               ),
                      tabPanel("Literature Review",
                               br(),
                               p("Yu et al (2008) used congressional floor debates to classify which party a given speaker was associated 
                                 with.  The challenge in using floor debates is, opinions are expressed indirectly usually using 
                                 different choice of nouns instead of adjectives or adverbs.  Additionally, the nouns that are used in 
                                 floor debates generally carry no political meaning which makes it difficult to determine if the speaker 
                                 is for or against a specific policy."), 
                               p("Hirst et al (2010) research cast doubt on using words as features to classify ideology.  They suggest language 
                                 of attack verse defense is more appropriate in political speech.  If a speaker is defending a policy, they should support it, 
                                 and vis-versa.  Given the fact that different political parties dominate different times in history, it's more effective
                                 to classify ideology by whether or not they are attacking the policy being presented or defending it"),
                               p("Diermeier et al (2012) used support vector machines (SVM) to classify the most extreme liberal 
                                 and conservative senators.  There model produced a 92% accuracy rate when looking at the extremes 
                                 but performed much worse when looking at moderate senators."),
                               p("Lucus et all (2015) walk through new tools for analyzing text in comparative politics.  They describe 
                                 current developments in applied research and how open-source tools can be used to analyze a variety of text.
                                 The structural topic model used in this app is similar to the one outlined in this paper.  Instead of comparing
                                 different governments, it was used to compare topics discussed between political parties in the United States."),
                               p("Gentzkow et al (2016) measures polarization in political speech over time.  They found that language spoken
                                 between Democrats and Republicans are far different than what it was in the past.  They argue this could have profound impacts on 
                                 the American electorate."),
                               p("Biei et al (2003) discuss how to model textual data using LDA.  The model described in the paper is similar to the one used in this app.
                                 Further description of the model can be found under model descriptions.")
                      ),
                      tabPanel("Citations",
                               br(),
                               p("- Hirst, Graeme, Yaroslav Riabinin, J. Graham, Magali Boizot-Roche and Colin Morris.", 
                                 a("Text to ideology or text to party status?",href = "http://citeseerx.ist.psu.edu/viewdoc/summary?doi=10.1.1.306.9189") ,
                                 "(2010)."),
                               p("- Yu, Bei; Kaufmann, Stefan; and Diermeier, Daniel. (2008).",  
                                 a("Exploring the characteristics of opinion expressions for political opinion classification.", href = "https://dl.acm.org/citation.cfm?id=1367848") ,  
                                 "Proceedings of the 9th International Conference on Digital Government Research (dg.o 2008), 82-91"),
                               p("- Daniel Diermeier, Jean-Francois Godbout, Bei Yu, Stefan Kaufmann. (2012)",
                                 a("Language and Ideology in Congress.", href = "https://www.cambridge.org/core/journals/british-journal-of-political-science/article/language-and-ideology-in-congress/1063F5509BC2ABC3F9A0E164E58157EE") ,"British Journal of Political 
                                 Science 42:01, pages 31-55. "),
                               p("- Blei, David; Ng, Andrew; Jordan, Michael. (2003).", 
                                 a("Latent Dirichlet Allocation.", href = "http://www.jmlr.org/papers/volume3/blei03a/blei03a.pdf"), "Journal of Machine Learning Research, pages 993-1022"),
                               p("- McCallum, Andrew; Nigam, Kamal. (1998).", 
                                 a("A Comparison of Event Models for Naive Bayes Text Classification.", href = "http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.65.9324&rep=rep1&type=pdf")),
                               p("- Roberts, Margaret; Stewart, Brandon; Tingley, Dustin; Lucas, Christopher Lucas; Leder-Luis, Jetson; Gadarian, Shana; Albertson, Bethany; Rand, David. (2014).", 
                                 a("Structural Topic Models for Open-Ended Survey Responses.", href = "http://christopherlucas.org/files/PDFs/stm_experiments.pdf"), "Midwest Political Science Association, pages 1064-1082"),
                               p("- Lucus, Christopher; Nielsen, Richard; Roberts, Marharet; Stewart, Brandon; Storer, Alex; Tingley, Dustin. (2015).",
                                 a("Computer-Assisted Text Analysis for Comparitive Politics.", href = "http://christopherlucas.org/files/PDFs/text_comp_politics.pdf"),"Journal of Political Analysis 23:254-277"),
                               p("- Gentzkow, Matthew and Shapiro, Jesse M and Taddy, Matt. (2016)",
                                 a("Measuring Group Differences in High-Dimensional Choices: Method and Application to Congressional Speech.", href = "http://www.nber.org/papers/w22423"), 
                                 "National Bureau of Economic Research, Working Paper 22423")
                      ),
                      tabPanel("Data Description",
                               br(),
                               p("The data for this project came from seven political blog across the political spectrum.
                                 I split the data into liberal, conservative, and moderate blogs.  The liberal blog data came from Mother Jones, Crooks and Liars, and Daily Kos.
                                 The conservative blog data came from Breitbart, Hot Air, and Michelle Malkin.  The moderate blog data came from Politico and Factcheck.org.
                                 The goal was to get a similar amount of data for each political bias."),  
                                p("The liberal blogs consist of 424 documents with 30,788 features.
                                  The conservative blogs consist of 416 documents and 23,845 features.  The moderate blogs consist of 300 documents and 22,187 features.
                                  For each ideology, the data was scraped between January 2018 and November 2018, just prior to the election.
                                  For each blog, stop words and punctuation were removed and Quanteda's stemming function was applied to the whole corpus to reduce the number of words with the same meaning.
                                  There were additional, extra_words, removed from the corpus. They were terms like https, t.co, and three letter month abbreviations which ended up just being a date stamp.
                                  "),
                               mainPanel(
                                 br(),
                                 tableOutput("blogtable")
                               )
                               )
                    )
                    )
                )
                  ),
        tabItem(tabName = "modeloutput",
                h2("Model Descriptions"),
                br(),
                fluidPage(
                  mainPanel(
                   tabsetPanel(
                    tabPanel("Latent Dirichlet Allocation",
                             br(),
                             p("The goal of LDA is to detect underlying topics within text documents. 
                               Documents with similar topics will use similar groups of words.
                             Documents are probability distributions over latent topics and topics are probability 
                               distributions over words.  Every document has contents a number of topics
                               and each topic has a distribution of words associated with that topic. 
                             That means we are working with probability distributions rather than word 
                               frequencies."),
                             p("Under the Latent Dirichlet Allocation tab, a two topic LDA will automatically run.
                               From there a different number of topics and word frequencies can be chosen and 
                               the model re-run.
                               On the topics comparisons tab, a linear regression is run and compares each topic
                               frequency based on blog.")
                             ),
                    tabPanel("Structural Topic Model",
                             br(),
                            p("STM is a general method for modeling documents with context. 
                             By modeling context using meta data in documents sets enable comparison. 
                             There are two main uses of meta data - topics prevalence and topical content. 
                             Topic prevalence can vary by meta data - Democrats talk about education more than Republicans
                             Topic content can also vary by meta data - Democrats are less likely to use the word life when talking about abortion than Republicans.
                             By including context improves the model with more accurate estimation and better qualitative interpretability."),
                            p("Under the Structural Topic Model tab, results of an STM model is shown.  The model produces 85 different topics.
                              Under the model tab, select any number of topics to see whether conservatives or liberals talked about
                              it more frequently.  The next tab takes 20 topics and plots words either conservative or liberal blogs used
                              to talk about the topic.  This will show how each side discusses a topic.")
                            ),
                    tabPanel("Naive Bayes",
                             br(),
                             p("Naive Bayes is a kind of classifier which uses the Bayes Theorem. It predicts membership probabilities for 
                               each class such as the probability that given record or data point belongs to a particular class.  
                               The class with the highest probability is considered as the most likely class. This is also known as Maximum A Posteriori (MAP).  
                               Naive Bayes classifier assumes that all the features are independent of each other. Presence or absence of a feature does not 
                               influence the presence or absence of any other feature. (Rahul Saxena at Dataaspirant)"),
                             p("Under the Naive Bayes tab, the model results are provided in the first tab.  The classifier achieved roughly
                               a 70% accuracy rate.  It accurately classified conservative and moderate documents at a high rate; however, it had trouble
                               with liberal documents.  The next tab shows a heat map with the corresponding successful classified percentages.  The final tab allows you
                               to upload your own document and run the trained classifier.   For the file upload, the format has to be a single .txt document")
                            ),
                    tabPanel("Support Vector Machine",
                             br(),
                            p("An SVM model is a representation of the examples as points in space, mapped so that the examples of the separate categories are divided by 
                              a clear gap that is as wide as possible. New examples are then mapped into that same space and predicted to belong to a category based on which side of the gap they fall.
                              In addition to performing linear classification, SVMs can efficiently perform a non-linear classification using what is called the kernel trick, 
                              implicitly mapping their inputs into high-dimensional feature spaces. (Wikapedia)"),
                            p("Under the Support Vector Machine tab, you can train your own model using different training and test sizes and different kernels.
                              In the next tab, the model results will be produced.  The linear and RBF kernels perform at nearly 100% accuracy.  
                              The final tab plot a boxplot of the results.  The plot shows the quartiles of probabilities for each document.")
                            )
                    )
                  )
                )
        ),
        tabItem(tabName = "naivebayes",
                h2("Naive Bayes"),
                fluidPage(
                  tabsetPanel(
                    tabPanel("Model",
                             br(),
                             imageOutput("NBpredtable", height = 600, width = 400)
                             ),
                    tabPanel("Visualization",
                             br(),
                             h3("Accuracy Percentage Heatmap", align = "center"),
                             br(),
                             splitLayout(cellWidths = c("75%", "25%"), plotOutput("NBheatmap"), plotOutput("NBlegend"))
                             
                    ),
                    tabPanel("File Import",
                             br(),
                             helpText("Note: upload a single article as a .txt file to see how the model classifies it."),
                             br(),
                             fileInput("file1", "Choose Text File",
                                       accept = c(
                                         "text/csv",
                                         "text/comma-separated-values,text/plain",
                                         ".csv")
                             ),
                    conditionalPanel(
                      condition = "$('html').hasClass('shiny-busy')",
                      br(),
                      h4("Please wait, your document is being classified...")
                    ),
                    mainPanel(
                      htmlOutput("contents")
                    )
                    )
                  )
                )
                
        ),
        tabItem(tabName = "svm",
                h2("Support Vector Machine"),
                fluidPage(
                  tabsetPanel(
                    tabPanel("Train Data",
                             sliderInput("svmfreq",
                                         "Number of Observations for Training:",
                                         min = 1,  max = 1140, value = 900),
                             radioButtons("svmkernel", "Select Kernel", svm_kernels, selected = "polynomial"),
                             br(),
                             actionButton('gosvm', 'Run Support Vector Machine')
                             ),
                    tabPanel("Model Results",
                             conditionalPanel(
                               condition = "$('html').hasClass('shiny-busy')",
                               br(),
                               h2("running svm...")
                             ),
                             plotOutput("finalsvm", height = 500)
                             ),
                    tabPanel("Visualization",
                             conditionalPanel(
                               condition = "$('html').hasClass('shiny-busy')",
                               br(),
                               h2("plotting boxplot...")
                             ),
                             plotOutput("svmplot")
                             )
                  )
                )
        ),
        tabItem(tabName = "stm",
                h2("Structural Topic Model"),
                verticalLayout(
                  tabsetPanel(
                    tabPanel("Top Topics",
                             br(),
                             plotOutput("topicfreqplot", width = 1000, height = 1100)
                             ),
                  tabPanel("Model",
                           br(),
                  checkboxGroupInput("structure", "Choose Topics to View",
                                     choices = topicchoice, inline = TRUE, 
                                     selected = c(4,18,16,7,26,35,21,45,49,37)),
                  actionButton('gostrutopic', 'Add Topics'),
                  br(),
                  conditionalPanel(
                    condition = "$('html').hasClass('shiny-busy')",
                    h2("loading..."),
                    br()
                  ),
                  plotOutput("structuralplot", width = 750, height = 1500)
                ),
                  tabPanel("Words",
                         br(),
                         selectInput("wordstm", "Choose a Topic:",
                                     choices = seq(1,25,1)),
                         conditionalPanel(
                           condition = "$('html').hasClass('shiny-busy')",
                           br(),
                           h2("loading...")
                         ),
                plotOutput("structuralwordplot1", width = 750, height = 200),         
                plotOutput("structuralwordplot", width = 1200, height = 800)
                  )
                )
                )
        ),
        tabItem(tabName = "lda",
                h2("Latent Dirichlet Allocation"),
                verticalLayout(
                  sidebarPanel(
                    sliderInput("topicmod",
                                "Minimum Word Frequency:",
                                min = 1,  max = 50, value = 15),
                    sliderInput("numberoftopics",
                                "Number of Topics:",
                                min = 2,  max = 20,  value = 2),
                    selectInput("topiclm", "Choose a Topic:",
                                choices = c())
                  ),
                  
                  mainPanel(
                    actionButton('gotopic', 'Run Latent Dirichlet Allocation'),
                    br(),
                    conditionalPanel(
                      condition = "$('html').hasClass('shiny-busy')",
                      br(),
                      h2("running LDA...")
                    ),
                    br(),
                    tabsetPanel(
                      tabPanel("Topics",
                               tableOutput("topic")
                      ),
                      tabPanel("Topic Comparison",
                               verbatimTextOutput("topiclmreg"))
                  ))
                    
                    )
        ),
        tabItem(tabName = "wordcloud",
                h2("Word Cloud"),
                sidebarLayout(
                  # Sidebar with a slider and selection inputs
                  sidebarPanel(
                    selectInput("selection", "Choose a Blog:",
                                choices = blog),
                    actionButton("update", "Change"),
                    br(),
                    sliderInput("freq",
                                "Minimum Frequency:",
                                min = 1,  max = 50, value = 15),
                    sliderInput("max",
                                "Maximum Number of Words:",
                                min = 1,  max = 150,  value = 50)
                  ),
                  
                  # Show Word Cloud
                  mainPanel(
                    plotOutput("plot", width = 750, height = 750)
                  )
                )
        ),
        tabItem(tabName = "keynessplot",
                h2("Keyness Plot"),
                verticalLayout(
                  sidebarPanel(
                     selectInput("key1", "Choose Target Blog:",
                                  choices = blog,
                                  selected = "Mother Jones"),
                     
                     selectInput("key2", "Choose Comparison Blog:",
                                 choices = blog,
                                 selected = "Breitbart")
                  ),
                  
                  mainPanel(
                    plotOutput("keyPlot", width = 1100, height = 800)
                  )
                )
        ),
        tabItem(tabName = "dendrogram",
                h2("Dendrogram"),
                verticalLayout(
                sidebarPanel(
                  selectInput("dgclust", "Choose Number of Clusters:",
                              choices = seq(1,25,1),
                              selected = 2)
                  ),
                
                mainPanel(
                  plotOutput("distPlot", width = 1350, height = 1500)
                  )
                 )
                ),
        tabItem(tabName = "dandc",
                h2("Discussion and Conclusions"),
                br(),
                p("This project was intended to showcase various ways of presenting models and visualizations when analyzing text, so the conclusions will be general as some of the results can change depending on how each model is configured."),
                br(),
                p("The first model that was presented was Latent Dirichlet Allocation.  The first model ran produced two topics.  The two topics were very general and didn’t give a good understanding of what was being discussed in the corpus.  When we increase the number of topics, we can see clearer separation in subjects.  With a minimum word frequency of 26 and 18 topics, the LDA produced some interesting results.  The first topic mentions children, family, separate, and immigration, which represents the stories about the children being separated at the US Mexican border.   The first topics also uses the words, student, American, worker, and school, which could represent a topic about getting a job after college.  It’s not clear how those two sets of words work together.  This would suggest there are more than 18 topics in the corpus."),
                br(),
                p("The second model that was presented was the Structural Topic Model.  The parameters in the model were relaxed to allow the model to produce what it thought the number of topics were.  The STM model produced 85 different topics, which can be seen on the first tab.  The plot shows the proportion of each topic within the corpus.  Topic 4, which includes words like: trump, presid, people, media, said, cnn, bomb, polit, republican, and news was the most common topic.  This topic is about the man mailing bombs to news outlets and opponents of President Trump.  The STM produces much clearer topics compared to LDA, mainly because STM was allowed to decide how many topics there were."),
                br(),
                p("The tab labeled “model” under the Structural Topic Model produces a plot that compares the proportion a topic was discussed by ideology.  In this plot, when a topic is further to the right of the center line, it means liberals discuss the topic more than conservatives, and vis versa when the topic is to the left of the center line.  The plot shows the top ten topics.  The top topic, which is topic four, sits to the right of the center line.  This suggests that liberals talk about the mail bomber at higher proportions than conservatives.  Additional topics can be added to the plot."),
                br(),
                p("On the next tab over labeled, “Words”, this is a plot of the types of words that are used by each ideology to discuss a specific topic.  It's important to note that the topics produced by this model are different than the original STM model.  This is because the model was capped at 25 topics due to processing time.  Looking at topic four, we can get a good sense that it’s about the Republican economic policy, mainly, tax breaks and tariffs.   When conservatives talk about economic policy, they use words like jobs, and unemployment, where Liberals use words like tax, and teacher.  Conservatives message is that their policy will boost the economy and everyone will be better off, where Liberals paint Republican policy as only helping the upper class.  Again, this model suffers from the same problem the LDA model did, where the number of topics is limited.  This creates broader topics than when the model is able to choose the number on its own."),
                br(),
                p("The third model used in the app was Naïve Bayes.  The overall accuracy of the model is 69.74%.  When we look at each ideology individually, the classifier performed best on conservative blogs, then moderate, and finally liberal blogs performed the worst.  The accuracy rate for conservative classification was 90.32%, 70.94% for moderate blogs, and 51.65% for liberal blogs.  The classifier tends to classify documents as conservative, which would suggest, the conservative blogs used had highly predictive words compared to the other ideologies."),
                br(),
                p("The final model used in the app was Support Vector Machine.  In the SVM tab, four different models can be trained using different kernels.  The two best performers are Linear, and Radial Basis.  They have an accuracy of close to 100%.  When we look at the boxplot under the visualization tab, we can see that conservative and liberal blogs show a near one probability of being conservative and liberal for every document.  The moderate class has a couple that are lower probabilities, but still classified correctly.    The issues of classifying documents as conservative using the Naïve Bayes classifier, are overcome using SVM."),
                br(),
                p("Given my research question did not attempt to dig deep into a single subject or use a novel question, the results from each model are consistent with what I expected.  Conservatives and Liberals use different language to discuss the same subject.  It all comes down to how they want to message their policy and what they believe their readers values are.  Based on the results of the Naïve Bayes and Support Vector Machine classifier, the SVM performs better when using blog text as data.")
        )
      
      )
      )
  )
  
)
