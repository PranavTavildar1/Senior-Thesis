library(rugarch)
library(readr)
library(forecast)
library(tseries)
#package: forecast, auto.arima method to fit the best arma model

returns <- read.csv("/Users/pranavtavildar/Desktop/Senior-Thesis/data/returns.csv") # nolint
tryCatch({
  x <- get.hist.quote(instrument = "cvx", start = "2021-01-01", end = "2022-12-31",
                      quote = "Close")
  plot(x)})
ret <- diff(log(x))
plot(ts(ret))
returns_ts <- returns[-1,"return"]
plot(returns_ts)
arma_model <- auto.arima(ret,  max.D = 0, max.d = 0)
arma_model
#order for arma is 1,0

#specifying model
garch_spec <- ugarchspec(variance.model = list(model = "sGARCH", garchOrder = c(1,1)), mean.model = list(armaOrder = c(1,0)))
garch_model2 <- ugarchfit(garch_spec, data = ret)

garch_model <- garch(c(ret))

summary(garch_model)
summary(garch_model2)

show(garch_model2)
#increase sample size



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