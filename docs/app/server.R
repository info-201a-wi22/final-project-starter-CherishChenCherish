library(shiny)
library(tidyverse)
library(lubridate)
library(plotly)
Sys.setlocale(locale="English")
data <- read.csv("Sample - Superstore.csv") 
data$Order.Date <- mdy(data$Order.Date)
data$Ship.Date <- mdy(data$Ship.Date)
data$Year <- year(data$Order.Date)

server <- function(input, output) {
  output$plot1 <- renderPlotly({
    dat <- data %>% filter(Region==input$region, Segment==input$segment)
    ggplot(dat, aes(x=Category, y=Profit, fill=Category)) + geom_boxplot() +
      labs(title="Profit of each order by category")
  })
  
  output$plot2 <- renderPlotly({
    dat <- data %>% filter(Region==input$region, Segment==input$segment) %>%
      group_by(Category) %>% summarise(Profit=sum(Profit)) %>%
    ggplot(aes(x=Category, y=Profit, fill=Category)) + geom_col() +
      labs(title="Total Profit of each category",
           ylab="Total Profit")
  })
  
  output$plot3 <- renderPlotly({
    dat <- data %>% filter(Category==input$category, Ship.Mode==input$ship) %>%
      group_by(Segment, Region) %>% summarise(Sales=sum(Sales))  
    ggplot(dat, aes(y=Sales, x=Segment, fill=Region)) + geom_col(position = position_dodge()) +
      labs(title="Total Sales by Segment and Region")

  })
  
  output$plot4 <- renderPlotly({
    dat <- data %>% filter(Category==input$category, Ship.Mode==input$ship) %>%
      group_by(Sub.Category) %>% summarise(Sales=sum(Sales)) 
  
    fig <- dat %>% plot_ly(labels = ~Sub.Category, values = ~Sales)
    fig <- fig %>% add_pie(hole = 0.6)
    fig <- fig %>% layout(title = "Total Sales by Sub Category",  showlegend = F,
                          xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
                          yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
    
    fig
  })
  
  output$plot5 <- renderPlotly({
    data %>% filter(Segment==input$segment1) %>% group_by(Year, Category) %>% summarise(Profit=sum(Profit)) %>%
      ggplot(aes(x=Year, y=Profit, color=Category)) + geom_line() +
      geom_point() +
      labs(y="Total Profit", 
           title="Total Profit By Year")
  })
  
  output$plot6 <- renderPlotly({
    data %>% filter(Segment==input$segment1) %>% group_by(State) %>% summarise(Profit=sum(Profit)) %>%
      arrange(desc(Profit)) %>% head(10) %>%
      ggplot(aes(x=reorder(State, Profit), y=Profit, fill=State)) + geom_col(position = position_dodge()) +
      coord_flip() +
      labs(y="Total Profit", 
           x="State",
           title="Top 10 States by total profit")
  })
  
}