import cv2

videoWebcam = cv2.VideoCapture(0) # Ouverture de la webcam
while True:
    valeurRetour, imageWebcam = videoWebcam.read() # Lecture de l'image de la webcam
    cv2.imshow('Image de la webcam', imageWebcam) # Affichage de l'image de la webcam
    if cv2.waitKey(1) & 0xFF == ord('q'): # Touche 'q' pour quitter  
        break
videoWebcam.release() # Libération de la webcam
cv2.destroyAllWindows() # Fermeture de toutes les fenêtres 


