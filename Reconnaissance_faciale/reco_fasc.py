import cv2

def detectAndDisplay(frame):
    faceCascade = cv2.CascadeClassifier('haarcascade_frontalface_default.xml') # Chargement du classifieur de visages
    frame_gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY) # Conversion en niveaux de gris
    frame_gray = cv2.equalizeHist(frame_gray) # Histogramme égalisé
    #-- Detect faces
    faces = faceCascade.detectMultiScale(frame_gray) # Détection des visages
    for (x,y,w,h) in faces:
        center = (x + w//2, y + h//2) # Centre du rectangle
        frame = cv2.ellipse(frame, center, (w//2, h//2), 0, 0, 360, (255, 0, 255), 4) # Dessin du rectangle
        faceROI = frame_gray[y:y+h,x:x+w] 
        #-- In each face, detect eyes
        eyes = faceCascade.detectMultiScale(faceROI) # Détection des yeux
        for (x2,y2,w2,h2) in eyes: 
            eye_center = (x + x2 + w2//2, y + y2 + h2//2) # Centre du cercle
            radius = int(round((w2 + h2)*0.25)) # Rayon du cercle
            frame = cv2.circle(frame, eye_center, radiusY, (255, 0, 0 ), 4) # Dessin du cercle   
    cv2.imshow('Capture - Face detection', frame) # Affichage de l'image de la webcam

cap = cv2.VideoCapture(0) # Ouverture de la webcam
while True:
    valeurRetour, imageWebcam = cap.read() # Lecture de l'image de la webcam
    cv2.flip(imageWebcam, 1, imageWebcam) # Miroir de l'image
    detectAndDisplay(imageWebcam)
    if cv2.waitKey(1) & 0xFF == ord('q'): # Touche 'q' pour quitter  
        break
    
    

