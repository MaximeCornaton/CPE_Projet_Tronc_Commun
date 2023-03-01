import speech_recognition as sr
import gtts
from playsound import playsound

r = sr.Recognizer()
with sr.Microphone() as source:
    print("Say something!")
    audio = r.listen(source, timeout=2)

try:
    print("Google Speech Recognition thinks you said " + r.recognize_google(audio, language="fr-FR"))
except sr.UnknownValueError:
    print("Google Speech Recognition could not understand audio")

# make request to google to get synthesis
tts = gtts.gTTS(audio)
# save the audio file
tts.save("hello.mp3")
# play the audio file
playsound("hello.mp3")