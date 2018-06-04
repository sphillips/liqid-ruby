# Liqid Coding Challenge
## To Run Example
Run the `fetch_stock.rb` script from the command line in the root folder, providing your API key as an ENV variable. If no API key is provided, the script will default to a test key:

```
$ API_KEY=XXX ruby fetch_stock.rb AAPL 2018-01-01 2018-01-05

02.01.18: Closed at 172.26 (169.26 ~ 172.3)
03.01.18: Closed at 172.23 (171.96 ~ 174.55)
04.01.18: Closed at 173.03 (172.08 ~ 173.47)
05.01.18: Closed at 175.0 (173.05 ~ 175.37)

First 3 Drawdowns:
-1.8% (172.3 on 02.01.18 -> 169.26 on 02.01.18)
-1.5% (174.55 on 03.01.18 -> 171.96 on 03.01.18)
-0.8% (173.47 on 04.01.18 -> 172.08 on 04.01.18)
Max Drawdown: -1.8% (172.3 on 02.01.18 -> 169.26 on 02.01.18)

Return: 2.740000000000009 [+1.6%] (172.26 on 02.01.18 -> 175.0 on 05.01.18)
```

## To Run Specs
Simply run the `rspec` command from the root folder:

```
$ rspec
```

The [VCR](https://github.com/vcr/vcr) gem is used to record the API response and speed up the test suite.

## Todos
In order for this script to handle large data sets or a high volume of API requests, my first suggestion would be to move the data processing and output of `stock.rb` into a message queue like [Resque](https://github.com/resque/resque). This enables many requests to be handled at once without awaiting the API response and also gives the operations team the ability to scale worker processes as needed. Also a necessary consideration would be to configure some type of error handling to prepare for the eventuality that the API rate limit is hit.

## Requirements
- The application should get following inputs
  - A stock symbol e.g. “AAPL”
  - Start date or range of date
  - API key for getting stock prices
- Calculate the return the stock has generated since the start date to today / any date as
well as the maximum drawdown of the stock within that time frame.
  - Formula for the rate of return:
https://en.wikipedia.org/wiki/Rate_of_return#Return
  - About maximum drawdown: https://ycharts.com/glossary/terms/max_drawdown
- The application should print following information on the command line.
  - Stock prices on the given date / during the time frame
  - Return the stock has generated
  - Maximum drawdown
- BONUS: Set up a trigger to send the output to users via email, Slack or any other
notification service you want to use. Make sure it comes with a nice template.
