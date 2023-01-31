import snscrape.modules.twitter as sntwitter
import pandas as pd
from tqdm.auto import tqdm
from time import sleep
from datetime import date
from datetime import timedelta
import os
import glob

tweets_list = []
for i,tweet in enumerate(sntwitter.TwitterSearchScraper('CVX until:2023-01-28 since:2023-01-25 lang:en').get_items()): #declare a username 
    if i>20: #number of tweets you want to scrape
        break
    tweets_list.append([tweet.date, tweet.id, tweet.content, tweet.quoteCount, tweet.retweetCount]) #declare the attributes to be returned

df = pd.DataFrame(tweets_list,columns=["Date","ID","Content","QuoteCount","Retweets"])

df.to_csv('popularitymatrix.csv')