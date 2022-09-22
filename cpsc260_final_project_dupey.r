#1) Scraping conference stats from Wiki
nba.page<-"https://en.wikipedia.org/wiki/2018%E2%80%9319_NBA_season#Statistics"
east.stats<-nba.page %>%
  read_html() %>%
  html_nodes(xpath='//*[@id="mw-content-text"]/div[1]/div[5]/table/tbody/tr/td[1]') %>%
  html_table()
east.stats
View(east.stats)
class(east.stats)
east.stats.df <- as.data.frame(east.stats)
class(east.stats.df)
View(east.stats.df)
east.stats.df.m <- east.stats.df %>%
  mutate(Conference="Eastern")
View(east.stats.df.m)
east.stats.df.m <- east.stats.df.m %>% 
  select(`Conf Rk` = Eastern.Conference,
         `Team` = Eastern.Conference.1,
         `W` = Eastern.Conference.2,
         `L` = Eastern.Conference.3,
         `PCT` = Eastern.Conference.4,
         `GB` = Eastern.Conference.5,
         `GP` = Eastern.Conference.6,
         Conference)
east.stats.df.m<-east.stats.df.m[-c(1,10),]
View(east.stats.df.m)

west.stats<-nba.page %>%
  read_html() %>%
  html_nodes(xpath='//*//*[@id="mw-content-text"]/div[1]/div[5]/table/tbody/tr/td[2]/table') %>%
  html_table()
west.stats
west.stats.df <- as.data.frame(west.stats)
class(west.stats.df)
View(west.stats.df)
west.stats.df.m <- west.stats.df %>%
  mutate(Conference="Western")
View(west.stats.df.m)
west.stats.df.m <- west.stats.df.m %>% 
  select(`Conf Rk` = Western.Conference,
         `Team` = Western.Conference.1,
         `W` = Western.Conference.2,
         `L` = Western.Conference.3,
         `PCT` = Western.Conference.4,
         `GB` = Western.Conference.5,
         `GP` = Western.Conference.6,
         Conference)
View(west.stats.df.m)     
west.stats.df.m<-west.stats.df.m[-c(1,10),]
View(west.stats.df.m)

team.stats.2018.2019 <- rbind(west.stats.df.m, east.stats.df.m)
conf.stats<-team.stats.2018.2019
view(conf.stats)
class(conf.stats)
conf.stats[1,2]<-"Golden State Warriors"
conf.stats[2,2]<-"Denver Nuggets"
conf.stats[3,2]<-"Portland Trail Blazers"
conf.stats[4,2]<-"Houston Rockets"
conf.stats[5,2]<-"Utah Jazz"
conf.stats[6,2]<-"Oklahoma City Thunder"
conf.stats[7,2]<-"San Antonio Spurs"
conf.stats[8,2]<-"Los Angeles Clippers"
conf.stats[16,2]<-"Milwaukee Bucks"
conf.stats[17,2]<-"Torronto Raptors"
conf.stats[18,2]<-"Philadelphia 76ers"
conf.stats[19,2]<-"Boston Celtics"
conf.stats[20,2]<-"Indiana Pacers"
conf.stats[21,2]<-"Brooklyn Nets"
conf.stats[22,2]<-"Orlando Magic"
conf.stats[23,2]<-"Detroit Pistons"
view(conf.stats)

str(conf.stats)
View(conf.stats)
conf.stats$`Conf Rk` <- as.numeric((conf.stats$`Conf Rk`))
conf.stats$W <- as.numeric((conf.stats$W))
conf.stats$L <- as.numeric((conf.stats$L))
conf.stats$PCT <- as.numeric((conf.stats$PCT))
conf.stats[is.na(conf.stats)] <- 0
conf.stats$GB <- as.numeric((conf.stats$GB))
conf.stats$GP <- as.numeric((conf.stats$GP))
conf.stats$Conference <- as.factor((conf.stats$Conference))
conf.stats$Team <- as.factor((conf.stats$Team))
str(conf.stats)
View(conf.stats)

conf.stats.2



#2) Scraping website number 2 for data

nba.page.2<-"https://www.basketball-reference.com/leagues/NBA_2019.html"
total.stats<-nba.page.2 %>%
  read_html() %>%
  html_nodes(xpath='//*[@id="totals-team"]') %>%
  html_table()
