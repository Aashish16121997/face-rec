import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_app/FaceDetectPage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Api.dart';
import 'ProgressDialog.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FaceDetectPage(),
     // home: MyHomePage(title: 'Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  File imageURI;
  MyHomePage(this.imageURI);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final formKey = GlobalKey<FormState>();
  String name;
  String imageName="";
  Api api = Api();
  bool loading = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register Page"),
      ),
      body: Container(
        margin: EdgeInsets.all(30),
        child: Stack(
          children: [
            Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 30.0,
                  ),
                  imageName.contains("successfully")?Container():TextFormField(
                    autofocus: true,
                    style: GoogleFonts.rubik(fontSize: 16.0, color: Colors.black),
                    decoration: InputDecoration(labelText: "Enter Name"),
                    validator: (input) =>
                        input.isEmpty ? "Name Can't be empty" : null,
                    onSaved: (input) => name = input,
                  ),
                  imageName.contains("successfully")?Center(
                    child: Text(name+"\n"+
                        imageName ?? ""),
                  ):Container(),
                  SizedBox(
                    height: 30.0,
                  ),
                  loading?Container():InkWell(
                    onTap: () {
                      if(imageName.contains("successfully")){
                        Navigator.pushReplacement(
                            context,
                            new MaterialPageRoute(
                              builder: (BuildContext
                              context) =>
                                  FaceDetectPage(),
                            ));
                      }else{
                      if (formKey.currentState.validate()) {
                      formKey.currentState.save();
                      setState(() {
                      loading = true;
                      });
                      api.sendImageRegisterResult(name, widget.imageURI.path).then((value) => {
                      setState(() {
                      String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
                      name = name + "_"+timestamp + ".jpg";
                      imageName = value==''?"You have successfully registered":value;
                      loading = false;
                      }),

                      });
                      }
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(1),
                      height: 38.0,
                      decoration: ShapeDecoration(
                          color: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                new BorderRadius.all(Radius.circular(4.0)),
                          )),
                      child: Center(
                          child: Text(
                            imageName.contains("successfully")?"Check Again":"Submit",
                        style: GoogleFonts.rubik(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      )),
                    ),
                  ),
                SizedBox(height: 30),
                widget.imageURI == null
                    ? Text('No image selected.')
                    : Image.file( widget.imageURI, width: 300, height: 200, fit: BoxFit.cover),

                ],
              ),
            ),
            loading ? ProgressDialog() : Container(),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

/*  Future getImageFromCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      imageURI = image;
      String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      imageName = name + "_"+timestamp + ".jpg";
    });
  }*/

}
