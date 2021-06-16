import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'tts.dart';

class TextRecog extends StatefulWidget {
  final File imageFile;
  final int val;
  TextRecog(this.imageFile, this.val);
  _TextRecogState createState() => _TextRecogState();
}

class _TextRecogState extends State<TextRecog> {
  String text = "";
  String prevtext = "";
  int prevval = 0;

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

  Widget scanText() {
    if (widget.imageFile == null) {
      return Text(
          "No Image Selected",
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.7,
        ),
      );
    }
    else {
      final FirebaseVisionImage visionimage = FirebaseVisionImage.fromFile(widget.imageFile);
      final TextRecognizer textrecog = FirebaseVision.instance.textRecognizer();
      try {
        textrecog.processImage(visionimage).then((VisionText visiontext) {
          this.setState(() {
            prevtext = text;
            text = _extractText(visiontext);
          });
        });
        if (text.isEmpty) {
          return Text(
            "No text",
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.7,
            ),
          );
        }
        else {
          return Text(
            '$text',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.7,
            ),
          );
        }
      }
      catch (e) {
        print('$e');
        return Text(
            "Error : Please Try Again..",
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.7,
          ),
        );
      }
    }
  }

  Widget updatePrevVal() {
    prevval = widget.val;
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
         children: <Widget>[
           scanText(),
           if((text.isNotEmpty && text!=prevtext) || (text.isNotEmpty && prevval != widget.val))
             TextToSpeech(text, widget.val),
           updatePrevVal()
        ]),
    );
  }
}