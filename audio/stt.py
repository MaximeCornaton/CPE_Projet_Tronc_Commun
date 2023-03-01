import speech_recognition as sr
import gtts
from playsound import playsound
from os import path

AUDIO_FILE = path.join(path.dirname(path.realpath(__file__)), "audio.wav")

r = sr.Recognizer()
with sr.AudioFile(AUDIO_FILE) as source:
    audio = r.record(source) 

try:
    print("Google Speech Recognition thinks you said " + r.recognize_google(audio, language="fr-FR"))
except sr.UnknownValueError:
    print("Google Speech Recognition could not understand audio")
except sr.RequestError as e:
    print("Could not request results from Google Speech Recognition service; {0}".format(e))

# make request to google to get synthesis
tts = gtts.gTTS(audio)
# save the audio file
tts.save("hello.mp3")
# play the audio file
playsound("hello.mp3")
