



class Mensaje{

  final String mensaje;
  final String imageUrl;
  final String userId;
  final String videoUrl;
  final String fecha;
  final String id;

  Mensaje({this.id,this.mensaje, this.imageUrl, this.userId, this.videoUrl, this.fecha});

  static Mensaje fromMap(Map<String,dynamic>map) {

    if(map==null) return null;

    assert(map['fecha']!=null);
    assert(map['id']!=null);
    assert(map['imageUrl']!=null);
    assert(map['mensaje']!=null);
    assert(map['userId']!=null);
    assert(map['videoUrl']!=null);
    return Mensaje(

        userId:map['userId'],
        mensaje:map['mensaje'],
        imageUrl:map['imageUrl'],
        id:map['id'],
        fecha:map['fecha'],
        videoUrl: map['videoUrl']
    );
  }


}