import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:speech_recognition/speech_recognition.dart';
import 'recogOnVoice.dart';
import 'request.dart';
import 'recog.dart';

void main() => runApp(MaterialApp(
  home: Home(),
));

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  SpeechRecognition sr;
  File imageFile;
  bool isListening = false;
  bool isAvailable = true;
  String command = "";
  String prevcommand = "";
  int _value = 1;

  _openGallery(BuildContext context) async {
    final pictures = await ImagePicker().getImage(source: ImageSource.gallery);
    this.setState(() {
      imageFile = File(pictures.path);
    });
    Navigator.of(context).pop();
  }

  _openGalleryVoice(BuildContext context) async {
    final pictures = await ImagePicker().getImage(source: ImageSource.gallery);
    this.setState(() {
      imageFile = File(pictures.path);
    });
  }

  _openCamera(BuildContext context) async {
    final pictures = await ImagePicker().getImage(source: ImageSource.camera);
    this.setState(() {
      imageFile = File(pictures.path);
    });
    Navigator.of(context).pop();
  }

  _openCameraVoice(BuildContext context) async {
    final pictures = await ImagePicker().getImage(source: ImageSource.camera);
    this.setState(() {
      imageFile = File(pictures.path);
    });
  }

  Future<void> _showChoiceDialog(BuildContext context,
      {AlertDialog Function(BuildContext context) builder}) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Click Your Choice"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text("Gallery"),
                    onTap: () {
                      _openGallery(context);
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  GestureDetector(
                    child: Text("Camera"),
                    onTap: () {
                      _openCamera(context);
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  Widget _decideImageView() {
    print("image view");
    print(imageFile);
    if (imageFile == null) {
      return Container();
    }
    else {
      return Image.file(imageFile, width: 400, height: 250);
    }
  }

  @override
  void initState() {
    super.initState();
    initSpeechRecognizer();
  }

  void initSpeechRecognizer() {
    prevcommand = command;
    sr = SpeechRecognition();
    sr.setAvailabilityHandler(
        (bool result) => setState(() => isAvailable = result),
    );
    sr.setRecognitionStartedHandler(
            () => setState(() => isListening = true),
    );
    sr.setRecognitionResultHandler(
            (String text) => setState(() => command = text),
    );
    print('command : $command');
    sr.setRecognitionCompleteHandler(
            () => setState(() => isListening = false),
    );
    sr.activate().then(
        (result) => setState(() => isAvailable = !result),
    );
  }

  Widget voice (BuildContext context) {
    isAvailable = true;
    isListening = false;
      sr.listen(locale: "en_US")
          .then((result) {
        print('command : $command');
        if (prevcommand != command) {
          if (command == "gallery" || command == "image") {
            _openGalleryVoice(context);
          }
          else if (command == "camera") {
            _openCameraVoice(context);
          }
          else if (command == "personality" || command == "attitude" || command == "more" || command == "know") {
            ApiService().sendImage(imageFile);
          }
          else if (command == "languages" || command == "language" || command == "change") {
            String lang = "Please pick one language from English, Hindi or Marathi";
            ApiService().speak(lang);
          }
          else if (command == "english" || command == "English") {
            setState(() {
              _value = 1;
            });
            TextRecog(imageFile, _value);
          }
          else if (command == "hindi" || command == "Hindi") {
            setState(() {
              _value = 2;
            });
            TextRecogVoice().scanText(imageFile, _value);
          }
          else if (command == "marathi" || command == "Marathi") {
            setState(() {
              _value = 3;
            });
            TextRecogVoice().scanText(imageFile, _value);
          }
          prevcommand = command;
        }
      });
    return Text('');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Virtual Eye',
          style: TextStyle(
            color: Colors.pink[50],
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.pink[900],
      ),
      body: Container(
        color: Colors.pink[100],
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              voice(context),
              _decideImageView(),
              Padding(
                padding: const EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 2.0),
                child: TextRecog(imageFile, _value),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints.tightFor(width: 100.0, height: 55.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.pink[800]),
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.pink[50]),
                        overlayColor: MaterialStateProperty.all<Color>(Colors.pink[100]),
                        shadowColor: MaterialStateProperty.all<Color>(Colors.black38),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(color: Colors.black54),
                          ),
                        ),
                      ),
                      onPressed: () {
                        _showChoiceDialog(context);
                      },
                      child: Center(
                          child: Text("Choose\nImage")
                      ),
                    ),
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints.tightFor(width: 100.0, height: 55.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.pink[800]),
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.pink[50]),
                        overlayColor: MaterialStateProperty.all<Color>(Colors.pink[100]),
                        shadowColor: MaterialStateProperty.all<Color>(Colors.black38),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(color: Colors.black54),
                          ),
                        ),
                      ),
                      onPressed: () {
                          ApiService().sendImage(imageFile);
                      },
                      child: Text("Know\nMore"),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 1.0, vertical: 0.0),
                    decoration: BoxDecoration(
                      color: Colors.pink[800],
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black38,
                        ),
                      ],
                      border: Border.all(
                        color: Colors.black54,
                        style: BorderStyle.solid,
                      )
                    ),
                    width: 100.0,
                    child: DropdownButton(
                      dropdownColor: Colors.pink[800],
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 32,
                      iconEnabledColor: Colors.pink[50],
                      value: _value,
                      items: [
                        DropdownMenuItem(
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(9.0, 0.0, 0.0, 0.0),
                              child: Text(
                                "English",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.pink[50],
                                ), // style:
                              ),
                            ),
                          ),
                          value: 1,
                        ),
                        DropdownMenuItem(
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(9.0, 0.0, 0.0, 0.0),
                              child: Text(
                                "Hindi",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.pink[50],
                                ), // style:
                              ),
                            ),
                          ),
                          value: 2,
                        ),
                        DropdownMenuItem(
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(9.0, 0.0, 0.0, 0.0),
                              child: Text(
                                "Marathi",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.pink[50],
                                ), // style:
                              ),
                            ),
                          ),
                          value: 3,
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _value = value;
                        });
                        TextRecog(imageFile, _value);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}