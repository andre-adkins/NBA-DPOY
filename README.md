# Analyzing the NBA's Defensive Player of the Year Award Winners
In this project, I take a look at the defensive statistics of every player in the league. The ultimate goal is to see if the voted Defensive Player of the Year matches who SHOULD have won based on the stats. The data was retrieved from the [Official NBA Stats Website](https://www.nba.com/stats/).

## Programs Used
+ **SQL:** Used to collect, clean, join, and transform the data. <br>
+ **Tableau:** Used to create the data visualization of the results.

## Data Definitions
  + **Steals per Game:** Number of times a defensive player or team takes the ball from a player on offense, causing a turnover (averaged per game played).<br>
  + **Blocks per Game:** Number of times an offensive player attempts a shot, and the defense player tips the ball, blocking their chance to score (averaged per game played).<br>
  + **Individual Defensive Rating:** Number of points per 100 possessions that the team allows while that individual player is on the court.<br>
  + **Total Contested Shots:** Number of times a defensive player or team closes out and raises a hand to contest a shot prior to its release.<br>
  + **Defended Field Goal Percentage:** The opponent's field goal percentage on shots when the player is defending the shot.<br>
  + **Defensive Win Shares:** Estimate of how many wins a player contributes to their team through their defensive abilities<br>
  + **Individual Wins:** Number of team wins in which the player participated in.<be>
  + **DPOY Rating:** A rating calculated using the sum of the Z-scores of each player's defensive statistics. A negative DPOY Rating denotes a bad defender, and the higher the DPOY Rating, the better the defender.

## Skills Used
- DataFrame creation
- Data Cleaning (Dealing with nulls, Changing column names)
- Data Transformation (Splitting strings into multiple columns, Creating a new quantitative variable based on preexisting variables, Creating new columns based on mathematical calculations)
- Filtering Data
- Data Visualization (Scatterplots)

# Introduction
  The National Basketball Association gives out several end-of-season awards to reward the performances of its players. The NBA MVP is awarded to the player with the best overall performance in that season. The Sixth Man of the Year Award is given to the non-starter with the best season. The Defensive Player of the Year (DPOY) has been awarded to the player with the most prominent individual defensive impact during a season since 1983. Before the 2016-17 season, media members affiliated with individual teams were given a vote. This opened the door for narratives and hometown bias (Data Deep Dives, 2017) to influence voting and led to more than a few years where many people felt that the winners of certain awards were undeserving. Nowadays, the winner of each of these awards is selected by votes cast by a global panel of sportswriters and broadcasters in an attempt to limit the amount of bias that made its way into the voting process. Even still, this group of media members does not watch every game to make a properly informed vote and are still capable of having bias within their votes. According to NBA award voters interviewed by Alex Kennedy of HoopHype (2019), teams often lobby voters by sending out promotional materials. Tony Jones of the Athletic said the Utah Jazz sent out a fake album to promote Rudy Gobert for the 2019-20 Defensive Player of the Year award. 

  The feeling of undeservedness extended to Gobert during the 2020-21 season, as he eventually won the award. Many fans and media members felt that Gobert needed to do more to warrant winning the award. Some people put a much bigger emphasis on blocks and steals than they do other important defensive statistics, such as defensive field goal percentage or defensive win shares. The lack of a consistent criterion for the awards further opens up each award to interpretation. 

  Eliminating the need for voters by using data to determine the awards’ winners would make fans trust the validity of the awards themselves. Also, some players have contract clauses to receive performance bonuses for making All-NBA teams and winning end-of-season awards (Freedman, 2019). This past season Boston Celtics forward Jayson Tatum missed out on a $33 million bonus by not making an All-NBA team. Looking at the data from the season, Tatum should have easily made one of the three All-NBA teams. Players would feel better about being “snubbed” and missing out on money if the data accurately reflected the winners. The NBA has embraced using more data to influence team and personnel decisions but would benefit by using available data to ensure the accuracy of end-of-season award winners.

# Research and Analysis
  To complete this analysis, defensive statistics from every player in the NBA during the 2016-17, 2017-18, 2018-19, 2019-20, and 2020-21 seasons were collected. The statistics collected were steals per game, blocks per game, individual defensive rating, total contested shots, defensive field goal percentage, defensive win shares, and individual wins. Defense is about stopping the opponent from scoring, and these statistics (except individual wins) encompass a player's overall defensive ability. Each player's minutes per game and games played were collected to filter the data. Lastly, each year's Defensive Player of the Year voting results were also recorded.

  The data was normalized using z-scores for each defensive statistic. Defensive field goal percentage and defensive rating are both statistics in which the lower the number, the better the player is in that category. For these two categories, the additive inverse of their z-score was recorded to calculate each player's DPOY Rating. Thus, a player with a calculated z-score of -1.75 in defensive rating had a score of 1.75 recorded for the rating. A player's DPOY Rating is a sum of the z-scores for each defensive statistic. A higher DPOY Rating indicates a player with a more remarkable defensive ability, while a lower (or negative) DPOY Rating indicates poor defensive ability.

<div class='tableauPlaceholder' id='viz1718357600349' style='position: relative'><noscript><a href='#'><img alt='NBA Defensive Player of the Year Ratings (2019-20 Season) ' src='https:&#47;&#47;public.tableau.com&#47;static&#47;images&#47;NB&#47;NBADefensivePlayeroftheYearRatings&#47;Sheet1&#47;1_rss.png' style='border: none' /></a></noscript><object class='tableauViz'  style='display:none;'><param name='host_url' value='https%3A%2F%2Fpublic.tableau.com%2F' /> <param name='embed_code_version' value='3' /> <param name='site_root' value='' /><param name='name' value='NBADefensivePlayeroftheYearRatings&#47;Sheet1' /><param name='tabs' value='no' /><param name='toolbar' value='yes' /><param name='static_image' value='https:&#47;&#47;public.tableau.com&#47;static&#47;images&#47;NB&#47;NBADefensivePlayeroftheYearRatings&#47;Sheet1&#47;1.png' /> <param name='animate_transition' value='yes' /><param name='display_static_image' value='yes' /><param name='display_spinner' value='yes' /><param name='display_overlay' value='yes' /><param name='display_count' value='yes' /><param name='language' value='en-US' /></object></div>                <script type='text/javascript'>                    var divElement = document.getElementById('viz1718357600349');                    var vizElement = divElement.getElementsByTagName('object')[0];                    vizElement.style.width='100%';vizElement.style.height=(divElement.offsetWidth*0.75)+'px';                    var scriptElement = document.createElement('script');                    scriptElement.src = 'https://public.tableau.com/javascripts/api/viz_v1.js';                    vizElement.parentNode.insertBefore(scriptElement, vizElement);                </script>


  The Tableau visualization shows each player's DPOY Rating and individual wins for each season. The graphs only take into account players with a non-negative DPOY Rating. Also, only players that played in at least 60% of their team's games that season and averaged at least 20 minutes per game. Over the five years covered in this analysis, no player that has received DPOY votes has played in less than 60% of their team's games or averaged less than 20 minutes per game.
 
  The winner of the award during the 2016-17 season (see Figure A1) was Draymond Green, who led the league in DPOY rating with a 14.58. In this year, Robert Covington was the only player to receive votes with a below-average win total. Notable omissions from this year include Kevin Durant, Giannis Antetokounmpo, and Myles Turner. 
 
   The winner of the 2017-18 Defensive Player of the Year award (see Figure A2) was Rudy Gobert, who finished second in DPOY rating. Anthony Davis was first with a rating of 15.54 (which is 3.31 points above Gobert's rating this year) and also had more wins. Ben Simmons, who had a rating better than 11 players that received votes this season, was a notable omission in the voting process.

  The 2018-19 season's winner (see Figure A3) was again Rudy Gobert, as he led the league in DPOY Rating. Notable omissions from this year include Andre Drummond and Brook Lopez —whom both have higher ratings than every vote-getter outside of Gobert. This year Patrick Beverley received votes, although he had a below-average DPOY rating of 2.26.

  The winner of the award for the 2019-20 season (see Figure A4) was Giannis Antetokounmpo. This year he finished fourth in DPOY Rating. Ahead of him were Rudy Gobert, Anthony Davis, and Brook Lopez (who happens to be on his same team). One could conclude that star/name power affects the voting process since Lopez was almost four points ahead of Antetokounmpo in DPOY Rating but finished 10th in DPOY voting. Andre Drummond also received more votes than Lopez this year, albeit being on a well below-average team and having a worse DPOY Rating.

  The winner of the 2020-21 Defensive Player of the Year award (see Figure A5) was Rudy Gobert, marking his third win in these five years. He had a rating of 16.26, which was 5.76 points higher than Nerlens Noel, who had the second-highest DPOY rating that year. This year Kentavious Caldwell-Pope received DPOY votes while having a DPOY Rating of 1.92, which was 1.31 points below the league average.

  After conducting the analysis, there were a few key takeaways overall. Almost every year, a player with a below-average DPOY Rating receives votes. Players that receive a Defensive Player of the Year vote should, by definition, have above-average defense. Only three out of the five years did the award's winner have the highest DPOY Rating. 40% of the time, there is an unmerited award winner. With the effect that winning an award has on a player's contract incentives, this number is too high for players to feel comfortable with the current voting process. Only two players had received DPOY votes when their individual wins were at least one game less than the season average. The Defensive Player of the Year should be a good enough defender that it impacts their team's success during the season. Thus, a player is more likely to receive a vote if they have an above-average number of wins.

# Recommendations
  Based on the findings of the analysis, there are two recommendations for the NBA to help rectify the issues with Defensive Player of the Year voting. First, the league could choose the player with the highest DPOY rating every season as the award winner. This solution would completely eliminate the human aspect of voting, make the decision more data-based, and limit the number of discrepancies when considering the winners. However, this solution comes with costs. Although fans do not vote for end-of-season awards winners, this solution has the potential to lower fan engagement at the end of the year. Eliminating the human element from voting could turn fans against the awards process as a whole because the league would be eliminating the shock factor that comes with some of these results. Also, if players knew exactly what stats made up their DPOY Rating, there could be an influx of "stat chasing." Players could start focusing on doing whatever they can to get a higher DPOY Rating by the end of the year. This would take away from the team aspect of basketball and the focus on winning games to win a championship, as some players would be out for personal gain.

  The second recommendation combines the data-driven approach of the first with the voting system that is currently in place. The league could use the DPOY Rating calculations to filter out the top 10% of defensive players for the season (that played in at least 60% of games, averaged 20+ MPG, and had at least an average number of wins) and have the voters only vote using those names. This option refrains from eliminating the human element of the voting process but would eliminate giving votes to players with less-than-average defensive seasons.

# Communication Strategies
  For the NBA to effect change in the voting process for the Defensive Player of the Year award, the league would have to convince fans, players, and teams to agree with the changes. The league would benefit from sending out surveys to gauge interest in making this change. The NBA could partner with each team to survey fans that are actively engaged with the team -- whether that be season ticket holders or any fans that have attended multiple games during a season. Players would also have to be on board with these changes. They are the ones that are directly affected since winning this award affects a player's legacy and finances. The NBA could team with the NBPA to survey players and gauge their interest in these modifications to the voting process. Gathering this information from fans and players would let the league know whether or not it is worth putting it up for an official vote by the NBA Board of Governors before the beginning of the new season. If there is enough interest in adjusting the voting process, the Board of Governors would have the final say in the decision. If the board decides to change the DPOY voting process, the league should use memos to inform the organizations of the changes and press releases or social media to inform the public.

# Possible Extensions
  The concept discussed in this report could extend past the Defensive Player of the Year award. Using different statistics to make up the ratings, this concept could be used for the MVP, Sixth Man of the Year, Rookie of the Year, and Most Improved Player awards. It could also be expanded to the All-NBA, All-Defense, and All-Rookie teams since players also receive contract incentives for these honors. The WNBA and NBA G League could also utilize the concept for their end-of-season awards.


# Conclusion
  The NBA is a globally recognized, reputable basketball league, and it has been innovative in the rules changes made in the past. Modifying the voting process for Defensive of the Year would be another innovative rule change that would enhance the league's credibility. With this award's recipient currently being entirely in the hands of sportswriters and broadcasters, an inherent bias arises and mistakes are made. A change to a more data-driven voting process would limit this bias and give more reliability to the results. There will be less inaccuracy in the award voting results each year, and players can have confidence that biased voters will not impact their incentives. 

 

# References
Basketball Statistics & History of Every Team & NBA and WNBA Players. (n.d.). Basketball-Reference.com. https://www.basketball-reference.com/

Chen, C., & Chen, M. (2020). Data Mining Computing of Predicting NBA 2019–2020 Regular Season MVP Winner. 2020 International Conference on Advances in Computing and Communication Engineering (ICACCE). https://doi.org/10.1109/icacce49060.2020.9155038/

Freedman, D. (2019, April). NBA Compensation Overview. CBA Breakdown. https://cbabreakdown.com/compensation/

Kennedy, A. (2019, April 16). Behind the scenes with NBA award voters: “Fear of social-media reprisal is real.” HoopsHype. https://hoopshype.com/2019/04/16/behind-the-scenes-with-nba-award-voters-fear-of-social-media-reprisal-is-real/

NBA Awards Voting: Hometown Bias. (2017, August 29). Data Deep Dives. https://datadeepdives.wordpress.com/2017/08/28/nba_awards_homers/

NBA Defensive Player of the Year Award Winners. (2022, July 20). NBA.com. https://www.nba.com/news/history-defensive-player-of-the-year-winners/

Official NBA Stats | Stats | NBA.com. (n.d.). https://www.nba.com/stats
