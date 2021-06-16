import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:translator/translator.dart';

class TextToSpeech extends StatefulWidget {
  final String text;
  final int val;
  TextToSpeech(this.text, this.val);
  _TextToSpeechState createState() => _TextToSpeechState();
}

class _TextToSpeechState extends State<TextToSpeech> {
  final FlutterTts tts = FlutterTts();
  GoogleTranslator gt = GoogleTranslator();
  Future future;
  String out;
  String l1="en";
  String l2="en-IN";

  void setLang() {
    if (widget.val == 1) {
      l1 = "en";
      l2 = "en-IN";
    }
    else if (widget.val == 2) {
      l1 = "hi";
      l2 = "hi-IN";
    }
    else if (widget.val == 3) {
      l1 = "mr";
      l2 = "mr-IN";
    }
  }

  Future translate(line) async {
    Translation output = await gt.translate(line, to: '$l1');
    out = output.toString();
    print(out);
  }

  Future _speak() async {
    setLang();
    await translate(widget.text);
    await tts.setLanguage("$l2");
    await tts.speak("$out");
  }

  @override
  Widget build(BuildContext context) {
    print(widget.text);
    return FutureBuilder(
      future: _speak(),
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container();
      }
    );
  }
}