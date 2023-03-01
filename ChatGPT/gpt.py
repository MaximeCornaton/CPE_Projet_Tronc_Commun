#pip3 install openai

import os
import openai

# Load your API key from an environment variable
openai.api_key = "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"

response = openai.Completion.create(model="text-davinci-003", prompt="Say this is a test", temperature=0, max_tokens=7)

print(response)