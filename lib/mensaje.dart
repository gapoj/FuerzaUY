



import 'package:intl/intl.dart';

class Mensaje{

  final String mensaje;
  final String imageUrl;
  final String userId;
  final String videoUrl;
  final String fecha;
  final String id;
  final String imgProfile;
  final String userName;

  Mensaje({this.id,this.userName,this.mensaje, this.imageUrl, this.userId, this.videoUrl, this.fecha,this.imgProfile});

  static Mensaje fromMap(Map<String,dynamic>map) {

    if(map==null) return null;

    assert(map['fecha']!=null);
    assert(map['id']!=null);
    assert(map['imageUrl']!=null);
    assert(map['mensaje']!=null);
    assert(map['userId']!=null);
    assert(map['videoUrl']!=null);
    assert(map['imagenProfile']!=null);
    assert(map['userName']!=null);
    final fechaF = new DateFormat('dd-MM-yyyy');
    int valorFecha=int.parse(map['fecha']);
    String fechaMensaje=fechaF.format(new DateTime.fromMicrosecondsSinceEpoch(valorFecha*1000));
    return Mensaje(

        userId:map['userId'],
        mensaje:map['mensaje'],
        imageUrl:map['imageUrl'],
        id:map['id'],
        fecha:fechaMensaje ,
        videoUrl: map['videoUrl'],
        imgProfile: map['imagenProfile'],
        userName: map['userName']
    );
  }


}