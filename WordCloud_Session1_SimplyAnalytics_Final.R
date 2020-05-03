# installing packages

install.packages("tm") # For text mining and data cleaning activities
install.packages ("SnowballC") # For stemming of text
install.packages("textstem") # For stemming of text
install.packages("readxl") # For reading excel files
install.packages("dplyr") # For filtering and selection of data
install.packages("wordcloud") # For generating word cloud
install.packages("RColorBrewer") # For colorful word cloud

# Loading Packages
library(tm) # For text mining and data cleaning activities
library(textstem) # For stemming of text
library(SnowballC) # For stemming of text
library(readxl) # For reading excel files
library(dplyr) # For filtering and selection of data
library(wordcloud) # Reading the dataset
library(RColorBrewer) # For colorful word cloud


dataset<-read_excel("C:/Users/aswin/OneDrive/SimplyAnalytics/Sessions/SimpleWordCloud/SMSDataset_WordCloud_Session1_SimplyAnalytics.xlsx",sheet="Sheet1")

# Filtering the dataset

Spamdata<-dataset %>% filter (Classification=="Spam")
#str(Spamdata)

CorpusData<-Corpus(VectorSource(Spamdata$Text)) # Converts to a Corpus i.e. Collection of text
#str(CorpusData)

CorpusData$content[1]

# Data Cleaning using tm package

CorpusData<-tm_map(CorpusData,tolower) # to convert the text to lowercase
CorpusData <-tm_map(CorpusData, removeNumbers) # to remove numbers
CorpusData <- tm_map(CorpusData, removePunctuation) # to remove punctuation
CorpusData <- tm_map(CorpusData, stripWhitespace) # to remove extra spaces
CorpusData <- tm_map(CorpusData, removeWords,stopwords("english")) # to remove stop words like a, and,...
stopwords("english") # to see list of stop words
CorpusData <- tm_map(CorpusData, removeWords,c('landline')) # To remove custom stop words
# pricing, priced, pricey --> stemming gives root word as pric
CorpusData1<-tm_map(CorpusData,stemDocument) # to stem the document using default tm package
CorpusData1<-gsub('txt','text',CorpusData1)

#Whole subsitiution in corpus data
CorpusData<-gsub('txt','text',CorpusData)

CorpusData2<-stem_words(CorpusData) # to stem the document using textStem package

#Difference between stemming and lemmitization

#pricing, priced, pricey --> stemming gives root word as pric --> does not have dictionary
#pricing, priced, pricey --> lemmitization gives root word as price --> has dictionary
CorpusData3<-lemmatize_strings(CorpusData) # to lemmatize the document using textStem package

# In case you want a different dictionary
lemma_dictionary <- make_lemma_dictionary(CorpusData, engine = 'hunspell') # also available treetagger
CorpusData3<-lemmatize_strings(CorpusData,dictionary = lemma_dictionary)
CorpusData4<-wordStem(CorpusData) # to stem the document using SnowballC package

# to divide the screen size into 2X2 matrix
#par(mfrow=c(2,2))
# Word Cloud using tm package as stemming
WordCloud_tm <- wordcloud(CorpusData1, max.words = 25,min.freq = 3, random.order = FALSE, colors="#FF6347", family = "sans", font = 2)
CorpusData1<-gsub('servic','service',CorpusData1)

# Word Cloud using textstem package as stemming
WordCloud_textstem <- wordcloud(CorpusData2, max.words = 25,min.freq = 3, random.order = FALSE, colors="#0000FF", family = "sans", font = 2)

# Word Cloud using textstem package as lemmatization
WordCloud_textlemmatize <- wordcloud(CorpusData3, max.words = 25,min.freq = 3, random.order = FALSE, colors="#594F4F", family = "sans", font = 2)

# Word Cloud using SnowBallC package as stemming
WordCloud_snowballc <- wordcloud(CorpusData4, max.words = 25,min.freq = 3, random.order = FALSE, colors="#065535", family = "serif", font = 2)

#For Colorful Word Cloud

WordCloud_colorful <-wordcloud(CorpusData3, min.freq = 1,
                               max.words=25, random.order=FALSE, rot.per=0.35, 
                               colors=brewer.pal(9, "Set1"))

#Help - RColorBrewer
?RColorBrewer
display.brewer.all()
