import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fuerzauy/Common/UploadImageStub.dart'
    if (dart.library.io) 'package:fuerzauy/Mobile/UploadImageMobile.dart'
    if (dart.library.html) 'package:fuerzauy/Web/UploadImageWeb.dart';

abstract class UploadImage {
  Future<Widget> chooseFile() async {
    return null;
  }

  Future<String> uploadFile(String idUser,String userName, String idDestino,String mensaje,String imageProfile) async {
    return null;
  }

  factory UploadImage() => getUploadImage();
}
