import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:translator/translator.dart';
import 'package:flutter_tts/flutter_tts.dart';

class TextRecogVoice {
  final FlutterTts tts = FlutterTts();
  GoogleTranslator gt = GoogleTranslator();
  Future future;
  String out;
  String l1="en";
  String l2="en-IN";
  String text = "";
  String prevtext = "";
  int prevval = 0;

  Future<void> scanText(imageFile, val) async {
    String tts_text = "";
    if (imageFile == null) {
      tts_text = "No Image Selected";
    }
    else {
      final FirebaseVisionImage visionimage = FirebaseVisionImage.fromFile(imageFile);
      final TextRecognizer textrecog = FirebaseVision.instance.textRecognizer();
      try {
        textrecog.processImage(visionimage).then((VisionText visiontext) {
          prevtext = text;
          text = _extractText(visiontext);
        });
        if (text.isEmpty) {
          tts_text = "No text";
        }
        else {
          tts_text = '$text';
        }
      }
      catch (e) {
        print('$e');
        tts_text = "Error : Please Try Again..";
      }
    }
    if((tts_text.isNotEmpty && tts_text != prevtext) || (tts_text.isNotEmpty && prevval != val))
      speak(tts_text, val);
    await updatePrevVal(val);
  }

  String _extractText(VisionText visiontext) {
    String t = "";
    for (TextBlock block in visiontext.blocks) {
      for (TextLine line in block.lines) {
        for (TextElement word in line.elements) {
          t = t + word.text + " ";
        }
        t = t + "\t";
      }
    }
    return t;
  }

  Future<void> updatePrevVal(val) async {
    prevval = val;
  }

  void setLang(val) {
    if (val == 1) {
      l1 = "en";
      l2 = "en-IN";
    }
    else if (val == 2) {
      l1 = "hi";
      l2 = "hi-IN";
    }
    else if (val == 3) {
      l1 = "mr";
      l2 = "mr-IN";
    }
  }

  Future translate(line) async {
    Translation output = await gt.translate(line, to: '$l1');
    out = output.toString();
    print(out);
  }

  Future speak(text, val) async {
    setLang(val);
    await translate(text);
    await tts.setLanguage("$l2");
    await tts.speak("$out");
  }
}