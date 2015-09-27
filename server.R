library(shiny)
library(datasets)
library(caret)
library(randomForest)
library(e1071)

data(USJudgeRatings)
data <- USJudgeRatings[,c(2,4,6,7,8,9,10,12)]

for (i in 1:8) {
    data[,i] <- cut(data[,i],quantile(data[,i]),labels=FALSE,include.lowest=TRUE)
}

data$RTEN[which(data$RTEN < 3)] <- 0
data$RTEN[which(data$RTEN > 2)] <- 1
data$RTEN <- as.factor(data$RTEN)

set.seed(3456)
t <- createDataPartition(y=data$RTEN,p=0.7,list=FALSE)
training <- data[t,]
testing <- data[-t,]
fit <- train(RTEN~.,data=data,method="rf",prox=FALSE)

shinyServer(
    function(input, output) {
        d <- reactive({
            data.frame(INTG=input$INTG,DILG=input$DILG,DECI=input$DECI,PREP=input$PREP,FAMI=input$FAMI,ORAL=input$ORAL,WRIT=input$WRIT)
            })
        p <- reactive({
            predict(fit,d())
        })
        output$score <- renderPlot({
            barplot(as.numeric(d()),names.arg=c("INTG","DILG","DECI","PREP","FAMI","ORAL","WRIT"),col="BLUE",ylim=c(0,4))
        })
        output$prediction <- renderText({
            if (p() == 0) "BAD: This Judge will be dismissed."
            else "GOOD: This Judge will be retained."
            })
    }
)