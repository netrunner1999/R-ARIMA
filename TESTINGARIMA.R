install.packages('tseries')
install.packages('forecast')

library(tseries)
library(forecast)

# Remove a single object (e.g., a data frame named 'df')
rm(df)
# Remove multiple objects
rm(df1, df2, df3)
# Remove all objects
rm(list = ls())

# creating the timeseries ((INSTEAD OF JPM TYPE THE NAME OF YOUR DATASET))
JPMts <- ts(JPM$Adj.Close, start = c(2016, 06), frequency = 12)

# creating training and testing data sets
train_data <- JPMts[1:80]
test_data <- JPMts[81:85]

# creating the arima model
arimamodel <- auto.arima(train_data)
summary(arimamodel)

# testing for stationarity
adf.test(log_train_data)

# log transformation

log_train_data <- log(train_data)

# differencing
log_train_data2 <- log(log_train_data)

adf.test(log_train_data2)

# ACF AND PACF PLOTS
acf(log_train_data2)
pacf(log_train_data2)

# Fit the ARIMA(0,0,0) model
model <- Arima(log_train_data2, order=c(0,1,0))

# Check the model summary
summary(model)

forecast_data <- forecast(log_train_data2, h=5)
print(forecast_data)

checkresiduals(forecast_data)

exp_train_data <- exp(forecast_data)

exp_train_data2 <- exp(exp_train_data)

print(exp_train_data2)

forecast_data$mean <- exp(forecast_data$mean)

forecast_data$mean_2 <- exp(forecast_data$mean)

print(forecast_data$mean_2)

forecast_data <- forecast(arimamodel, h=5)
print(forecast_data)
