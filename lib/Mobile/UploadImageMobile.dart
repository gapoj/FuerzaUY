import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart'; // For File Upload To Firestore
import 'package:image_picker/image_picker.dart'; // For Image Picker
import 'package:path/path.dart' as Path;
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Common/UploadImage.dart';

class UploadImageMobile implements UploadImage {
  static File imageMobile;

  Future<Widget> chooseFile() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    UploadImageMobile.imageMobile = image;
    return Image.file(image);
  }

  Future<String> uploadFile() async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('chats/${Path.basename(UploadImageMobile.imageMobile.path)}');
    StorageUploadTask uploadTask =
        storageReference.putFile(UploadImageMobile.imageMobile);

    await uploadTask.onComplete;
    print('File Uploaded');

    String fileURL = await storageReference.getDownloadURL();
    await Firestore.instance.runTransaction((transaction) async {
      await transaction
          .set(Firestore.instance.collection("archives").document(), {
        'kind': 'photo',
        'url': fileURL,
      });
    });

    return fileURL;
  }
}

UploadImage getUploadImage() => UploadImageMobile();
