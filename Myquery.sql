CREATE TABLE CovidDeaths
(
    iso_code varchar,
    continent varchar,
    location varchar,
    date varchar,
    population varchar,
    total_cases bigint,
    new_cases int,
    total_deaths int,
    new_deaths int,
    total_deaths_per_million double precision,
    new_deaths_per_million double precision,
    reproduction_rate double precision,
    icu_patients int,
    hosp_patients int,
    weekly_icu_admissions int,
    weekly_hosp_admissions int
);

CREATE TABLE CovidVaccinations
(
    iso_code varchar,
    continent varchar,
    location varchar,
    date varchar,
    total_tests bigint,
    new_tests bigint,
    total_deaths int,
    positive_rate double precision,
    tests_per_case double precision,
    reproduction_rate double precision,
    test_units varchar,
    total_vaccinations bigint,
	people_vaccinated bigint,
	people_fully_vaccinated bigint,
	total_boosters bigint,
	new_vaccinations bigint,
	stringgency_index double precision,
	population_density double precision,
	median_age double precision,
	aged_65_older double precision,
	aged_70_older double precision,
	gdp_per_capita double precision,
	extreme_poverty double precision,
	cardiovasc_death_rate double precision,
	diabetes_prevelance double precision,
	handwashing_facilities double precision,
	life_expectancy double precision,
	human_development_index double precision,
	excess_mortality_cumulative double precision,
	excess_mortality double precision
);

SELECT count(*) as No_of_Rows FROM coviddeaths;

SELECT * from coviddeaths;

--Problem statements
--1. Datewise Liklihood of dying due to covid-Totalcases vs Totaldeath in India
SELECT date, total_cases, total_deaths from "coviddeaths" where location like '%India&'
--2. Total % of deaths out of entire population in India
SELECT max(total_deaths)/avg(cast(population as integer))*100 from coviddeaths where location like '%India%'
--SELECT total_deaths, population from coviddeaths where location like '%India%'
--3. Country with highest death as a % of population
SELECT location,(max(total_deaths)/avg(cast(population as bigint))*100) as percentage from "coviddeaths" group by location order by percentage desc;
--4. % of covid positive cases in india
SELECT (max(total_cases)/avg(cast(population as bigint))*100) as percentage from "coviddeaths" where location like '%India%'
--5. Total % of covid positive cases in whole world
SELECT location, (max(total_cases)/avg(cast(population as bigint))*100) as percentage from "coviddeaths" group by location order by percentage desc;
--6. Continent wise +ve cases
SELECT location, max(total_cases) as total_case from coviddeaths where continent is null group by location order by total_case desc;
--7. Continet wise deaths
SELECT location, max(total_cases) as total_deaths from coviddeaths where continent is null group by location order by total_case desc;
--8. Daily newcases vs hospitalizatios vs icu_patients India
SELECT date, new_cases, hosp_patients, icu_patients from coviddeaths where location like '%India%';
--9.countrywise age 65>
SELECT coviddeaths.date, coviddeaths.location, covidvaccinations.aged_65_older 
FROM coviddeaths 
JOIN covidvaccinations 
ON coviddeaths.iso_code = covidvaccinations.iso_code 
AND coviddeaths.date = covidvaccinations.date;
--10 Countrywise total vaccinated persons
SELECT coviddeaths.location AS country, MAX(covidvaccinations.people_fully_vaccinated) AS Fully_vaccinated 
FROM coviddeaths 
JOIN covidvaccinations 
ON coviddeaths.iso_code = covidvaccinations.iso_code 
AND coviddeaths.date = covidvaccinations.date 
GROUP BY coviddeaths.location;
--Thank You--