import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_tts/flutter_tts.dart';
import 'package:translator/translator.dart';

class ApiService {
  final FlutterTts tts = FlutterTts();
  GoogleTranslator gt = GoogleTranslator();
  String prevtext="";
  String text="";

  Future<void> sendImage(File imageFile) async {
    prevtext = text;
    if( imageFile == null) {
      text = "Please choose an image from gallery or camera";
    }
    else {
      File image = File(imageFile.path);
      String base64image = base64Encode(image.readAsBytesSync());
      String url = 'http://973ef7b1f61f.ngrok.io';
      final response = await http.post(
        Uri.parse(url),
        body: jsonEncode(
          {
            'image': base64image,
          },
        ),
        headers: {'Content-Type': 'application/json'},
      );
      if(response.statusCode == 200) {
        text = response.body;
      }
      else {
        text = "Error : Could not process information. Please try again";
      }
    }
    if(text.isNotEmpty && text!=prevtext) {
      print("Personality Traits : " + text);
      await speak(text);
    }
  }

  Future<void> speak(text) async {
    await tts.setLanguage("en-IN");
    await tts.speak(text);
  }
}
