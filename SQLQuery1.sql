.Select *
From PortfolioProject..covidDeaths
Where continent is not Null
order by 3,4


--select the data that we are going to be using

Select Location,date, total_cases, new_cases, total_deaths, population
From PortfolioProject..covidDeaths
Where continent is not Null
order by 1,2

--Total case vs Total deaths
--Shows likelihood of death in Zimbabwe if you contracted Covid

Select Location,date, total_cases, total_deaths,(total_deaths/total_cases)*100 as Deathercentage
From PortfolioProject..covidDeaths
Where Location like '%Zimbabwe%'
order by 1,2

--Looking at the Total Cases vs the Populaion
--Shows what percentage of the population got Covid

Select Location,date, population, total_cases,(total_cases/population)*100 as Infectionpercentage
From PortfolioProject..covidDeaths
--Where Location like '%Zimbabwe%'
Where continent is not Null
order by 1,2

--Looking at countries with the highest infection rates compared to the Population

 Select Location, population, MAX(total_cases) as HighestInfectionCount,MAX((total_cases/population))*100 as Infectionpercentage
From PortfolioProject..covidDeaths
--Where Location like '%Zimbabwe%'
Where continent is not Null
Group by Location, population
order by Infectionpercentage desc

--Showing the country with the Highest death count per population

Select Location,  MAX(cast(total_deaths as int)) as HighestDeathCount
From PortfolioProject..covidDeaths
--Where Location like '%Zimbabwe%'
where continent is not Null
Group by Location
order by HighestDeathCount desc

--We will break things down by continent(location)
--later we are to look at deaths per income per continent

Select location,  MAX(cast(total_deaths as int)) as TotalDeathCount
From PortfolioProject..covidDeaths
--Where Location like '%Zimbabwe%'
Where continent is Null
Group by location
order by TotalDeathCount desc

--Showing continents with the Highest Death count

Select continent,  MAX(cast(total_deaths as int)) as TotalDeathCount
From PortfolioProject..covidDeaths
--Where Location like '%Zimbabwe%'
Where continent is not Null
Group by continent
order by TotalDeathCount desc
 
  
--GLOBAL NUMBERS

Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths,SUM(cast(new_deaths as int))/SUM(new_cases)*100 as DeathPercentage
From PortfolioProject..covidDeaths
--Where Location like '%Zimbabwe%'
where continent is not null
--Group By date
order by 1,2

Select date, SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths,SUM(cast(new_deaths as int))/SUM(new_cases)*100 as DeathPercentage
From PortfolioProject..covidDeaths
--Where Location like '%Zimbabwe%'
where continent is not null
Group By date
order by 1,2

Select *
From PortfolioProject..covidDeaths dea
join PortfolioProject..CovidVaccinations vac
on dea.location = vac.location 
and dea.date = vac.date


--Looking at total Populations vs Vaccinations

Select dea.continent,dea.population, dea.date, dea.location
From PortfolioProject..covidDeaths dea
Join PortfolioProject..CovidVaccinations vac
on dea.location = vac.location 
and dea.date = vac.date
where dea.continent is not null
order by 1,2,3
