# Install and load the necessary packages

#install.packages("rvest")
#install.packages("tidyverse")
#install.packages("progress")
#install.packages("tidyr")
library(progress)
library(rvest)
library(tidyverse)
library(tidyr)


# Use the read_html() function from the rvest package to read the HTML content of the webpage.
#url <- "https://kinogo.film/page/2/"


# Read the HTML content of the webpage

#page <- read_html(url)

# Use CSS selectors to extract the data 


#1 movies



headers <- c(
  "User-Agent" = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36")

movies1 <- data.frame('name' = character(0),
                      'link' = character(0),
                      'cast' = character(0),
                      'short'=character(0),
                      'votes'=character(0),
                      'views' =character(0),
                      'year' = character(0),
                      'year' = character(0),
                      'excerpt' = character(0),
                      'genre' = character(0),
                      'home' = character(0),
                      'KP'= character(0),
                      stringsAsFactors = FALSE)

N <- 2725
pb <- progress_bar$new(total = N)

for (i in 1:N) {
  link = 'https://kinogo.film/page/'
  download.file(paste0(link, i), destfile = paste0('page', i, '.html'))
  page <- read_html(paste0('page', i, '.html'))
  
  # Extract movie names and links
  name = page %>% html_nodes("h2 a") %>% html_text()
  link = page %>% html_elements(xpath = '//div[1]/div[1]/h2/a') %>% html_attr("href")
  
  #short of movie
  short = page %>% html_nodes(".sInfo")%>% html_text()
  short
  
  #short of movie
  excerpt = page %>% html_nodes("p.excerpt")%>% html_text()
  excerpt
  
  #year of movie
  year = parse_number(short)
  year
  
  #year of movie
  genre = page %>% html_elements(xpath='//div[2]/div[2]/span[3]') %>%
    html_text() 
  genre  
  
  #home of movie
  home = page %>% html_elements(xpath='//div[2]/div[2]/span[2]') %>%
    html_text() 
  home
  
  
  #votes of movie
  votes = page %>% html_elements(xpath='//div[2]/div[3]/div/span') %>%
    html_text() 
  votes
  
  #KP raiting of movie
  KP = page %>% html_elements(xpath='//div[2]/div[2]/div/span[2]') %>%
    html_text() 
  KP
  
  
  #views of movie
  views = page %>% html_nodes('div.fMetaViews.d-flex.ai-center') %>%
    html_text() 
  views  
  
  
  
  
  
  
  # Calculate max length of vectors
  max_length <- max(length(name), length(link),length(short),length(KP), length(home),length(genre), length(excerpt), length(year), length(home), length(votes), length(views))
  
  # Set the length of each vector equal to max length
  length(name) <- max_length
  length(link) <- max_length
  length(short)<- max_length                      
  length(votes) <- max_length 
  length(KP) <- max_length 
  length(views) <- max_length 
  length(year) <- max_length 
  length(home) <- max_length   
  length(excerpt) <- max_length   
  length(genre) <- max_length   
  length(home) <- max_length 
  pb$tick()
  
  movies1 = rbind(movies1, data.frame(name, year, home, genre, views, votes,KP, excerpt,link, cast, stringsAsFactors = FALSE))
  
  # Pause for a few seconds to avoid overloading the server
  Sys.sleep(3)
}

# Loop through each link in the 'link' column of 'movies1'
for (i in 1:nrow(movies1)) {
  movie_link <- movies1$link[i]
  
  # Download the movie's page
  movie_page <- read_html(movie_link)
  
  # Extract movie details (cast)
  cast <- movie_page %>% html_node("div.castInfo") %>% html_text()
  
  # Add the cast details to the 'movies1' data frame
  movies1$cast[i] <- cast
  
  # Pause for a few seconds to avoid overloading the server
  Sys.sleep(3)
}

# View the movies1 data frame
view(movies1)

# Write the data frame to a CSV file
write.csv(movies1, "movies1.csv")