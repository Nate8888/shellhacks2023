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

- **audio** (binary, required) - The binary data of audio file.
- **conversations** (array, optional) - An array of alternating conversational strings starting from USER_TEXT followed by AI_TEXT and so on.

Example:

```json
{
  "audio": "[BINARY_DATA]",
  "conversations": [
    "Hi, this is John.",
    "Hello John, nice to meet you.",
    "You too."
  ]
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

- **ai_output** (string) - The URL to the AI output audio file.
- **ai_text** (string) - The text representation of AI output.
- **user_input** (string) - The URL to user's input audio file.
- **user_text** (string) - The text representation of user's input.

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

The API responds with a data object containing a list of articles. Each article is an object with fields `esg`, `esg_company_score`, `fullname`, `heading`,  `score`, and `ticker`

Each `esg` is an array that contains brief points related to 'E' (Environmental), 'S' (Social), and 'G' (Governance) aspects of the article.

### Body

```json
[
    {
        "Price": 138.3000030517578,
        "esg": [
            "E:Strong emphasis on environmental sustainability with a clear, timely goal for achieving carbon neutrality.",
            "S:No specific social impact discussed in this announcement.",
            "G:No specific corporate governance matters raised in this piece."
        ],
        "esg_company_score": 7.5,
        "fullname": "Alphabet Inc Class C",
        "heading": "Alphabet Inc Class C commits to achieving carbon neutrality by 2020\n",
        "score": 9.5,
        "sector": "Information Technology",
        "ticker": "GOOG"
    },
    {
        "Price": 213.3500061035156,
        "esg": [
            "E: Autodesk's commitment to achieve 100% carbon neutrality indicates a strong emphasis on reducing environmental impact through sustainable practices.",
            "S: There's no direct reference to social aspects in the article.",
            "G: No discussion of corporate governance related details."
        ],
        "esg_company_score": 5.88,
        "fullname": "Autodesk Inc.",
        "heading": "Autodesk Announces Commitment to Achieve 100% Carbon Neutrality by 2020\n",
        "score": 9.5,
        "sector": "Information Technology",
        "ticker": "ADSK"
    },
]
```

**Response Fields:**

- **esg** (array) - A list of points related to environmental, social, and governance aspects of the article.
- **esg_company_score** (number) - A numerical ESG score assigned to the company.
- **fullname** (string) - The full name of the company.
- **heading** (string) - The heading of the article.
- **score**  (number) - ESG score of the article
- **ticker** (string) - The stock ticker symbol.

### Example Response

```json
[
  {
    "esg": [
      "E:Strong emphasis on environmental sustainability with a clear, timely goal for achieving carbon neutrality.",
      "S:No specific social impact discussed in this announcement.",
      "G:No specific corporate governance matters raised in this piece."
    ],
    "esg_company_score": 7.5,
    "fullname": "Alphabet Inc Class C",
    "heading": "Alphabet Inc Class C commits to achieving carbon neutrality by 2020\n",
    "score": 9.5,
    "ticker": "GOOG"
  },
  {
    "esg": [
      "E: Autodesk's commitment to achieve 100% carbon neutrality indicates a strong emphasis on reducing environmental impact through sustainable practices.",
      "S: There's no direct reference to social aspects in the article.",
      "G: No discussion of corporate governance related details."
    ],
    "esg_company_score": 5.88,
    "fullname": "Autodesk Inc.",
    "heading": "Autodesk Announces Commitment to Achieve 100% Carbon Neutrality by 2020\n",
    "score": 9.5,
    "ticker": "ADSK"
  },
  ...
]
```

## Get All Stocks (Companies)

## Endpoint

`GET https://hacktheshell.appspot.com/stocks`

## Request

Headers: `Content-Type: application/json`

This is a GET request, so no inputs are required.

## Response

The API responds with a data object containing a list of stocks. Each stock is an object with fields `Name`, `Price`, `Sector`, `Symbol` and `score`.

### Body

```json
[
    {
        "Name": "CME Group Inc.",
        "Price": 206.82000732421875,
        "Sector": "Financials",
        "Symbol": "CME",
        "score": 9.3
    },
    {
        "Name": "Ecolab Inc.",
        "Price": 177.9600067138672,
        "Sector": "Materials",
        "Symbol": "ECL",
        "score": 8.6
    },
]
```

**Response Fields:**

- **Name** (string) - The full name of the company.
- **Symbol** (string) - The stock ticker symbol.
- **Price** (number) - The current stock price.
- **score** (number) - A numerical ESG score assigned to the company stock.

### Example Response

```json
[
    {
        "Name": "CME Group Inc.",
        "Price": 206.82000732421875,
        "Sector": "Financials",
        "Symbol": "CME",
        "score": 9.3
    },
    {
        "Name": "Ecolab Inc.",
        "Price": 177.9600067138672,
        "Sector": "Materials",
        "Symbol": "ECL",
        "score": 8.6
    },
]
```

## Get Articles by Company

## Endpoint

`GET https://hacktheshell.appspot.com/company/{ticker}`
`GET https://hacktheshell.appspot.com/company/GOOG`

```json
[
    {
        "esg": [
            "E:Strong emphasis on environmental sustainability with a clear, timely goal for achieving carbon neutrality.",
            "S:No specific social impact discussed in this announcement.",
            "G:No specific corporate governance matters raised in this piece."
        ],
        "esg_company_score": 7.5,
        "fullname": "Alphabet Inc Class C",
        "heading": "Alphabet Inc Class C commits to achieving carbon neutrality by 2020\n",
        "score": 9.5,
        "ticker": "GOOG"
    },
    {
        "esg": [
            "E: This focuses on Alphabet's investment in clean energy startups, which shows a strong commitment to environmental stewardship.",
            "S: N/A",
            "G: N/A"
        ],
        "esg_company_score": 7.5,
        "fullname": "Alphabet Inc Class C",
        "heading": "Alphabet Inc Class C invests in clean energy startups\n",
        "score": 7.5,
        "ticker": "GOOG"
    },
    {
        "esg": [
            "E: No significant Environmental impact mentioned in the article.",
            "S: Strong social impact due to the backlash from mishandling user data.",
            "G: Strong Governance concerns due to failure in overseeing user data privacy."
        ],
        "esg_company_score": 7.5,
        "fullname": "Alphabet Inc.",
        "heading": "Alphabet Inc Class C faces backlash over mishandling of user data\n",
        "score": 5.5,
        "ticker": "GOOG"
    }
]
```