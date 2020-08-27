import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Api.dart';
import 'package:flutter_app/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mlkit/mlkit.dart';

import 'ErrorPopup.dart';
import 'ProgressDialog.dart';

class FaceDetectPage extends StatefulWidget {
  @override
  _FaceDetectPageState createState() => _FaceDetectPageState();
}

class _FaceDetectPageState extends State<FaceDetectPage> {
  List<VisionFace> _face = <VisionFace>[];

  VisionFaceDetectorOptions options = new VisionFaceDetectorOptions(
      modeType: VisionFaceDetectorMode.Accurate,
      landmarkType: VisionFaceDetectorLandmark.All,
      classificationType: VisionFaceDetectorClassification.All,
      minFaceSize: 0.15,
      isTrackingEnabled: true);

  FirebaseVisionFaceDetector detector = FirebaseVisionFaceDetector.instance;

  File imageURI;
  bool loading = false;
  bool faceIdentified = false;
  String ShowMessage =
      "Please Wait ...\nSystem is recognising your captured image";
  bool detectionFlag = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getImageFromCamera(context);
  }

  Future getImageFromCamera(context) async {
    setState(() {
      loading = true;
      imageURI = null;
      faceIdentified = false;
      ShowMessage =
          "Please Wait ...\nSystem is recognising your captured image";
      detectionFlag = false;
    });
    ImagePicker.pickImage(source: ImageSource.camera).then((image) => {
          setState(() {
            imageURI = image;
          }),
          //  String timestamp = DateTime.now().millisecondsSinceEpoch.toString(),
          //  imageName = name + "_"+timestamp + ".jpg";

          detectFace(image, context)
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(30),
        color: Colors.white,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  imageURI == null
                      ? Text('No image selected.')
                      : Image.file(imageURI,
                          width: 300, height: 200, fit: BoxFit.cover),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    ShowMessage ?? "",
                    style: GoogleFonts.rubik(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  loading
                      ? Container()
                      : InkWell(
                          onTap: () {
                            getImageFromCamera(context);
                          },
                          child: Container(
                            padding: EdgeInsets.all(1),
                            height: 38.0,
                            decoration: ShapeDecoration(
                                color: Colors.blueAccent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.all(
                                      Radius.circular(4.0)),
                                )),
                            child: Center(
                                child: Text(
                              "Check another",
                              style: GoogleFonts.rubik(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            )),
                          ),
                        ),
                ],
              ),
            ),
            loading ? ProgressDialog() : Container(),
          ],
        ),
      ),
    );
  }

  void detectFace(file, context) async {
    detector.detectFromBinary(file?.readAsBytesSync(), options).then((face) => {
          if (face == null || face.length < 1)
            {
              setState(() {
                ShowMessage = "No Face Found ";
                loading = false;
              }),
            }
          else
            {
              //  _face = face,
              api.sendImageLoginResult(imageURI.path).then((value) => {
                    setState(() {
                      loading = false;
                      ShowMessage = value;
                    }),
                    if (value == 'No data' || value == 'Unknown')
                      {
                        Navigator.pushReplacement(
                            context,
                            new MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  MyHomePage(imageURI),
                            )),
                      }
                    else
                      {
                        detectionFlag = true,
                      }
                  }),
            }
        });
  }

  Api api = Api();
}

_Popup(String s, BuildContext context) {
  return Container(
    color: Colors.white,
    child: Column(
      children: [
        Text(
          s,
          style: TextStyle(fontSize: 18, color: Colors.black),
        )
      ],
    ),
  );
}
