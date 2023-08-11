#To visualize our model on Customize image
#custom image,able to predict the alphabet present in that image correctly or not

import cv2                    #cv2 to process images and to identify objects,handwriting ...
import tensorflow as tf       #(keras uses tensorflow as backend)
import matplotlib.pyplot as plt   #to visualize our data
import numpy as np
 
from keras.models import load_model    
model = load_model('handwritten_char_recog_model.h5')   #loads a model, saved through model
 
words = {0:'A',1:'B',2:'C',3:'D',4:'E',5:'F',6:'G',7:'H',8:'I',9:'J',10:'K',11:'L',12:'M',13:'N',14:'O',15:'P',
         16:'Q',17:'R',18:'S',19:'T',20:'U',21:'V',22:'W',23:'X', 24:'Y',25:'Z'}
 
image = cv2.imread('G.png')
image_copy = image.copy() #copy image to another image object(to copy image & retain the original)
image = cv2.cvtColor(image, cv2.COLOR_BGR2RGB) #cvtColor is used to convert an image from one color space to another.
                                               #COLOR_BGR2RGB=to convert BGR image to RGB before processing
image = cv2.resize(image, (400,440))
 
image_copy = cv2.GaussianBlur(image_copy, (7,7), 0)  #smoothening image(i.e.removing outlier pixels, that may be noise in image)
gray_image = cv2.cvtColor(image_copy, cv2.COLOR_BGR2GRAY)
_, img_thresh = cv2.threshold(gray_image, 100, 255, cv2.THRESH_BINARY_INV)  #if pixel intensity is less than set threshold, value set to 255, else set to 0 (black).
 
final_image = cv2.resize(img_thresh, (28,28))  
final_image =np.reshape(final_image, (1,28,28,1))
 
prediction = words[np.argmax(model.predict(final_image))]  #predict the label of a new set of data,
                                                           #returns the learned label for each object in the array
cv2.putText(image, "Prediction: " + prediction, (20,410), cv2.FONT_HERSHEY_DUPLEX, 1.3, color = (0,255,0))
cv2.imshow('handwritten character recognition is:', image)
 
while (1):
    k = cv2.waitKey(1) & 0xFF   
    if k == 27:
        break
cv2.destroyAllWindows()   #to close all windows at any time after exiting the script
