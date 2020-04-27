import 'package:flutter/material.dart';
import 'package:fuerzauy/Common/UploadImage.dart';
import 'package:fuerzauy/feed_response_page.dart';

import 'first_screen.dart';

class UploadPage extends StatefulWidget {
  @override
  UploadPageState createState() => UploadPageState();
}

class UploadPageState extends State<UploadPage> {
  Widget image;
  String _uploadedFileURL;
  UploadImage uploader;

  @override
  Widget build(BuildContext context) {
    uploader = new UploadImage();
    return Scaffold(
      appBar: AppBar(
        title: Text('Firestore File Upload'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return FirstScreen();
                })
            );
            
            
          },
        ),
      ),
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Seleccionar imagen'),
            image != null && _uploadedFileURL == null
                ? image
                : Container(height: 150),
            image == null
                ? RaisedButton(
                    child: Text('elegir archivo'),
                    onPressed: chooseFile,
                    color: Colors.cyan,
                  )
                : Container(),
            image != null && _uploadedFileURL == null
                ? RaisedButton(
                    child: Text('subir archivo'),
                    //onPressed: uploadFile,
                    color: Colors.cyan,
                  )
                : Container(),
            image != null
                ? RaisedButton(
                    child: Text('borrar selección'),
                    onPressed: clearSelection,
                  )
                : Container(),
            Text('imagen subida'),
            _uploadedFileURL != null
                ? Image.network(
                    _uploadedFileURL,
                    height: 150,
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  void chooseFile() {
    uploader.chooseFile().then((value) => {
          setState(() {
            image = value;
          })
        });
  }

  /*void uploadFile() {
   // uploader.uploadFile().then((result) => {
          setState(() {
            _uploadedFileURL = result;
          })
        });
  }*/

  void clearSelection() {
    setState(() {
      image = null;
      _uploadedFileURL = null;
    });
  }
}
