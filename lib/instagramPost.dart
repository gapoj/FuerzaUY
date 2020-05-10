



import 'package:intl/intl.dart';

class InstagramPost{

  final String id;
  final String ownerUserName;
  final String mensaje;
  final String imageUrl;
  final String fecha;
  final String url;
  final bool valido;

  InstagramPost({this.id,this.ownerUserName,this.mensaje, this.imageUrl, this.fecha,this.url, this.valido});

  static InstagramPost fromMap(Map<String,dynamic>map) {

    if(map==null) return null;
    assert(map['itemID']!=null);
    assert(map['ownerUsername']!=null);
    assert(map['firstComment']!=null);
    assert(map['imageUrl']!=null);
    assert(map['timestamp']!=null);
    assert(map['url']!=null);
    assert(map['valido']!=null);

    final fechaF = new DateFormat('dd-MM-yyyy');
    int year =int.parse(map['timestamp'].toString().substring(0,4));
    int month= int.parse(map['timestamp'].toString().substring(5,7));
    int day =int.parse(map['timestamp'].toString().substring(8,10));
    String fechaMensaje=fechaF.format(new DateTime(year,month ,day));
    return InstagramPost(
        id:map['itemID'],
        ownerUserName: map['ownerUsername'],
        mensaje:map['firstComment'],
        imageUrl:map['imageUrl'],
        fecha:fechaMensaje ,
        url: map['url'],
        valido: map['valido']
    );
  }
}