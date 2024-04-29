
#Installing required packages if not already installed

packages <- c("tidyverse", "ggplot2", "gghalves", "see")
for (i in packages) {
  if (!require(i, character.only = TRUE)) install.packages(i)
}

library(tidyverse)
library(ggplot2)
library(gghalves)
library(see)

#Defining the path to the raw data file
raw_data_path <- "raw_data/raw_data.csv"

#Loading the data using the path from above
data <- read_csv(raw_data_path)

#Processing the data
processed_data <- data %>%
  #Filtering out rows with missing values
  filter(!is.na(Party2), !is.na(Party_Strength), !is.na(d1)) %>%
  #Creating a new variable 'type' based on conditions (Party2 and Party_Strength)
  mutate(
    type = case_when(
      Party2 == "Democrat" & Party_Strength == "Strong" ~ "Strong Democrat",
      Party2 == "Democrat" & Party_Strength == "Not strong" ~ "Weak Democrat",
      Party2 == "Republican" & Party_Strength == "Not strong" ~ "Weak Republican",
      Party2 == "Republican" & Party_Strength == "Strong" ~ "Strong Republican",
      #Assigning missing values to all other cases
      TRUE ~ NA_character_
    )
  ) %>%
  #Filtering out rows where 'type' has missing values
  filter(!is.na(type)) %>%
  #Converting 'type' into a factor and specifying the levels for ordering in plots and 
  #analysis
  mutate(type = factor(type, levels = c("Strong Democrat", "Weak Democrat", 
                                        "Weak Republican", "Strong Republican"))) %>%
  #Including only the columns 'type' and 'd1' in the new dataset
  select(type, d1)

This processing step effectively transforms the raw data into a structured format that is ready for in-depth analysis and accurate visualisation. The first 5 rows of the processed data are shown below.

#Setting the directory name for saving the processed data
processed_data_dir <- "processed_data"

#Creating a new directory called "processed data" if it doesn't already exist
if (!dir.exists(processed_data_dir)) {
  dir.create(processed_data_dir)
}

#Saving the processed data
write_csv(processed_data, file.path(processed_data_dir, "processed_data.csv"))

#Calculate summary statistics
stats <- processed_data %>%
  group_by(type) %>%
  summarise(
    mean = mean(d1, na.rm = TRUE),
    #Standard deviation
    sd = sd(d1, na.rm = TRUE),
    #Sample size
    n = n(),
    #Standard error
    se = sd / sqrt(n),
    #Upper confidence interval
    ci_upper = mean + 1.96 * se,
    #Lower confidence interval
    ci_lower = mean - 1.96 * se
  ) %>%
  #Ungrouping the data so that subsequent manipulations apply to the whole dataset
  ungroup()

#Defining the theme of the plot
plottheme <- 
  see::theme_lucid() +
  theme(
    plot.title = element_text(size = 22, color = "black"),
    axis.title = element_text(size = 18, color = "black"),
    axis.text.x = element_text(size = 16, color = "black"),
    axis.text.y = element_text(size = 14, color = "black"),
    #Excluding the legend
    legend.position = "none",
    panel.background = element_rect(fill = NA, color = "grey85")
  )

#Setting the color palette (used for the violins and statistics)
party_fill <- c("Strong Democrat" = "#235597", "Weak Democrat" = "#9EB9F3", "Weak Republican" = "#E79393", "Strong Republican" = "#941010")

#Creating the plot
main_plot <- ggplot(processed_data, aes(x = type, y = d1, fill = type)) +
  #Half violin plot showing the density distribution of d1
  geom_half_violin(trim = FALSE, alpha = 0.4, color = NA) +
  #Box plot showing important statistics (median, quartiles, and range of distribution)
  geom_boxplot(width = 0.15, fill = NA, color = party_fill, outlier.shape = NA, fatten = 0.5, position = position_nudge(x = 0.1)) +
  #Marking the mean discernment ability with a distinct point
  geom_point(data = stats, aes(x = type, y = mean, color = type), size = 4.5, position = position_nudge(x = 0.3)) +
  #Creating vertical lines representing the confidence intervals around the mean values
  geom_linerange(data = stats, aes(x = type, y = mean, ymin = ci_lower, ymax = ci_upper, color = type), position = position_nudge(x = 0.3), size = 1.5) +
  scale_fill_manual(values = party_fill) +
  scale_color_manual(values = party_fill) +
  plottheme +
  labs(x = "Political Affiliation", y = "Discernment Ability (d')", title = "Discernment Ability by Political Affiliation") +
  scale_y_continuous(limits = c(0, 3.7), breaks = seq(0, 3.5, by = 0.5)) +
  #Defining custom labels for each type
  scale_x_discrete(labels = c("Strong Democrat", "Weak Democrat", "Weak Republican", "Strong Republican")) 

#Printing the plot
main_plot

#Defining the directory for figures
figures_dir <- "figures"

#Checking whether the "figures" directory exists, creating it if otherwise
if (!dir.exists(figures_dir)) {
  dir.create(figures_dir)
}

#Saving the figure
ggsave(file.path(figures_dir, "main_plot.png"), main_plot, width = 9, height = 9, units = "in")