import yfinance as yf
import pandas as pd

df = pd.read_csv('sp500.csv')
symbols = df['Symbol'].values

data = yf.download(tickers=list(symbols), period='1d')['Close']

# print(df)

# data.to_csv('sp500_closing_prices.csv')
df_prices = pd.read_csv('sp500_closing_prices.csv')

# Expand/Melt the df 
df_prices_melted = df_prices.melt(id_vars='Date', var_name='Symbol', value_name='Price')


df = df.merge(df_prices_melted, on='Symbol', how='left')
df.to_csv("complete_data.csv")