ALTER TABLE `DPOY`.`defensive_dashboard` 
CHANGE COLUMN `web-scraper-start-url` `SEASON` TEXT NULL DEFAULT NULL ,
CHANGE COLUMN `DFGA` `DFGA` INT NULL DEFAULT 0 ,
CHANGE COLUMN `DFGM` `DFGM` INT NULL DEFAULT 0,
CHANGE COLUMN `DFG_PCT` `DFG_PCT` DOUBLE NULL DEFAULT 0;

ALTER TABLE `DPOY`.`general_defense` 
CHANGE COLUMN `web-scraper-start-url` `SEASON` TEXT NULL DEFAULT NULL ,
CHANGE COLUMN `Player` `PLAYER` TEXT NULL DEFAULT NULL ,
CHANGE COLUMN `MIN` `MINUTES` INT NULL DEFAULT NULL,
CHANGE COLUMN `STL_PCT` `PCT_OF_TEAM_STL` DOUBLE NULL DEFAULT NULL ;

ALTER TABLE `DPOY`.`hustle` 
CHANGE COLUMN `web-scraper-start-url` `SEASON` TEXT NULL DEFAULT NULL ,
CHANGE COLUMN `Player` `PLAYER` TEXT NULL DEFAULT NULL ,
CHANGE COLUMN `Team` `TEAM` TEXT NULL DEFAULT NULL ,
CHANGE COLUMN `Age` `AGE` INT NULL DEFAULT NULL ,
CHANGE COLUMN `Min` `MINUTES` INT NULL DEFAULT NULL ,
CHANGE COLUMN `Deflections` `DEFLECTIONS` INT NULL DEFAULT NULL ,
CHANGE COLUMN `DEF_Loose_Balls_Recovered` `DEF_LOOSE_BALLS_RECOVERED` INT NULL DEFAULT NULL ,
CHANGE COLUMN `Contested_2PT_Shots` `CONTESTED_2PT_SHOTS` INT NULL DEFAULT NULL ,
CHANGE COLUMN `Contested_3PT_Shots` `CONTESTED_3PT_SHOTS` INT NULL DEFAULT NULL ,
CHANGE COLUMN `Contested_Shots` `CONTESTED_SHOTS` INT NULL DEFAULT NULL ;

UPDATE `DPOY`.`defensive_dashboard`
SET `SEASON` = SUBSTRING(`defensive_dashboard`.`SEASON`,104, 4), `POSITION` = SUBSTRING(`defensive_dashboard`.`POSITION`,1,1);

ALTER TABLE `DPOY`.`defensive_dashboard` 
CHANGE COLUMN `SEASON` `SEASON` INT UNSIGNED NULL DEFAULT NULL ;

UPDATE `DPOY`.`general_defense`
SET `SEASON` = SUBSTRING(`general_defense`.`SEASON`,91, 4);

ALTER TABLE `DPOY`.`general_defense`
CHANGE COLUMN `SEASON` `SEASON` INT UNSIGNED NULL DEFAULT NULL ;

UPDATE `DPOY`.`hustle`
SET `SEASON` = SUBSTRING(`hustle`.`SEASON`,90, 4);

ALTER TABLE `DPOY`.`hustle`
CHANGE COLUMN `SEASON` `SEASON` INT UNSIGNED NULL DEFAULT NULL ;

