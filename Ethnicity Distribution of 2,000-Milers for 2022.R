
# Load necessary library
library(ggplot2)
library(dplyr)

# Read the CSV file
data <- read.csv("2022_2000-miler_ethnicity_distribution.csv")

# Add percentage labels to the Ethnicity column
data <- data %>%
  mutate(Ethnicity = paste(Ethnicity, paste0("(", Percentage, "%)")))

# Define colors for each ethnicity category
ethnicity_colors <- c(
  "White (84%)" = "#2ca02c",
  "No Response (12%)" = "#1f77b4",
  "Asian (2%)" = "#ff7f0c",
  "Hispanic/Latino (2%)" = "#d62728",
  "Black/African-American (1%)" = "#9467bd",
  "Native American (1%)" = "#8c564b",
  "Pacific Islander (1%)" = "#e377c2"
)

# Create a pie chart
pie_chart <- ggplot(data, aes(x="", y=Percentage, fill=Ethnicity)) +
  geom_bar(width=1, stat="identity") +
  coord_polar(theta="y") +
  labs(title="Ethnicity Distribution of 2,000-Milers for 2022", x=NULL, y=NULL) +
  scale_fill_manual(values=ethnicity_colors) +
  theme_minimal() +
  theme(axis.text.x=element_blank(), axis.ticks=element_blank())

# Display the pie chart
print(pie_chart)


