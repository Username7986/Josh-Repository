
install.packages("forecast")
install.packages("linewidth")

# Load necessary libraries
library(ggplot2)
library(forecast)
library(linewidth)

# Load the data
data <- read.csv("cleaned_2000-milers_by_decade.csv")

# Convert Decade to a time series object
data_ts <- ts(data$Milestone, start = min(data$Decade), frequency = 1)

# Plot the data
p <- ggplot(data, aes(x=Decade, y=Milestone)) +
  geom_line(color = "blue", size = 1) +
  geom_point(color = "red", size = 2) +
  ggtitle("2000-Milers by Decade") +
  xlab("Decade") +
  ylab("2000-Milers") +
  theme_minimal()

# Trend analysis
trend_fit <- lm(Milestone ~ Decade, data = data)
data$Trend <- predict(trend_fit)

# Plot the trend line
p <- p + geom_line(aes(y = Trend), color = "green", linetype = "dashed")

# Time series forecasting for the next decade
trend_fit <- auto.arima(data_ts)
forecasted <- forecast(trend_fit, h = 1)  # Forecasting for the next decade

# Adding forecast to the data frame for plotting
forecast_df <- data.frame(Decade = max(data$Decade) + 10, Milestone = forecasted$mean)
data <- rbind(data, forecast_df)

# Plot the forecasted value
p <- p + geom_point(aes(x = Decade, y = Milestone), data = forecast_df, color = "purple", size = 3)

# Print the plot
print(p)

# Print the forecast
print(forecasted)

