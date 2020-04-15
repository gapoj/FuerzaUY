import 'dart:typed_data';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fuerzauy/Common/UploadImage.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:image_picker_web/image_picker_web.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UploadImageWeb implements UploadImage {
  static Uint8List imagebytes;

  Future<Widget> chooseFile() async {
    UploadImageWeb.imagebytes =
        await ImagePickerWeb.getImage(outputType: ImageType.bytes);
    Image fromPicker = Image.memory(UploadImageWeb.imagebytes);
    if (fromPicker != null) {
      return fromPicker;
    } else {
      return null;
    }
  }

  Future<String> uploadFile() async {
    Uuid uuid = Uuid();
    fb.StorageReference storageReference = fb
        .storage()
        .refFromURL('gs://fuerzauy-c7e52.appspot.com/chats')
        .child('${uuid.v4()}.jpg');
    fb.UploadTaskSnapshot uploadTask =
        await storageReference.put(UploadImageWeb.imagebytes).future;
    String url = (await uploadTask.ref.getDownloadURL()).toString();
    Firestore.instance.runTransaction((transaction) async {
      await transaction
          .set(Firestore.instance.collection("archives").document(), {
        'kind': 'photo',
        'url': url,
      });
    });

    return url;
  }
}

UploadImage getUploadImage() => UploadImageWeb();
