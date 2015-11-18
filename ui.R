library(shiny)
shinyUI(pageWithSidebar(
    headerPanel("Earning prediction for coinflip game"),
    sidebarPanel(
        numericInput('prob', 'Probability of head', 0.5, min = 0, max = 1, step=0.01),
        radioButtons("beton", "You bet on",
                           c("Head" = "head",
                             "Tail" = "tail"), selected="head"),
        numericInput('win', "You win if you're right", 1, min = 0),
        numericInput('loss', "You loose if you're wrong", 1, min = 0),
        numericInput('rounds', 'Number of rounds', 100, min = 0, step = 1)
    ),
    mainPanel(
        tabsetPanel(
            tabPanel("Result",
            h3("Expectation"),
            h4("After all rounds you are going to earn"),
            verbatimTextOutput("sum"),
            h4("Probability density for your final earning"),
            plotOutput('plot')),
            tabPanel("Help",
                     p("This apps calcualtes the expected value for earnings in coinflip game."), 
                     p("Parameters description:"),
                     p("'Probabilty of head' - probability that will show head for one flip"),
                     p("'You bet on' - choice that you make in every case of a series"),
                     p("'You win if you're right' - amount that you win if coin shows a side that you bet on"),
                     p("'You loose if you're wrong' - amount that you loose in another case"),
                     p("'Number of rounds' - number of coinflips with these parameters"),
                     p("As a result app shows expected value of your earning in given series of games.
                        Additionally it shows density plot for sample mean of such series. 
                        Red line - expected value.
                        Green lines - 1 standard deviation out of the mean (68% cases).
                        Blue lines - 2 standard deviations out of the mean (95% cases)."))  

    )
)))