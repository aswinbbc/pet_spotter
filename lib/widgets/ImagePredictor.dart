import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class MyImagePicker extends StatefulWidget {
  const MyImagePicker({Key? key}) : super(key: key);

  @override
  MyImagePickerState createState() => MyImagePickerState();
}

class MyImagePickerState extends State {
  File? imageURI;
  String? result;
  String? path;
  @override
  void initState() {
    getImageFromCamera();
    super.initState();
  }

  Future getImageFromCamera() async {
    var image = await ImagePicker().pickImage(source: ImageSource.camera);

    setState(() {
      imageURI = File(image!.path);
      path = image.path;
    });
    classifyImage();
  }

  Future getImageFromGallery() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      imageURI = File(image!.path);
      path = image.path;
    });
    classifyImage();
  }

  Future classifyImage() async {
    await Tflite.loadModel(
        model: "assets/dogo_unquant.tflite", labels: "assets/dogo.txt");
    var output = await Tflite.runModelOnImage(
        path: path!,
        numResults: 20,
        imageMean: 127.5,
        imageStd: 127.5,
        threshold: 0.6);

    setState(() {
      result = output!.first['label'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            imageURI == null
                ? Text('No image selected.')
                : Image.file(imageURI!,
                    width: 300, height: 200, fit: BoxFit.cover),
            Container(
                margin: EdgeInsets.fromLTRB(0, 30, 0, 20),
                child: ElevatedButton(
                  onPressed: () => getImageFromCamera(),
                  child: Text('Click Here To Select Image From Camera'),
                )),
            Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: RaisedButton(
                  onPressed: () => getImageFromGallery(),
                  child: Text('Click Here To Select Image From Gallery'),
                  textColor: Colors.white,
                  color: Colors.blue,
                  padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                )),
            // Container(
            //     margin: EdgeInsets.fromLTRB(0, 30, 0, 20),
            //     child: RaisedButton(
            //       onPressed: () => classifyImage(),
            //       child: Text('Classify Image'),
            //       textColor: Colors.white,
            //       color: Colors.blue,
            //       padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
            //     )),
            result != null
                ? Container(
                    margin: EdgeInsets.all(50.0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xFFF8F2F7),
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(
                        width: 8.0,
                        color: Color(0xFFFED8D3),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        result!,
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  )
                : Text("")
          ],
        ),
      ),
    );
  }
}
