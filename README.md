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
