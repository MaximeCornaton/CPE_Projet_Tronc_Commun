import speech_recognition as sr
import gtts
from pydub import AudioSegment
from pydub.playback import play
from os import path

AUDIO_FILE = path.join(path.dirname(path.realpath(__file__)), "audio.wav")

r = sr.Recognizer()
with sr.Microphone() as source:
    audio = r.listen(source,timeout=3)
text =  r.recognize_google(audio, language="fr-FR")

try:
    print("Google Speech Recognition thinks you said " + text)
except sr.UnknownValueError:
    print("Google Speech Recognition could not understand audio")
except sr.RequestError as e:
    print("Could not request results from Google Speech Recognition service; {0}".format(e))

# make request to google to get synthesis
tts = gtts.gTTS(text=text, lang="fr")
# save the audio file
tts.save("hello.mp3")
# play the audio file
sound = AudioSegment.from_file("hello.mp3", format="mp3")
play(sound)