CREATE TABLE nba_defense_2015_2023 AS
 (SELECT 
	`hustle`.`SEASON`,
    `hustle`.`PLAYER`,
    `hustle`.`TEAM`,
    `hustle`.`AGE`,
    `defensive_dashboard`.`POSITION`,
    `hustle`.`GAMES_PLAYED`,
	`general_defense`.`WINS`,
    `general_defense`.`LOSSES`,
    `general_defense`.`MINUTES`,
	ROUND(`general_defense`.`MINUTES`/`general_defense`.`GAMES_PLAYED`, 2) AS `MIN_PER_GAME`,
    `defensive_dashboard`.`DFGM`,
    ROUND(`defensive_dashboard`.`DFGM`/`defensive_dashboard`.`GAMES_PLAYED`, 2) AS `DFGM_PER_GAME`,
    `defensive_dashboard`.`DFGA`,
    ROUND(`defensive_dashboard`.`DFGA`/`defensive_dashboard`.`GAMES_PLAYED`, 2) AS `DFGA_PER_GAME`,
    `defensive_dashboard`.`DFG_PCT`,
    `general_defense`.`DREB`,
    ROUND(`general_defense`.`DREB`/`general_defense`.`GAMES_PLAYED`, 2) AS `DREB_PER_GAME`,
	ROUND((`general_defense`.`DREB` *100)/(SUM(`general_defense`.`DREB`) OVER(PARTITION BY `general_defense`.`SEASON`, `general_defense`.`TEAM`)), 2) AS PCT_OF_TEAM_DREB,
    `general_defense`.`STL`,
	ROUND(`general_defense`.`STL`/`general_defense`.`GAMES_PLAYED`, 2) AS `STL_PER_GAME`,
	ROUND((`general_defense`.`STL` *100)/(SUM(`general_defense`.`STL`) OVER(PARTITION BY `general_defense`.`SEASON`, `general_defense`.`TEAM`)), 2) AS PCT_OF_TEAM_STL,
    `general_defense`.`BLK`,
	ROUND(`general_defense`.`BLK`/`general_defense`.`GAMES_PLAYED`, 2) AS `BLK_PER_GAME`,
	ROUND((`general_defense`.`BLK` *100)/(SUM(`general_defense`.`BLK`) OVER(PARTITION BY `general_defense`.`SEASON`, `general_defense`.`TEAM`)), 2) AS PCT_OF_TEAM_BLK,
    `hustle`.`DEFLECTIONS`,
    `hustle`.`DEF_LOOSE_BALLS_RECOVERED`,
    `hustle`.`CONTESTED_2PT_SHOTS`,
    `hustle`.`CONTESTED_3PT_SHOTS`,
    `hustle`.`CONTESTED_SHOTS`,
    `general_defense`.`DEF_WS`,
    `general_defense`.`DEF_RTG`
FROM `DPOY`.`hustle`
LEFT JOIN `general_defense` ON `hustle`.`SEASON` = `general_defense`.`SEASON` AND `hustle`.`PLAYER` = `general_defense`.`PLAYER`
LEFT JOIN `defensive_dashboard` ON `defensive_dashboard`.`SEASON` = `general_defense`.`SEASON` AND `defensive_dashboard`.`PLAYER` = `general_defense`.`PLAYER`
ORDER BY `SEASON` ASC, `TEAM` ASC, `MIN_PER_GAME` DESC
);

CREATE TABLE `z_scores` AS
(
SELECT
	`SEASON`,
	`PLAYER`,
    `TEAM`,
    `AGE`,
    `POSITION`,
    `GAMES_PLAYED`,
	`WINS`,
    `MIN_PER_GAME`,
	ROUND((-(`DFG_PCT` - AVG(`DFG_PCT`) OVER(PARTITION BY `SEASON`))/(STDDEV(`DFG_PCT`)  OVER(PARTITION BY `SEASON`))), 2) AS Z_DFG_PCT,
	ROUND(((`STL_PER_GAME` - AVG(`STL_PER_GAME`) OVER(PARTITION BY `SEASON`))/(STDDEV(`STL_PER_GAME`)  OVER(PARTITION BY `SEASON`))), 2) AS Z_STL_PER_GAME,
	ROUND(((`BLK_PER_GAME` - AVG(`BLK_PER_GAME`) OVER(PARTITION BY `SEASON`))/(STDDEV(`BLK_PER_GAME`)  OVER(PARTITION BY `SEASON`))), 2) AS Z_BLK_PER_GAME,
	ROUND(((`CONTESTED_SHOTS` - AVG(`CONTESTED_SHOTS`) OVER(PARTITION BY `SEASON`))/(STDDEV(`CONTESTED_SHOTS`)  OVER(PARTITION BY `SEASON`))), 2) AS Z_CONTESTED_SHOTS,
	ROUND(((`DEF_WS` - AVG(`DEF_WS`) OVER(PARTITION BY `SEASON`))/(STDDEV(`DEF_WS`)  OVER(PARTITION BY `SEASON`))), 2) AS Z_DEF_WS,
	ROUND((-(`DEF_RTG` - AVG(`DEF_RTG`) OVER(PARTITION BY `SEASON`))/(STDDEV(`DEF_RTG`)  OVER(PARTITION BY `SEASON`))), 2) AS Z_DEF_RTG
FROM `nba_defense_2015_2023`
);

