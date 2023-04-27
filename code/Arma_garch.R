library(rugarch)
library(readr)
library(forecast)
library(tseries)
library(garchx)
library(TSA)
stock_data <- read.csv("/Users/pranavtavildar/Desktop/Senior-Thesis/data/CVX_stock_data.csv")
returns <- diff(log(stock_data$Close))
plot(ts(returns))

#package: forecast, auto.arima method to fit the best arma model
arma_model <- auto.arima(returns,  max.D = 0, max.d = 0)
arma_model
#order for arma is 0,0

#rugarch implementation

garch_spec <- ugarchspec(variance.model = list(model = "sGARCH", garchOrder = c(1,1)), mean.model = list(armaOrder = c(0,0)))
garch_model2 <- ugarchfit(garch_spec, data = returns)
summary(garch_model2)
show(garch_model2)

### t value of beta 1 proves that the p value is non signif

#regular garch implementation
garch_model <- garch(returns)
garch_model

summary(arma_model)
residuals_garch <- residuals(garch_model)
plot(residuals_garch, ylab = "Residuals as Percentage", xlab = "Time", 
     main = "GARCH Residuals Plot")

#### To do this part (sentiment score is an exogenous variable) through the following https://rdrr.io/cran/TSA/man/arimax.html
### Find the ARMA mean but if this fails look at the GARCH portion using the following https://www.rdocumentation.org/packages/garchx/versions/1.3/topics/garchx

### regular sentiment score 
#package: forecast, auto.arima method to fit the best arma model

###This code uses the auto.arima function from the forecast library to fit an ARMA model to the returns data and stores the resulting model in arma_model.
arma_model <- auto.arima(returns,  max.D = 0, max.d = 0)
arma_model

sentiment_arma_model <- auto.arima(sentiment_df$sentiment,  max.D = 0, max.d = 0)
sentiment_arma_model

sentiment_df <- read.csv("/Users/pranavtavildar/Desktop/Senior-Thesis/data/daily_sentiments.csv", header = TRUE)
str(sentiment_df)
str(returns)
sentiment_df = sentiment_df[-1,]
###adjusting the scale for the garchx
adj_sentiment <- sentiment_df$sentiment/100

###armax
exarma_model <- arimax(x = returns, xreg = sentiment_df$sentiment, order= c(1,0,1))
exarma_model

### point estimate over s.e

###garchx
centered_returns <- scale(returns, center = TRUE, scale = FALSE)
garchx_model <- garchx(centered_returns, xreg=adj_sentiment, order = c(1,1), initial.values = c(coef(fit_garch),0))
garchx_model

###Didn't appear to show any significant effect. Try with a day lag by shifting xreg back a day
###Granger Causality Test
###Use residual of armamodel for sentiment score 

### weighted sentiment score 
weighted_df <- read.csv("/Users/pranavtavildar/Desktop/Senior-Thesis/data/weighted_daily_sentiments.csv", header = TRUE)
str(weighted_df)
str(returns)
weighted_df = weighted_df[-1,]

###armax
exarma_model <- arimax(x = returns, xreg = weighted_df$weighted_sentiment)
exarma_model

###garchx
garchx_model <- garchx(returns, xreg=sentiment_df$weighted_sentiment)
summary(garchx_model)
