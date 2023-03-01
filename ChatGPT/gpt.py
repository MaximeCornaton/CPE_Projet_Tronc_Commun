import openai
from clef_token import key
import speech_recognition as sr
import gtts
from pydub import AudioSegment
from pydub.playback import play
from os import path

# Load your API key from an environment variable
openai.api_key = key

AUDIO_FILE = path.join(path.dirname(path.realpath(__file__)), "gpt_audio.wav")

r = sr.Recognizer()
with sr.AudioFile(AUDIO_FILE) as source:
    audio = r.record(source)

prompt =  r.recognize_google(audio, language="fr-FR")

# Generate a response
completion = openai.Completion.create(
    engine="text-davinci-003",
    prompt=prompt,
    max_tokens=50,
    n=1,
    stop=None,
    temperature=0.5,
)

response = completion.choices[0].text
print(response)

# make request to google to get synthesis
tts = gtts.gTTS(response)
# save the audio file
tts.save("hello.mp3")
# play the audio file
sound = AudioSegment.from_file("hello.mp3", format="mp3")
play(sound)
