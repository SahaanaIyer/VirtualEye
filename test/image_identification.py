import cv2
import numpy as np
import pytesseract
import nltk
from nltk.corpus import words
nltk.download('words')

w = ['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z']

def identify(image) :
  pytesseract.pytesseract.tesseract_cmd = r"C:\Program Files\Tesseract-OCR\tesseract.exe"
  img = cv2.imread(image)                               # image loader
  text = pytesseract.image_to_string(img , config='')   # img text to string
  text = list(text.split(' '))                          # converting into list
  c = 0
  d = 0
  for item in text :
    item = item.strip(',').strip(':').strip('.').strip('"').strip('|').strip('?')
    for e in item:
      if e.lower() in w :
        c += 1
      else :
        d += 1
  if (c > d) :
    return 1                                             # handwritten
  else :
    return 0                                             # printed