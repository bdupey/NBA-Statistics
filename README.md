Topic: Top NBA Players

Relevance: I have always struggled to “get into” sports. Memorizing player names and stats just seemed like such a big chore. My wife and a lot of my friends are really into basketball. I feel like this could be an opportunity to use my love of math to learn more about basketball! 

Initial Dataset Questions:

1 . What player had the top 5% points scored for the 2021-2022 season?
2. What countries do the top players originate from?
3. What was the field goal percentage of the players who had the top 5% points scored for the 2021-2022 season?
4. Is there a relationship between field goal percentage and total points scored?
5. Is there a relationship between a players height and their total rebounds?
6. Is there a relationship between player age total points scored?
7. Is there a relationship between a players age and how many minutes the played in the 21-22 season?

Webpage #1 Description and Scraped Data:

https://en.wikipedia.org/wiki/2018%E2%80%9319_NBA_season#Statistics

There were two tables that I scraped from this wiki page for the 2018-2019 season of the NBA. Each of these tables represented the top teams in the Eastern and Western conferences of the NBA for the 2018-2019 season. These tables had a total of 8 variables, including a variable that I added to indicate which conference the table represented.

First I loaded the Eastern Conference table into R. The table loaded into R as a list, so I converted it into a dataframe. This table represented the top 15 teams in the Eastern Conference of the NBA, but there was no variable indicating which conference the teams belonged to. I added a column indicating that all of these teams were from the Eastern Conference. The column names were loaded into R incorrectly. The first row of the data was showing the actual column names. So I changed the column names and I deleted the first row and another row of empty data that loaded into R. I then repeated all of these steps on the Western Conference table. 

At this point, I had two tables that were relatively clean. I then vertically joined the two tables using the rbind() function. Upon examining the data types of each variable using the str() function, all of my data was classified as character data. I assigned all of the variables to their appropriate data types. The final problem was just a few weird characters in the team names that were carried over from Wiki. I just made some edits in the cell names to clean up the data. There were also 2 NA’s in the GB columns of the no.1 teams in each conference. GB represents how many games behind each team trails their first place rival. I replaced these NAs with 0 for each of the no.1 teams.

The result of all of this was a complete table of the top teams of the Eastern and Western Conferences of the NBA from 2018-2019. This data includes 8 variables with 30 instances. Each row represents a team. Please see my attached annotated R file and the below screenshot for a view of my final dataset.

Webpage #2 Description and Scraped Data:

https://www.basketball-reference.com/leagues/NBA_2019.html

The data I scraped from this website is very similar to the data from the first website. It contains statistical information about the top teams of the NBA in the 2018-2019 season. The data I pulled from this webpage was not organized by conference, but was instead organized all in one singular table. This made the data a little easier to clean up.

Similar process here. I loaded the website into R and pulled the table I needed. Converted it to a dataframe. Got rid of the cumulative row at the bottom (I can make my own cumulative statistics as needed, so this row is pointless for my purposes). Changed the “Rk” column name to “League Rank”. Below is a screenshot of my finished data. You can see the annotated R file for further info. 

Tidy data explanation:

I combined all my data using a full join. I wanted to make sure to keep all the data. I imagine I probably could have done a left join here, but I juts wanted to play it safe just in case there were teams from the first dataset that weren’t in the second. But all the teams were in both of the datasets. So it really didn’t matter what kind of join I did, from what I can tell.

My data is tidy, from what I can tell. The str() function shows that all my data categories look good. Using the function ‘which(is.na(NBA.stats))’ determines that there are no NA values in the dataframe that I’ve created. So from what I can see, all of my data looks correctly categorized, clean, and tidy. 

A lot of my original questions pertained to specific players. I found it difficult to search out / find any tables that I was able to scrape on players. So I’m modifying some of my questions to suit the dataset that I created. 

1. Is there a relationship between field goal percentage and total points scored?
2. Do teams who have a higher overall performance (pct) have more or less performance fouls?
3. Is there a relationship between the number of offensive rebounds and the rank of the team?
4. Do the team that make the lowest fouls and the highest field goal attempts have a higher number of wins / lower number of losses? 
5. Why were the Detroit Pistons rated 8th in the Eastern Conference but only 25th in the league?  

Is there a relationship between field goal percentage and total points scored?
I created a basic scatterplot to answer this question. It looks like there is a positive relationship between these two datapoints. Generally, as the number of Field Goals increases, so does the number of total points scored. 
ggplot(NBA.stats, aes(x=FG., y=PTS)) +
  geom_point(size=2)

