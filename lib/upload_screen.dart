import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart'; // For File Upload To Firestore
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // For Image Picker
import 'package:path/path.dart' as Path;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'record.dart';

class UploadPage extends StatefulWidget {
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  File _image;
  String _uploadedFileURL;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firestore File Upload'),
      ),
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Seleccionar imagen'),
            _image != null
                ? Image.asset(
              _image.path,
              height: 150,
            )
                : Container(height: 150),
            _image == null
                ? RaisedButton(
              child: Text('elegir archivo'),
              onPressed: chooseFile,
              color: Colors.cyan,
            )
                : Container(),
            _image != null
                ? RaisedButton(
              child: Text('subir archivo'),
              onPressed: uploadFile,
              color: Colors.cyan,
            )
                : Container(),
            _image != null
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

  Future chooseFile() async {
    await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
      setState(() {
        _image = image;
      });
    });
  }

  Future uploadFile() async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('chats/${Path.basename(_image.path)}}');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;
    print('File Uploaded');

    storageReference.getDownloadURL().then((fileURL) {
      Firestore.instance.runTransaction((transaction) async {
        await transaction.set(Firestore.instance.collection("archives").document(), {
          'kind': 'photo',
          'url': fileURL,
        });
      });
      setState(() {

        _uploadedFileURL = fileURL;
      });
    });
  }

  void clearSelection() {
    setState(() {
      _image = null;
      _uploadedFileURL = null;
    });
  }
}
