# PSY6422_project
Data Analysis and Visualisation project.

### Purpose:

The purpose of this project is to replicate Figure 1b from a study conducted by [Dobbs et al. (2023)](https://www.nature.com/articles/s44271-023-00040-x), which investigated the association between political partisanship and the ability to accurately judge true and false news statements. Using the raw data provided by Dobbs and my own processing techniques, the aim is to recreate the exact figure as presented in their paper. By replicating their findings, I seek to assess the reproducibility and validity of the original results within my own dataset.

Full project is viewable at https://vlakex36.github.io/PSY6422_project/. 

**Reference:** Dobbs, M., DeGutis, J., Morales, J., Joseph, K., & Swire-Thompson, B. (2023). Democrats are better than Republicans at discerning true and false news but do not have better metacognitive awareness. Communications Psychology, 1(1), 46.

### Research Question:

The research question for this project is “Are Democrats better than Republicans at discerning true and false news?”. This question is answered in the visualisation and interpretation sections of the markdown document.

**This repository contains:**
+ figures
  + containing "main_plot.png", the final plot produced and the original figure.
+ raw_data
  + containing "raw_data.csv", raw data used for the analysis and processing
+ processed_data
  +  containing "processed_data.csv", data processed in the code used for visualisation
+ rmd_styles
  + containing "mycss.css", css file used to customise/style the markdown document
+ markdown230170494.rmd - RMarkdown file (code)
+ markdown230170494.html - A web page of the markdown file
+ assignment.Rproj - The R project (working directory)
+ shiny_app.r - A shiny R file (solely including code necessary for data visualisation)

## Installation Instructions
To run this project, you will need the following **software and packages**:

### Dependencies

+ **Software:** R (a programming language and environment for statistical computing and graphics)
+ **IDE:** RStudio (an integrated development environment for R), or other IDE of your liking (check that it’s compatible with R)
+ **R Packages:** ‘tidyverse’, ‘ggplot2’, ‘gghalves’, ‘see’

### Installation steps

1. Install R
   + Download and install R from the [CRAN website.](https://cran.r-project.org/)
   + Follow the installation instructions specific to your operating system.
2. Install RStudio (optional)
   + Download RStudio Desktop from the [RStudio download page.](https://posit.co/products/open-source/rstudio/)
   + Install RStudio by following the provided instructions.
3. Install Required Packages
   + Launch RStudio and create a new R script (or open the existing markdown file).
   + Copy and paste (or run) the following code into the script to check for and install the necessary packages:
     
     **packages <- c("tidyverse", "ggplot2", "gghalves", "see")**
     
     **for (i in packages) {**
     
       **if (!require(i, character.only = TRUE)) install.packages(i)**
     
     **}**
    + After pasting the above chunk of code, run the script. This code will verify if each package is installed and will install any that are missing.
4. Load packages/libraries
   + If there are no errors during loading, after running this code, then all packages have been successfully installed.
     + **library(tidyverse)**
     + **library(ggplot2)**
     + **library(gghalves)**
     + **library(see)**
       
5. Set up project environment
   + Organise your project by creating a directory structure. For example, directories for raw data, processed data, and figures can be set up in RStudio using:
     + **dir.create("raw_data")**
     + **dir.create("processed_data")**
     + **dir.create("figures")**     
   + This code can also be found in the markdown file (look for "Saving processed data" and "Saving plot" sections).
  
By following these steps, your project environment will be set up with all the necessary software and packages to run the provided R code. This setup will allow you to process the data and generate plots defined in your scripts.

## Usage
### Data Setup

The necessary data for this project is stored within the raw_data folder. This folder should contain the file ‘raw_data.csv’. Ensure that this file is properly placed in the raw_data directory within your project folder before proceeding with the code execution.

### Running the code

Here’s a step-by-step guide to execute the code:
1. Load the necessary libraries using the code mentioned above.
2. Define path to the raw data:
   + **raw_data_path <- "raw_data/raw_data.csv"**
3. Load the data:
   + **data <- read_csv(raw_data_path)**
4. Process the data
   + Process your data with necessary transformations and filtering. You can use, or manipulate the code in the "Processing" subsection of the markdown file, according to the data needed for your desired plot.
5. Save the processed data
   + Save the processed data in the ‘processed_data’ folder. Run the code in the "Saving processed data" subsection of the markdown file. The first four lines of code are used to set the desired directory and ensure that the ‘processed_data’ folder is created before saving the data.
6. Compute the necessary statistics
   + Run the code under the "Calculating Statistics" subsection of the markdown file.
   + Make changes to the code according to the statistical measures needed for your desired plot.
7. Plot theme
   + Refer to (run) the code in subsection "Plot theme" of the markdown file. You can manipulate this code to change elements of your plot, such as the size and colour of axes labels.
8. Set the colour palette
   + Set the colors you would like to use for your plot, using the variable "party_fill" found in subsection "Plot theme" of the markdown file. This variable is used later on in the function of the main plot to colour the half violins and statistics (i.e. mean and standard deviation).
9. Generate and print the plot
   + Generate the desired plot using the code in the "Plotted graph" subsection of the markdown file. Elements such as the title, labels, or type of plots can be easily edited. For example, to change the label of the x axis, find the function labs() in the code and change the text inside the double-quote marks after ‘x =’.
   + Next print the plot, simply by writing down (calling) the variable name of the plot you created. In this instance: "main_plot".
10. Save the plot
    + Save the plot in your desired folder ("figures" in this case), using the code found in the "Saving plot" subsection of the markdown file.
    +  Run the first four lines of code to set the desired directory and ensure that the folder is created before saving the plot. Run the last line of code (ggsave() function) in order to save the figure. You can change the size of the plot by changing the units, width and height in the code.

## Visualisation

![Main plot](https://github.com/vlakex36/PSY6422_project/blob/main/figures/main_plot.png?raw=true)