total.stats
class(total.stats)
total.stats <- as.data.frame(total.stats)
View(total.stats)
total.stats<-total.stats[-31,]
total.stats <- total.stats %>% 
  select(`League Rk` = Rk,
         Team, G, MP, FG, FGA, FG., X3P, X3PA, X3P., X2P, X2PA, X2P.,
         FT, FTA, FT., ORB, DRB, TRB, AST, STL, BLK, TOV, PF, PTS)
View(total.stats)
total.stats[1,2]<-"Milwaukee Bucks"
total.stats[2,2]<-"Golden State Warriors"
total.stats[4,2]<-"Philadelphia 76ers"
total.stats[5,2]<-"Los Angeles Clippers"
total.stats[6,2]<-"Portland Trail Blazers"
total.stats[7,2]<-"Oklahoma City Thunder"
total.stats[8,2]<-"Torronto Raptors"
total.stats[11,2]<-"Houston Rockets"
total.stats[14,2]<-"Boston Celtics"
total.stats[15,2]<-"Brooklyn Nets"
total.stats[17,2]<-"Utah Jazz"
total.stats[18,2]<-"San Antonio Spurs"
total.stats[20,2]<-"Denver Nuggets"
total.stats[22,2]<-"Indiana Pacers"
total.stats[24,2]<-"Orlando Magic"
total.stats[25,2]<-"Detroit Pistons"


total.stats$GP <- as.numeric((total.stats$GP))
total.stats$Team <- as.factor((total.stats$Team))
str(total.stats)
str(conf.stats)
view(conf.stats)
view(total.stats)
total.stats

#3) Now joining these two dataframes

NBA.stats <- total.stats %>% full_join(conf.stats, by="Team")
view(NBA.stats)

which(is.na(NBA.stats))

NBA.stats<-NBA.stats[,-c(3,31)]
colnames(NBA.stats)[1] <- "league.rk"
colnames(NBA.stats)[25] <- "conf.rk"
View(NBA.stats)
nrow(NBA.stats)
#4) Creating visualizations to answer my questions!

#Is there a relationship between league rank and assists?

ggplot(NBA.stats, aes(x=AST, y=league.rk, color=Team)) +
  geom_point(size=2)
# No there is not. Is there a relationship between total
# points scored and assists?
ggplot(NBA.stats, aes(x=AST, y=PTS, color=Team)) +
  geom_point(size=2)
# Kind of. Generaly, more assists = more points scored.
# But there are a lot of outliers as well. 
# Another question: If a team has more turnovers, 
# do they score fewer points? 
ggplot(NBA.stats, aes(x=PTS, y=TOV, color=Team)) +
  geom_point(size=2)
# Generally not seeing a relationship between
# turnovers and points scored.

# Do the teams that have the lowest number of PF and highest number
# of FGA have a higher number of wins / lower number of losses?

#I will start by only selecting the stuff I need.
NBA.stats.subset<- NBA.stats%>%
  select(Team, PF, FGA, W, L)
View(NBA.stats.subset)

# Now to view a histogram of the PF data

hist(NBA.stats.subset$PF)                   

# I will say that low PF is < 1600


low.pf <- subset(NBA.stats.subset, PF < 1600)
View(low.pf)

# Now to look at high number of FGA

hist(NBA.stats.subset$FGA)

#I will say that a high FGA is > 7500

high.fga <- subset(NBA.stats.subset, FGA > 7500)
View(high.fga)

hfga.lpf <- rbind(high.fga,low.pf)
View(hfga.lpf)
#Now to find averages of the wins and losses of these teams
mean(hfga.lpf$W)
range(hfga.lpf$W)
hist(hfga.lpf$W)
#Average wins of these teams are 40.875 with a range of 29-49. 3 of the
#teams had wins between 45-50.
mean(hfga.lpf$L)
range(hfga.lpf$L)
hist(hfga.lpf$L)
#Average losses of these teams is 41.125 with a range of 33-53. 3 of these teams
#did have losses under 35.
median(NBA.stats$W)
range(NBA.stats$W)

#Average wins in the entire dataset is 41 with a range of 17-60
median(NBA.stats$L)
range(NBA.stats$L)
#Average losses in the entire dataset is 41 with a range of 22-65
#Not seeing a huge correlation. Spurs and Thunder seem to have a higher
#number of wins and a lower number of losses while having above
#average FGAs and below average PFs. There could be a connection here,
#but more than likely there is a lot more to that story. 

# Do teams who have a higher overall performance (pct) have more or
# fewer performance fouls?

ggplot(NBA.stats, aes(x=PF, y=PCT, color=Team)) +
  geom_point(size=2)
