# Marcell Experimental Forest S2 Bog Site Streamflow Analysis 
### Author: [Mia Forsline](https://miaforsline.github.io/)
### Project mentor: [Dr. Nina Lany](https://www.nrs.fs.fed.us/people/nina.lany)
### Project collaborators: [Jacob Burdick](https://www.nrs.fs.fed.us/people/jburdick), [Daniel 'Tyler' Roman](https://www.fs.usda.gov/research/about/people/danielroman#research-tab), & [Dr. Stephen Sebestyen](https://www.nrs.fs.fed.us/people/ssebestyen)
### Project dates: June 21 - August 19, 2022 

## Project description: 
The Marcell Experimental Forest (MEF) in northern Minnesota is operated by the USDA Forest Service and was established in 1962 to study the ecology and hydrology of peatlands. The Fellow will work with streamflow data gathered at 5-minute resolution by environmental sensors in six catchments instrumented for hydrologic monitoring within the 1100-hectare experimental forest. The Fellow will develop scripted workflows in R to organize raw data, document the transition from mechanical to electronic sensors, and optionally write Python code to display the data within a visually appealing online data dashboard. The Fellow will publish two new data packages in EDI. 

This project is part of the [Environmental Data Initiative's](https://environmentaldatainitiative.org/) [2022 Data Management Fellowship Program](https://environmentaldatainitiative.org/2022-dm-fellowship-program/). 

## Project motivation and goals: 
The overall goals of this project include: 
- Combining, cleaning, and visualizing multiple water years worth of streamflow data (specifically, stream height) from the MEF S2 bog site 
- Incorporating climate data (such as air temperature and precipitation), bogwell data (AKA peatland water table elevation), and old sensor data to cross-validate the streamflow data's accuracy 
- Publishing the cleaned streamflow data in the [EDI Data Portal](https://portal.edirepository.org/nis/home.jsp)
- Examining bogwell data from multiple years and sources to facilitate the transition from old manual stripcharts to new shaft encoders and streamline the data collection process 

Ultimately, this project aims to facilitate the transition away from older analogue data collection techniques such as paper stripcharts that must be digitized by hand towards newer data collection techniques such as shaft encoder sensors. 

## Workflow 
The project is designed for RMD files to be executed in the following order:

1. `1_water_years.Rmd`: Reads in, cleans, and visualizes stream height (ft) for each individual water year based on stripchart data
2. `2_manual_checks.Rmd`: Reads in stream height data collected during periodic manual checks and plots these checkpoints on top of the stripchart data as a way to assess the accuracy of the stripcharts 
3. `3_climate.Rmd`: Reads in and manipulates relevant climate data to compare against streamflow data 
4. `4_precip_comparisons.Rmd`: Compares streamflow data with aggregated precipitation data to assess the accuracy of the stripchart data 
5. `5_air_comparisons.Rmd`: Compares streamflow data with air temperature data to assess the accuracy of the stripchart data
6. `6_bogwell.Rmd`: Reads in bogwell (water table elevation) data from manual stripcharts and new shaft encoders 

## Viewing the Data
Each step of this workflow can be viewed online using GitHub pages: 
1. [Individual Water Years' Streamflow](https://miaforsline.github.io/water_years/)
2. [Manual Checkpoints of Streamflow](https://miaforsline.github.io/manual_checks/)
3. [Climate Data](https://miaforsline.github.io/climate/)
4. [Comparing Streamflow and Precipitation](https://miaforsline.github.io/precip_comparisons/)
5. [Comparing Streamflow and Air Temperature](https://miaforsline.github.io/air_comparisons/)
6. [Bogwell (Peatland Water Table Elevation) Data](https://miaforsline.github.io/bogwell/)

This workflow uses GitHub pages linked to my personal GitHub website to host the output of each step in the workflow. Each .Rmd file in the `s2_streamflow` GitHub repo is knit into an individual GitHub repo. Each individual GitHub repo contains an `index.html` file that is then rendered into an online GitHub page. 

## File Structure 
.Rmd files and HTML files are stored in the main directory. Each .Rmd file represents a step in the workflow and uses the following naming structure: `#_name.Rmd` 

## Data
Data used in this project are proprietary to the USDA Forest Service and stored in a private, online Box server used by the Marcell Experimental Forest team. For data access, please contact Dr. Nina Lany. 

## Tools
This project primarily uses R and RStudio. 
