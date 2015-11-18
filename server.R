library(shiny)
shinyServer(
    function(input, output) {
        mu<-reactive({if (input$beton == "head"){
            (input$prob*input$win-(1-input$prob)*input$loss)
        }else {
            ((1-input$prob)*input$win-input$prob*input$loss)
        }})
        sd<-reactive({
            if (input$beton == "head"){
                mu_sq<-input$prob*input$win^2+(1-input$prob)*input$loss^2
            }else {
                mu_sq<-(1-input$prob)*input$win^2+input$prob*input$loss^2
            }
            sqrt(mu_sq-(mu())^2)
        })
        output$sum<-renderText({mu()*input$rounds})
        output$plot<-renderPlot({
            std<-sd()/sqrt(input$rounds)
            mu<-mu()*input$rounds
            if (std>0){
            d11<-round(mu-std,2)
            d12<-round(mu+std,2)
            d21<-round(mu-2*std,2)
            d22<-round(mu+2*std,2)
            d31<-round(mu-3*std,2)
            d32<-round(mu+3*std,2)
            
            x<-seq(d31,d32, by=std/10)
            y<-dnorm(x, mean=mu, sd=std)
            plot(x, y, type="l", xlab="Earning",ylab="Density")
            
            lines(c(mu,mu),c(0,1),col="red")
            text(mu,0,mu, col="red")
            
            lines(c(d11,d11),c(0,1),col="green")
            text(d11,0,d11, col="green")
            lines(c(d12,d12),c(0,1),col="green")
            text(d12,0,d12, col="green")
            
            lines(c(d21,d21),c(0,1),col="blue")
            text(d21,0,d21, col="blue")
            lines(c(d22,d22),c(0,1),col="blue")
            text(d22,0,d22, col="blue")
            }
        })
        
        output$help_pars <- renderText({"
                                   'Probabilty of head' - probability that will show head for one flip
                                   'You bet on' - choice that you make in every case of a series
                                   'You win if you're right' - amount that you win if coin shows a side that you bet on
                                   'You loose if you're wrong' - amount that you loose in another case
                                   'Number of rounds' - number of coinflips with these parameters
                                   
                                   As a result app shows expected value of your earning in given series of games.
                                   Additionally it shows density plot for sample mean of such series. 
                                   Red line - expected value
                                   Green lines - 1 standard deviation out of the mean (68% cases)
                                   Blue lines - 2 standard deviations out of the mean (95% cases)"})
        output$help_res <- renderText({"
                                        As a result app shows expected value of your earning in given series of games.
                                        Additionally it shows density plot for sample mean of such series. 
                                        Red line - expected value
                                        Green lines - 1 standard deviation out of the mean (68% cases)
                                        Blue lines - 2 standard deviations out of the mean (95% cases)"})
    }    
)