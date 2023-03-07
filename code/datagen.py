import snscrape.modules.twitter as sntwitter
import pandas as pd
from tqdm.auto import tqdm
from time import sleep
from datetime import date
from datetime import timedelta
import os
import glob

#Auxillary Function to Check for Leap Years
def CheckLeap(Year):  
    if((Year % 400 == 0) or  
     (Year % 100 != 0) and  
     (Year % 4 == 0)):   
        return 366
    else:  
        return 365


#Fetching Tweets Function
def GrabTweets(month,year,num_tweets_per_day,query):

    # Calculate Total Tweets Per Month to Collect
    if month in [1, 3, 5, 7, 8, 10, 12]:
        days_in_month = 31
        total_tweets = days_in_month * num_tweets_per_day

    elif month in [4, 6, 9, 11]:
        days_in_month = 30
        total_tweets = days_in_month * num_tweets_per_day

    elif month == 2:
        if CheckLeap(year) == 365:
            days_in_month = 28
            total_tweets = days_in_month * num_tweets_per_day
        else:
            days_in_month = 29
            total_tweets = days_in_month * num_tweets_per_day

    # Creating List to Append Tweet Data to
    tweets_list = []
    pbar = tqdm(total=total_tweets)

    # Create Date Object
    since = date(year,month,1).isoformat() #
    until = date(year, month, 2).isoformat()
    last_day = (date.fromisoformat(until)+timedelta(days=days_in_month)).isoformat()

    # Counter
    counter = 0

    # Using TwitterSearchScraper to Scrape Data on Chevron in X Month in 2021 & Append Tweets to List
    while counter != total_tweets:
        for j in range(1):
            for i,tweet in enumerate(sntwitter.TwitterSearchScraper('{} since:{} until:{} lang:en'.format(query, since, until)).get_items()):
                if i >= num_tweets_per_day:
                    since = (date.fromisoformat(since)+timedelta(days=1)).isoformat()
                    until = (date.fromisoformat(until)+timedelta(days=1)).isoformat()
                    break
                tweets_list.append([tweet.date, tweet.id, tweet.content,tweet.likeCount])
                sleep(0.01)
                counter += 1
                pbar.update(1)

    pbar.close()

    # Creating a DataFrame from the Tweets List Above
    DF = pd.DataFrame(tweets_list, columns=['Date', 'Tweet ID', 'Text', 'Likes'])
    
    
    # Write to CSV
    DF.to_csv('{}-Tweets-{}-{}-{}.csv'.format(query,month,year,total_tweets), encoding='utf-8', index=False)
    
    # Print Done
    print(pbar,"\n")
    print("Done!")

#fetching data

query = "CVX"
year = 2022
num_tweets_per_day = 10

#months = range(1,13)
os.chdir("/Users/pranavtavildar/Desktop/Senior-Thesis/data/monthlydata")  
#for i in months:
GrabTweets(12,year,num_tweets_per_day,query) 

##This is for merging files later
# #creating big csv
  
# extension = 'csv'
# all_filenames = [i for i in glob.glob('*.{}'.format(extension))]
# #combine all files in the list
# combined_csv = pd.concat([pd.read_csv(f) for f in all_filenames ])
# #export to csv
# combined_csv.to_csv( "ChevronOil2022.csv", index=False, encoding='utf-8-sig')

