# Sentiment Analysis of Twitter in Relation to Fossil Fuel Stock Prices

As a publicly traded company, the Chevron Corporation has the 11th highest market capitalization in the world with 361.57 billion dollars in traded stocks. There exist many social factors that contribute to this stock value but in this paper we seek to determine whether it is possible to see if any of these factors are reflected in public sentiment which can be observed in twitter.  This is done by using a BERT transformer architecture to assign a sentiment score for each tweet and afterwords, we try to determine if there is a correlation between stock price and daily sentiment using Kendall's tau statistic.

To download the packages needed for analysis, install python3 and pip3 and make sure to run the following lines of code:
```pip install pandas```
```pip install seaborn```
```pip install matplotlib```

To run snscrape, run the following command:
```pip3 install git+https://github.com/JustAnotherArchivist/snscrape.git```