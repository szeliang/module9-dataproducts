library(shiny)

shinyUI(fluidPage(
    titlePanel('Will your Judge still be around soon?'),
    sidebarPanel(
        h5('Adjust sliders to rate Judge against his peers'),
        h5('1=Worst, 4=Best'),
        sliderInput('INTG','Integrity',value=2,min=1,max=4,step=1),
        sliderInput('DILG','Diligence',value=2,min=1,max=4,step=1),
        sliderInput('DECI','Decisiveness',value=2,min=1,max=4,step=1),
        sliderInput('PREP','Preparation for Trial',value=2,min=1,max=4,step=1),
        sliderInput('FAMI','Familiarity with Law',value=2,min=1,max=4,step=1),
        sliderInput('ORAL','Quality of Oral Rulings',value=2,min=1,max=4,step=1),
        sliderInput('WRIT','Quality of Written Rulings',value=2,min=1,max=4,step=1)
    ),
    mainPanel(
        h4('Predict whether a Judge will remain in his appointment.'),
        h5('This app lets you predict if your local Judge might be dismissed from his appointment soon.'),
        h5('It is based on the relative performance of the Judge compared to his peers, in 7 key areas.'),
        h5(''),
        h4('Instructions:'),
        h5('Use the sliders on the left to indicate the relative performance of a Judge, compared to his peers.'),
        h5('As you make your adjustments, your inputs are updated below.'),
        h5('A predictive algorithm predicts whether the judge is worth retaining or not, based on the current input.'),
        h5(''),
        h4('Your current inputs:'),
        plotOutput("score"),
        h4('Prediction Outcome:'),
        verbatimTextOutput("prediction")
    )
))