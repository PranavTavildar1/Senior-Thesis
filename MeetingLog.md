# Meeting 1 Notes:

Literature Review:
Identify the problem
Is there anybody working on the same question?
What’s the closest, related topics

Use Cite p not cite t 

Write roadmap by paragraph, no numbers section 1,,2,,,3

Remove here we can see the fluctuations, from date starting to second date

Analyze closing price instead of high and low
Daily rate of return - percentage gain from yesterday to today
Second series

Look at the data from different angles

Query CVX

Is there a way to select like the top five tweets, retweet/replies?

Top tweets are more influential

Analyzed correlation between stock price and sentiment score, rate of return, instead of investigating raw price, investigate the rate of return.

Arma-garch
Include sentiment score as a Covariate in the model


Get more data


# Meeting 2 Notes:
Data Generation:
Split the big jobs into small jobs
Anonymize the tweets (Get rid of user variable)
Journal: American Journal for Undergraduate Research
Return rate = log(closingpriceb)- log(closingpricea)
Write hypothesis in paper

# Meeting 3 Notes:

- Get rate of return to start building the arma garch model
- SDAGN package for ARMA GARCH (ARIMA GARCH without the I) Most popular model for modeling stock returns
- video for Arma Garch https://www.youtube.com/watch?v=Iv-AO9lIMz8
- https://www.r-bloggers.com/2012/10/a-greedy-armagarch-model-selection/
- after data preparation, fit 2 ag models
- first model without the score developed
- second with the score developed 
- if the second model is significantly better through model selection criteria accept hypothesis
- Arma 11
- Garch 11
- H_0 is that the sentiment scored tweets affect price
- Direction for causal inference is unknown but we are not testing that
- Create histogram to look at the distribution of the sentiment scores.

# Meeting 4 Notes:

- Obtained Rate of Return
- Strategy for sentiment score is finidng weighted averages of days based on likes
- Create the ARMA GARCH Model only on the Rate of Return
- Then add sentiment score as another variable and do it again
