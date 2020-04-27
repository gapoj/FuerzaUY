


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fuerzauy/Common/upload_text.dart';

class UploadTextMobile implements UploadText{
  @override
  Future<String> uploadText(String idUser, String idDestino, String mensaje) async {
    await Firestore.instance.runTransaction((transaction) async {
      await transaction
          .set(Firestore.instance.collection("archives2").document(), {
        'fecha': '',
        'id': '',
        'imageUrl':'',
        'mensaje':mensaje,
        'userId':idUser,
        'idDestino':idDestino,
        'videoUrl':'',

      });
    });
    return mensaje;
  }


}
UploadText getUploadText() => UploadTextMobile();