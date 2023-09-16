import aylien_news_api
from aylien_news_api.rest import ApiException
from pprint import pprint as pp
import dotenv
import os
dotenv.load_dotenv()

NEWS_API_ID = os.getenv('NEWS_API_ID')
NEWS_API_KEY = os.getenv('NEWS_API_KEY')

## Configure your connection to the API
configuration = aylien_news_api.Configuration()
configuration.api_key['X-AYLIEN-NewsAPI-Application-ID'] = NEWS_API_ID
configuration.api_key['X-AYLIEN-NewsAPI-Application-Key'] = NEWS_API_KEY
configuration.host = "https://api.aylien.com/news"
api_instance = aylien_news_api.DefaultApi(aylien_news_api.ApiClient(configuration))

opts= {
    'title': '"Apple"',
    'body': 'ESG',
    'language': ['en'],
    'published_at_start': 'NOW-7DAYS',
    'published_at_end': 'NOW',
    'per_page': 10,
    'sort_by': 'relevance'
}

try:
    api_response = api_instance.list_stories(**opts)
    ## Print the returned story
    # pp(api_response.stories)
    stories = []
    for each_story in api_response.stories:
      story_sum = ' '.join(each_story.summary.sentences).replace("\n\n","\n")
      headline = each_story.title
      stories.append({
          "headline": headline,
          "sum": story_sum
      })
      print(headline)
      print(story_sum)
    print("Count is: ",len(stories))
except ApiException as e:
    print('Exception when calling DefaultApi->list_stories: %s\n' % e)
