library(shiny)
library(tidyverse)
library(lubridate)
library(plotly)
library(bslib)
Sys.setlocale(locale="English")
data <- read.csv("Sample - Superstore.csv") 
data$Order.Date <- mdy(data$Order.Date)
data$Ship.Date <- mdy(data$Ship.Date)
data$Year <- year(data$Order.Date)
theme <- bs_theme(
  # Controls the default grayscale palette
  bg = "#202123", fg = "#B8BCC2",
  # Controls the accent (e.g., hyperlink, button, etc) colors
  primary = "#EA80FC", secondary = "#48DAC6",
  base_font = c("Grandstander", "sans-serif"),
  code_font = c("Courier", "monospace"),
  heading_font = "'Helvetica Neue', Helvetica, sans-serif",
  # Can also add lower-level customization
  "input-border-color" = "#EA80FC"
)

ui <- navbarPage("Superstore Analysis",
                 theme=theme,
  tabPanel("Introduction",
           h2("Overview", style="color:red"),
           p("The data was download from https://www.kaggle.com/vivek468/superstore-dataset-final."),
           p("As demand increases and competition heats up in the industry, a supermarket behemoth seeks your expertise in order to determine what works best for them. They're interested in learning which items, geographies, categories, and client segments to target or avoid. Thus, in terms of retail, this data may be studied from a variety of angles in order to determine both demand and volume of sales, as well as profit margins at various sales volumes."),
           tags$image(src="https://tse1-mm.cn.bing.net/th/id/R-C.ca0bda85a581f4502ddeb17eb8a0fc02?rik=MQNlILb9%2bGmu1Q&riu=http%3a%2f%2fwww.nbc.com%2fsites%2fnbcunbc%2ffiles%2ffiles%2fimages%2f2015%2f11%2f16%2fSuperstore_1920x1080.jpg&ehk=m5s6Pdn%2f9Lpf3j3e%2fZPWf5X43FVHLoRCHm7ZsjkfBy8%3d&risl=&pid=ImgRaw&r=0", style="width:90%; margin:0 auto"),
           h2("Major Questions", style="color:blue"),
           h3("Question 1: What are the profit trends for furniture, office products, and technology products in the United States, and how do they vary by state?", style="font-style:italic"),
           h3("Question 2: In the analysis of furniture, office products, and technology products, as well as the combined earnings of the three distinct product categories. ",style="font-style:italic"),
           h3("Question 3: We examined the sales volumes of three distinct categories of home office supplies and technology supplies, as well as the total sales volumes in various locations and shipping ways.", style="font-style:italic")),
  
  tabPanel("Trend Analysis",
           h3("Question 1: What are the profit trends for furniture, office products, and technology products in the United States, and how do they vary by state?", style="font-style:italic"),
           sidebarLayout(
             sidebarPanel(
               selectInput("segment1", label="Segment",
                           choices = unique(data$Segment), 
                           selected = "Consumer")
             ),
             mainPanel(
               plotlyOutput(outputId = "plot5"),
               plotlyOutput(outputId = "plot6")
             )
           )),
  tabPanel("Profit Analysis",
           h3("Question 2: In the analysis of furniture, office products, and technology products, as well as the combined earnings of the three distinct product categories. ",style="font-style:italic"),
    sidebarLayout(
      sidebarPanel(
        selectInput("segment", label="Segment:",
                    choices = unique(data$Segment), selected = "Consumer"),
        selectInput("region", label="Region:",
                    choices = unique(data$Region), selected = "South")
      ),
      mainPanel(
        plotlyOutput(outputId = "plot1"),
        plotlyOutput(outputId = "plot2"),
      )
    )),
  tabPanel("Sales Analysis",
           h3("Question 3: We examined the sales volumes of three distinct categories of home office supplies and technology supplies, as well as the total sales volumes in various locations and shipping ways.", style="font-style:italic"),
           sidebarLayout(
             sidebarPanel(
               selectInput("category", label="Category:",
                           choices = unique(data$Category), selected = "Technology"),
               radioButtons("ship", label="Ship Mode:",
                           choices = unique(data$Ship.Mode), selected = "First Class"),
               p("Our total sales by segment and region graph compares the different sales volumes of three different sales categories. By looking at our graph you can see that the west region tends to have the most sales across the three different sales segments. In addition the south region's sales margin is the lowest across all three different categories, which tells us that something needs to be changed in that regions, such as maybe the type of products that are being advertised or maybe their marketing strategy needs to be changed as well to broadcast what most people want to see in a product in that region. The least profitable region as you can see is the central region in every sales segment, and this is alraming because this means the buisness is losing more money than they are putting out in those regions, a complete financial redesign for this region is needed in order to prevent this from being a continous trend in the future. The east region does significantly good in sales in the consumer and home office segment but in the corporate segment there is room for a little improvement. ")
             ),
             mainPanel(
               plotlyOutput(outputId = "plot3"),
               plotlyOutput(outputId = "plot4"),
             )
           )),
  tabPanel("Summary",
           h2("Takeway 1"),
           p("Profitability studies on three distinct product categories: furniture, office supplies, and technology. The analysis of the ten most lucrative states. We discovered that technology products are the most profitable for consumers, followed by office supplies and furniture products, with the overall trend of profits increasing year after year. New York earns the most money overall. While technology products are the most profitable for corporations, they were surpassed in 2017 by furniture products. Profitability is increasing on a global scale. California is the wealthiest state. For use in the home office. Office supplies are the most profitable sector, and by 2017, technology profits had surpassed office furniture profits. New York City is the continent's most profitable city. All of the charts demonstrate that furniture profits have been on the low side, while the total profits of more developed states such as New York and California have been on the high side."),
           h2("Takeway 2"), 
           p("For furniture and office supplies, as well as technology products, the profits of home office facilities and technology products vary by region, and the profit level varies by region. However, office and technology products are more profitable in aggregate. Simultaneously, according to the box plot analysis. The distribution of profit data for furniture is more concentrated, whereas the distribution of profit data for technology products is more dispersed."),
           h2("Takeway 3"),
           p("The sales volume of furniture, office products, and technology products varies by region and mode of shipment. After conducting research, it was discovered that for furniture products, regardless of the mode of shipment, the sales volume of chairs was always the highest. Cell phone sales have been the highest of any technology product. When it comes to office products, storage sales are always the highest. We discovered that while ship mode has an effect on sales across categories, the best-selling products typically remain the same."),
           ),
  tabPanel("Report",
           h2("Code name"),
           p("MarketData"),
           h2("Project title"),
           p("MarketData"),
           h2("Authors"),
           p("Jeff Ngaruiya jngaru@uw.edu Cherish Chen Xc78@uw.edu Hyewon Sim hyewoni@uw.edu"),
           h2("Affiliation"),
           p("INFO-201: Technical Foundations of Informatics - The Information School - University of Washington"),
           h2("Date"),
           p("Winter 2022"),
           h2("Abstract"),
           p("(1)Our primary concern is to understand which products, regions, categories and customer segments they should target or avoid. (2) We are concerned about the profit for their products and customers (3) We plan to consider the relationship between different markets and profits, and the relationship between different areas and profits/sales."),
           h2("Keywords"),
           p("1.Business 2.Market 3. Retail"),
           h2("1.0 Introduction"),
           p("As demand increases and competition heats up in the industry, a supermarket behemoth seeks your expertise in order to determine what works best for them. They're interested in learning which items, geographies, categories, and client segments to target or avoid. Thus, in terms of retail, this data may be studied from a variety of angles in order to determine both demand and volume of sales, as well as profit margins at various sales volumes."),
           h2("2.0 Design Situation"),
           p("Major concern:  A Superstore Giant is seeking knowledge in understanding what works best for them. They would like to understand which products, regions, categories and customer segments they should target or avoid."),
           p("Human values:  The human values that are connected to our topic of concern is understanding what customers want. By understanding the data we can be able to see how we could improve customer service by having an idea of what products customers tend to get more than others, therefore we can improve the customer service aspect for the superstore."),
           p("Direct stakeholder: The direct stakeholders of our topic would be the companies that manufacture the products because their product could end up being taken off shelves due to the discovery that customers don't target that specific product. The skills that are assumed is that the products fulfill how they were advertised and that they adhere to U.S retail pricing and regulations. "),
           p("Indirect stakeholders:The indirect stakeholders would be the customers if the supermarket stops selling less popular products which in turn could make customers go off to other supermarkets."),
           p("Harm and benefits: If we intervene with data and technology the potential benefits would be that we could improve a businesses  financials by exposing where they need to make financial cuts due to some products being less popular than others. We could also realize which products are deemed more necessary in different regions, that way we could better advertise products that align with customer needs. The potential harm if we intervene with data and technology could be that we expose other indirect financial aspects of the job that are affecting profits and potentially cause certain departments within the business to have financial cuts."),
           h2("3.0 Research questions"),
           h3("Question 1:"),
           p("What are the profit trends for furniture, office products, and technology products in the United States, and how do they vary by state?"),
           h3("Question 2:"),
           p("In the analysis of furniture, office products, and technology products, as well as the combined earnings of the three distinct product categories."),
           h3("Question 3:"),
           p("We examined the sales volumes of three distinct categories of home office supplies and technology supplies, as well as the total sales volumes in various locations and shipping ways."),
           h2("4.0 The Dataset"),
           p("The data was downloaded from https://www.kaggle.com/vivek468/superstore-dataset-final.We found the superstore dataset from kaggle, a website for learning new information, connecting people, as well as seeing various examples of real-world data science applications. Data provenance is specified by referring to the process of tracing and recording the origins of data and its movement between datasets. The author of this data is known, and the website provides  information about the author and his other works. The dataset has no missing data and is clean as well. Although kaggle is one of the popular sources to find free datasets around the world, it is all open source and community-maintained. Anyone can create and access their own data sets, but Kaggle is not responsible for them.  The data will need to be analyzed and critiqued properly as there are many observations and variables. The dataset consists of over 300 observations and 21 variables such as customer ID, country, segment, and ship date. The dataset was also balanced between the numerical variables and the categorical variables."),
           h2("5.0 Findings"),
           p("We evaluated the profits earned by furniture, office products, and technology products over time and constructed line graphs to illustrate the profit trends for the three distinct product categories. Additionally, we calculated the earnings of the ten most profitable states and displayed them graphically in a bar chart."),
           p("To better understand and analyze profit, we gathered data on total profit, maximum profit, minimum profit, median profit, and average profit for the three separate categories and constructed a box plot and a bar chart for total profit. Additionally, we separated the chart into several sections to help us comprehend the profit in each region based on our selection."),
           p("We compiled bar charts depicting the total number of sales and the total number of sales by category. Additionally, we generated pie charts depicting the percentage of sales for each product in each category by area to help visualize this data."),
           h2("6.0 Discussion"),
           p("As the industry's demand grows and competition heats up, large supermarkets seek your expertise to determine what works best for them. They are interested in understanding the items, geographies, categories and customer segments that need to be targeted or avoided. Thus, in retail, this data can be analyzed from a variety of angles to ascertain demand and volumes, as well as margins on various volumes. We discovered that sales volumes for home, office, and technology products vary significantly across regions and consumer groups. This is the fundamental best-selling product, which is essentially identical, and as such, it is critical for producers to understand demand and best-selling products in order to maximize profits. The companies that manufacture these products such as office supplies and furniture could use this data and the findings to advertise or develop their products. As we discovered that technology is the most popular product and that furniture is the least popular product, the companies will focus on developing the most popular products, technology."),
           h2("7.0 Conclusion."),
           p("By examining our dataset we were able to evaluate different types of data that will influence the overall progress of the supermarket business. We were able to see which products were sold the most as well as which regions had the highest profits. Being able to see which region had the highest profits is very significant because then the business can redesign its marketing strategy to target the different regions with the products that are most popular in those regions. In addition we were also able to compare different customer segments and better understand the needs of the different segments as well as how we can market better to fulfill the different needs of the different customer segments."),
           h2("Acknowledgements"),
           p("Thank you, David G Hendry. Thank you, Akshita Gundavarapu. We appreciate your helps and effort. Thank you so much."),
           h2("References. "),
           p("The data was download from https://www.kaggle.com/vivek468/superstore-dataset-final."),
           )
)
