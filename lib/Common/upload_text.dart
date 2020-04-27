
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fuerzauy/Common/UploadImageStub.dart'
if (dart.library.io) 'package:fuerzauy/Mobile/upload_text_mobile.dart'
if (dart.library.html) 'package:fuerzauy/Web/UploadImageWeb.dart';
import 'package:fuerzauy/Mobile/upload_text_mobile.dart';
abstract class UploadText {

  Future uploadText(String idUser, String idDestino,String mensaje) async {
    return null;
  }

  factory UploadText() => getUploadText();
}