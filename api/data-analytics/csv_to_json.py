import pandas as pd
import json

def csv_to_json(csv_file):
    df = pd.read_csv(csv_file)
    df = df[['Symbol','Name','Sector','Price']]
    df = df.dropna()
    df = df.reset_index(drop=True)
    df = df.to_dict('records')
    return df


result = csv_to_json('complete_data.csv')
print(result)
json.dump(result, open('data.json', 'w'))