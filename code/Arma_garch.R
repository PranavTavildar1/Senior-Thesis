library(rugarch)
library(readr)

returns <- read.csv("/Users/pranavtavildar/Desktop/Senior-Thesis/data/returns.csv") # nolint
returns_ts <- ts(returns[, 1], frequency = 252)
arma_model <- arima(returns_ts, order = c(1, 0, 1))

garch_spec <- ugarchspec(variance.model = list(model = "sGARCH", garchOrder = c(1,1)), mean.model = list(armaOrder = c(1,1)))
garch_model <- ugarchfit(garch_spec, data = returns_ts)
summary(arma_model)
residuals_garch <- residuals(garch_model)
plot(residuals_garch)

sentiment <- read.csv("/Users/pranavtavildar/Desktop/Senior-Thesis/data/sentiment_scored_chevron.csv")

# Merge the data frames by date
data <- merge(returns, sentiment, by = "Date")

# Create the ARMA-GARCH model
spec <- ugarchspec(variance.model = list(model = "sGARCH", garchOrder = c(1, 1)),
                   mean.model = list(armaOrder = c(1, 1), include.mean = TRUE),
                   distribution.model = "norm")

fit <- ugarchfit(spec, data[, 2:3])

# Print the summary of the estimated model
summary(fit)