import openai
from clef_token import key

# Load your API key from an environment variable
openai.api_key = key

# Generate a response
completion = openai.Completion.create(
    engine="text-davinci-003",
    prompt="Comment vas-tu ?",
    max_tokens=50,
    n=1,
    stop=None,
    temperature=0.5,
)

response = completion.choices[0].text
print(response)