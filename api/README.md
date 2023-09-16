# API Documentation

## General Information
This API enables the application to send a POST request with an audio file or an array of conversations (optional) and returns AI's output voice and text along with the user's input voice and text. 

## Endpoint 
`POST https://hacktheshell.appspot.com/talk`

## Request 
Headers: `Content-Type: multipart/form-data`

Body:

```json
{
  "audio": "AUDIO_FILE",
  "conversations": ["USER_TEXT", "AI_TEXT", "USER_TEXT", "AI_TEXT"]
}
```

### Parameters

* **audio** (binary, required) - The binary data of audio file.
* **conversations** (array, optional) - An array of alternating conversational strings starting from USER_TEXT followed by AI_TEXT and so on.

Example:
```json
{
  "audio": "[BINARY_DATA]",
  "conversations": ["Hi, this is John.", "Hello John, nice to meet you.", "You too."]
}
```

## Response 

The API will respond with a JSON containing the AI's output voice and text, and user's input voice and text.

### Body

```json
{
    "ai_output": "AI_OUTPUT_AUDIO_FILE_URL",
    "ai_text": "AI_RESPONSE_TEXT",
    "user_input": "USER_INPUT_AUDIO_FILE_URL",
    "user_text": "USER_INPUT_TEXT"
}
```

**Response Fields:**

* **ai_output** (string) - The URL to the AI output audio file.
* **ai_text** (string) - The text representation of AI output.
* **user_input** (string) - The URL to user's input audio file.
* **user_text** (string) - The text representation of user's input.

### Example Response
```json
{
    "ai_output": "https://storage.googleapis.com/shellhacksbucket/HKCqDwXT.mp3",
    "ai_text": "Hello Bella! Nice to meet you too. How can I assist you today with financial literacy content and sustainability?",
    "user_input": "https://storage.googleapis.com/shellhacksbucket/i8kLbzh4.mp3",
    "user_text": "Hi, my name is Bella. Nice to meet you."
}
```

## Get All Articles

## Endpoint 
`GET https://hacktheshell.appspot.com/articles`

## Request 
Headers: `Content-Type: application/json`

This is a GET request, so no inputs are required.

## Response 

The API responds with a data object containing a list of articles. Each article is an object with fields `headline`, `summary`, `score` and `esg_points`.

Each `esg_points` is an array that contains brief points related to 'E' (Environmental), 'S' (Social), and 'G' (Governance) aspects of the article.

### Body

```json
{
    "news": [
        {
            "headline": "HEADLINE_TEXT",
            "summary": "SUMMARY_TEXT",
            "score": SCORE,
            "esg_points": [
                "E ESG_POINT",
                "S ESG_POINT",
                "G ESG_POINT"
            ]
        },
        ...
    ]
}
```
**Response Fields:**

* **headline** (string) - The headline of the article.
* **summary** (string) - A text summary of the article.
* **score** (number) - A numerical score assigned to the article.
* **esg_points** (array) - A list of points related to environmental, social, and governance aspects of the company or event discussed in the article.

### Example Response
```json
{
    "news": [
        {
            "headline": "Apple to invest $1 billion in North Carolina campus, create at least 3,000 jobs",
            "summary": "Wow",
            "score": 7.8,
            "esg_points": [
                "E Apple is investing $1 billion in North Carolina as part of a plan to establish a new campus and engineering hub in the Research Triangle area.",
                "S The company said it will create at least 3,000 new jobs in machine learning, artificial intelligence, software engineering and other fields.",
                "G Apple will also establish a $100 million fund to support schools and community initiatives in the greater Raleigh-Durham area and across the state."
            ]
        }
    ]
}
```

## Get All Stocks

## Endpoint 
`GET https://hacktheshell.appspot.com/stocks`

## Request 
Headers: `Content-Type: application/json`

This is a GET request, so no inputs are required.

## Response 

The API responds with a data object containing a list of stocks. Each stock is an object with fields `fullname`, `ticker`, `price`, `score` and `esg_points`.

Each `esg_points` is an array that contains brief points related to 'E' (Environmental), 'S' (Social), and 'G' (Governance) aspects of the stock company.

### Body

```json
{
    "stocks": [
        {
            "fullname": "COMPANY_FULLNAME",
            "ticker": "STOCK_TICKER",
            "price": STOCK_PRICE,
            "score": SCORE,
            "esg_points": [
                "E ESG_POINT",
                "S ESG_POINT",
                "G ESG_POINT"
            ]
        },
        ...
    ]
}
```

**Response Fields:**

* **fullname** (string) - The full name of the company.
* **ticker** (string) - The stock ticker symbol.
* **price** (number) - The current stock price.
* **score** (number) - A numerical ESG score assigned to the company stock.
* **esg_points** (array) - A list of points related to environmental, social, and governance aspects of the company.

### Example Response
```json
{
    "stocks": [
        {
            "fullname": "Apple",
            "ticker": "AAPL",
            "price": 127.45,
            "score": 7.8,
            "esg_points": [
                "E Apple is investing $1 billion in North Carolina as part of a plan to establish a new campus and engineering hub in the Research Triangle area.",
                "S The company said it will create at least 3,000 new jobs in machine learning, artificial intelligence, software engineering and other fields.",
                "G Apple will also establish a $100 million fund to support schools and community initiatives in the greater Raleigh-Durham area and across the state."
            ]
        }
    ]
}
```