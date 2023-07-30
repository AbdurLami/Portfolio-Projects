Select *
From PortfolioProject..CovidDeaths
order by 3,4


--Select *
--From PortfolioProject..CovidVaccinations
--order by 3,4


--select Data that we are going to be using

Select location, date, total_cases, new_cases, total_deaths, population
From PortfolioProject..CovidDeaths
order by 1,2


--Looking at Total Cases Vs Total Deaths
--showing the likelihood of dying is you contract Covid in your Country

Select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathsPercentage
From PortfolioProject..CovidDeaths
order by 1,2

--Looking at Total Cases Vs Population
--Showing what percentage of the population got/contracted Covid
Select location, date, total_cases, population, (total_cases/population)*100 as PercentagePopulationInfected
From PortfolioProject..CovidDeaths
order by 1,2

---Showing what percentage of the population got/contracted Covid in United State Only
Select location, date, total_cases, population, (total_cases/population)*100 as PercentagePopulationInfected
From PortfolioProject..CovidDeaths
where location like '%state%'
order by 1,2

--Showing what percentage of the population got/contracted Covid in Nigeria Only
Select location, date, total_cases, population, (total_cases/population)*100 as PercentagePopulationInfected
From PortfolioProject..CovidDeaths
where location like '%Nigeria%'
order by 5desc,1,2


--Looking at countries with highest infection rate compared to population
Select location,population, max(total_cases) as HighestInfectionCount,   Max((total_cases/population))*100 as PercentagePopulationInfected
From PortfolioProject..CovidDeaths
Group by location,population
order by PercentagePopulationInfected desc

--Showing Countries with highest Death Count per population

Select location, max(cast(total_deaths as int)) as TotalDeathCount
From PortfolioProject..CovidDeaths
Where continent is not null
Group by location
order by TotalDeathCount desc


--Let's break things down by continent
Select continent, max(cast(total_deaths as int)) as TotalDeathCount
From PortfolioProject..CovidDeaths
Where continent is not null
Group by continent
order by TotalDeathCount desc

--Global Numbers


Select date, Sum(new_cases) as TotalCases, Sum(cast(new_deaths as int)) as TotalDeath, sum(cast(new_deaths as int))/sum(new_cases)*100 as DeathPercentage
From PortfolioProject..CovidDeaths
Where continent is not null
Group by Date
order by 1,2


--Looking at CovidVaccinations

Select *
From PortfolioProject..CovidVaccinations
order by 3,4


--Looking at Total Vaccinations Vs Population
--Showing what percentage of the population vaccinated
Select location, date, total_vaccinations, population, (total_vaccinations/population)*100 as PercentagePopulationVaccinated
From PortfolioProject..CovidVaccinations
order by 1,2



--Showing what percentage of the population that has been vaccinated in United State Only
Select location, date, total_vaccinations, population, (total_vaccinations/population)*100 as PercentagePopulationVaccinatedInUS
From PortfolioProject..CovidVaccinations
where location like '%state%'
order by PercentagePopulationVaccinatedInUS Desc


--Looking at total population Vs Vaccination

Select de.continent, de.location, de.date, de.population, va.total_vaccinations, (total_vaccinations/va.population)*100 PopulatioVSVaccination
from PortfolioProject..CovidDeaths De
Join PortfolioProject..CovidVaccinations va
 on de.location= va.location and de.date= va.date
 where de.continent is not null
 order by 2,3


 --Creating views to Store data for future visualisation

 create view PercentageVaccinated 
 as
 Select location, date, total_vaccinations, population, (total_vaccinations/population)*100 as PercentagePopulationVaccinated
From PortfolioProject..CovidVaccinations
--order by 1,2
