from flask import Flask, jsonify, request
from flask_cors import CORS, cross_origin
from PIL import Image
import base64
import io
import train_predict
import image_identification

app = Flask(__name__)
cors = CORS(app)

@app.route('/', methods=['GET', 'POST'])
@cross_origin()

def getImage() :
  data = request.get_json(force=True)
  image_value = data['image']
  image_data = base64.b64decode(image_value)
  image = 'image.jpg'
  with open(image, 'wb') as f :
    f.write(image_data)

  typeOfImage = image_identification.identify(image)
  if (typeOfImage) :
    text = train_predict.findPersonalityTraits(image)
  else :
    text = "The image is printed or typed thus it cannot be analyzed. In order to analyze personality traits of a human, please upload a handwritten image. Thank you."
  return text

if __name__=='__main__' :
    app.run(debug=True, host='localhost', port='5000')