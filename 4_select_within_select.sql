--1.List each country name where the population is larger than that of 'Russia'.
SELECT name FROM world
  WHERE population >
     (SELECT population FROM world
      WHERE name='Russia')
      
--2.Show the countries in Europe with a per capita GDP greater than 'United Kingdom'.
select name from world 
where continent='Europe' and gdp/population>(select gdp/population from world 
                                                        where name='United Kingdom')
                                                        
                                                       
--3.List the name and continent of countries in the continents containing either Argentina or Australia. Order by name of the country.
select name,continent from world
where continent in (select continent from world 
                                     where name in('Australia','Argentina'))
order by name

--4.Which country has a population that is more than Canada but less than Poland? Show the name and the population.
select name,population from world 
where population> (select population from world where name='canada' ) and 
                                        population<(select population from world where name='poland' )
                                        
--5.Germany (population 80 million) has the largest population of the countries in Europe. Austria (population 8.5 million) has 11% of the population of Germany.
--Show the name and the population of each country in Europe. Show the population as a percentage of the population of Germany.
--The format should be Name, Percentage for example:
SELECT name,
           concat(round(100*population/(SELECT population FROM world
                                       WHERE name='Germany')),'%')
FROM world
WHERE continent='Europe'
--6.Which countries have a GDP greater than every country in Europe? [Give the name only.] (Some countries may have NULL gdp values)
select name from world 
where gdp >(select max(gdp) from world where continent ='Europe')

--7.Find the largest country (by area) in each continent, show the continent, the name and the area:
SELECT continent, name, area FROM world x
  WHERE area >= ALL
    (SELECT area FROM world y
        WHERE y.continent=x.continent
          AND area>0)
          
--8.List each continent and the name of the country that comes first alphabetically.
SELECT continent, name FROM world x 
WHERE name <= ALL(SELECT name FROM world y WHERE x.continent = y.continent)
--9.Find the continents where all countries have a population <= 25000000.
    --Then find the names of the countries associated with these continents. 
     --Show name, continent and population.
 SELECT y.name, y.continent, y.population FROM world AS y
JOIN (SELECT continent,max(population) FROM world
GROUP BY continent
HAVING max(population) <= 25000000) AS x
ON y.continent = x.continent

--10.Some countries have populations more than three times that of all of their neighbours (in the same continent).
--Give the countries and continents.
SELECT x.name, x.continent
FROM world AS x
WHERE x.population/3 > ALL (
  SELECT y.population
  FROM world AS y
  WHERE x.continent = y.continent
  AND x.name != y.name)
