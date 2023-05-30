# Sentiment Analysis of Twitter in Relation to Fossil Fuel Stock Prices

As a publicly traded company, the Chevron Corporation has the 11th highest market capi- talization in the world with 361.57 billion dollars in traded stocks. There exist many social factors that contribute to this stock value but this paper aims to establish a methodology to test whether public opinion in social media is informative in predicting stock price movement and its volatility for the Chevron Corporation stock (CVX). This is done by using a Distil- Bert transformer architecture to assign a sentiment score for each tweet and afterwords, we try to determine if there is a correlation between stock price and daily sentiment using an ARMA GARCH Model.

To download the packages needed for analysis, install python3 and pip3 and make sure to run the following lines of code:
```pip install pandas```
```pip install seaborn```
```pip install matplotlib```

To run snscrape, run the following command:
```pip3 install git+https://github.com/JustAnotherArchivist/snscrape.git```
