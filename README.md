# Web Scraping Movie Data with R

## Install and load the necessary packages


Installation and Loading Packages:

 ```
install.packages("rvest")
install.packages("tidyverse")
install.packages("progress")
install.packages("tidyr")
 ```


**Here's a summary of what the script is doing:**

The script loops to iterate through pages (N pages) on the website https://kinogo.film

It downloads the HTML content of each page, extracts information about movies *(names, links, cast, short descriptions, votes, views, year, genre, home, KP rating, excerpts)*, and stores them in vectors.

1.Data Cleaning and Structuring:

The script calculates the maximum length of the vectors and sets the lengths of all vectors to this maximum length to ensure they align correctly.

It creates a data frame (movies1) by binding the data collected in each iteration.

2.Getting additional Movie Details:

The script then includes a loop to go through each movie link in the *'link' column* of the movies1 data frame.

For each movie, it downloads the movie's page and extracts details about the *cast*, adding this information to the movies1 data frame.

3.View and Save Data:

Finally, the script views the movies1 data frame and writes it to a CSV file named *"movies1.csv"*.
