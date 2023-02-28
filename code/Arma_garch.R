library(rugarch)
library(readr)
library(forecast)
library(tseries)
returns <- read.csv("/Users/pranavtavildar/Desktop/Senior-Thesis/data/returns.csv") # nolint
returns_ts <- returns[-1,"return"]
plot(returns_ts)
#increase sample size
tryCatch({
  x <- get.hist.quote(instrument = "cvx", start = "2021-01-01", end = "2022-12-31",
                      quote = "Close")
  plot(x)})
ret <- diff(log(x))
plot(ts(ret))

#package: forecast, auto.arima method to fit the best arma model
arma_model <- auto.arima(ret,  max.D = 0, max.d = 0)
arma_model
#order for arma is 1,0

#rugarch implementation
garch_spec <- ugarchspec(variance.model = list(model = "sGARCH", garchOrder = c(1,1)), mean.model = list(armaOrder = c(1,0)))
garch_model2 <- ugarchfit(garch_spec, data = ret)
summary(garch_model2)
show(garch_model2)

#regular garch implementation
garch_model <- garch(as.vector(ret[,1]))
summary(garch_model)

summary(arma_model)
residuals_garch <- residuals(garch_model)
plot(residuals_garch)

#### To do this part (sentiment score is an exogenous variable) through the following https://rdrr.io/cran/TSA/man/arimax.html
### Find the ARMA mean but if this fails look at the GARCH portion using the following https://www.rdocumentation.org/packages/garchx/versions/1.3/topics/garchx
