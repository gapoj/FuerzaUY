


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fuerzauy/Common/upload_text.dart';
import 'package:intl/intl.dart';

class UploadTextMobile implements UploadText{

  @override
  Future<String> uploadText(String idUser, String idDestino, String mensaje,String imageProfile,String userName,String userRole) async {
    await Firestore.instance.runTransaction((transaction) async {

      await transaction
          .set(Firestore.instance.collection("archives2").document(), {
        'fecha': DateTime.now().millisecondsSinceEpoch.toString(),//fecha.format(new DateTime.fromMicrosecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch*1000)),
        'id': '',
        'imageUrl':'',
        'mensaje':mensaje,
        'userId':idUser,
        'idDestino':idDestino,
        'imagenProfile':imageProfile,
        'videoUrl':'',
        'userName':userName,
        'userRole':userRole,


      });
    });
    return mensaje;
  }


}
UploadText getUploadText() => UploadTextMobile();