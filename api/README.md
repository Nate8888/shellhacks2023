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