ALTER TABLE `DPOY`.`z_scores`
ADD COLUMN `DPOY_SCORE` DOUBLE AS (ROUND((Z_DFG_PCT + Z_STL_PER_GAME + Z_BLK_PER_GAME + Z_CONTESTED_SHOTS + Z_DEF_WS + Z_DEF_RTG), 2));

SELECT 
`nba_defense_2015_2023`.`SEASON`, 
`nba_defense_2015_2023`.`PLAYER`, 
`nba_defense_2015_2023`.`TEAM`,
`nba_defense_2015_2023`.`AGE`, 
`nba_defense_2015_2023`.`POSITION`, 
`nba_defense_2015_2023`.`GAMES_PLAYED`, 
CASE WHEN `nba_defense_2015_2023`.`SEASON` = 2020 AND `nba_defense_2015_2023`.`GAMES_PLAYED` > 43 THEN 'YES'
			WHEN `nba_defense_2015_2023`.`SEASON` = 2019 AND `nba_defense_2015_2023`.`GAMES_PLAYED` >= 30 THEN 'YES'
            WHEN  `nba_defense_2015_2023`.`SEASON` > 2020 < 2019 AND `nba_defense_2015_2023`.`GAMES_PLAYED` > 49  THEN 'YES'
            ELSE 'NO' END AS `GP_THRESHOLD`,
`nba_defense_2015_2023`.`WINS`, 
`nba_defense_2015_2023`.`LOSSES`, 
`nba_defense_2015_2023`.`MIN_PER_GAME`, 
`nba_defense_2015_2023`.`DFG_PCT`,
`z_scores`.`Z_DFG_PCT`, 
`nba_defense_2015_2023`.`STL_PER_GAME`, 
`nba_defense_2015_2023`.`PCT_OF_TEAM_STL`,
`z_scores`.`Z_STL_PER_GAME`,
`nba_defense_2015_2023`.`BLK_PER_GAME`, 
`nba_defense_2015_2023`.`PCT_OF_TEAM_BLK`, 
`z_scores`.`Z_BLK_PER_GAME`,
`nba_defense_2015_2023`.`DEFLECTIONS`, 
`nba_defense_2015_2023`.`DEF_LOOSE_BALLS_RECOVERED`, 
`nba_defense_2015_2023`.`CONTESTED_SHOTS`, 
`z_scores`.`Z_CONTESTED_SHOTS`,
`nba_defense_2015_2023`.`DEF_WS`, 
`z_scores`.`Z_DEF_WS`,
`nba_defense_2015_2023`.`DEF_RTG`,
`z_scores`.`Z_DEF_RTG`, 
`z_scores`.`DPOY_SCORE`,
CASE WHEN `dpoy_votes`.`DPOY_VOTE_GETTER` = 'YES' THEN 'YES'
	ELSE 'NO' END AS DPOY_VOTE, 
CASE WHEN `dpoy_votes`.`DPOY_WINNER` = 'YES' THEN 'YES'
	ELSE 'NO' END AS DPOY_WINNER
FROM `nba_defense_2015_2023`
JOIN `z_scores` ON `nba_defense_2015_2023`.`SEASON` = `z_scores`.`SEASON` AND `nba_defense_2015_2023`.`PLAYER` = `z_scores`.`PLAYER`
LEFT JOIN `DPOY`.`dpoy_votes` ON `dpoy_votes`.`SEASON` = `z_scores`.`SEASON` AND `dpoy_votes`.`PLAYER` = `z_scores`.`PLAYER`
WHERE 	`z_scores`.`DPOY_SCORE` IS NOT NULL AND `nba_defense_2015_2023`.`MIN_PER_GAME` > 20 AND  
		CASE WHEN `nba_defense_2015_2023`.`SEASON` = 2020 THEN `nba_defense_2015_2023`.`GAMES_PLAYED` > 43
			WHEN `nba_defense_2015_2023`.`SEASON` = 2019 THEN `nba_defense_2015_2023`.`GAMES_PLAYED` >= 30
            ELSE `nba_defense_2015_2023`.`GAMES_PLAYED` > 49 END
ORDER BY `nba_defense_2015_2023`.`SEASON` ASC , `z_scores`.`DPOY_SCORE` DESC;