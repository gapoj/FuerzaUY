import 'package:fuerzauy/user_base.dart';
import 'user.dart';
import 'mensaje.dart';
import 'sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//Mensaje mensaje;

final CollectionReference _mensajesCollectionReference =
    Firestore.instance.collection('archives2');

Future listadoMensajes() async {
  var mensajes = await _mensajesCollectionReference
      .where('idDestino', isEqualTo: "")
      .orderBy('fecha',descending: true)
      .getDocuments();
  List<DocumentSnapshot> templist;
  List<Map<dynamic, dynamic>> list = new List();
  templist = mensajes.documents;
  list = templist.map((DocumentSnapshot docSnapshot) {
    //mensaje=Mensaje.fromMap(docSnapshot.data);

    return docSnapshot.data;
  }).toList();
  return list;
}

Future listadoMensajesXId(String id) async {
  var mensajes = await _mensajesCollectionReference
      .where('idDestino', isEqualTo: id)
      .getDocuments();

  //imagenDestinoUrl=user.imageUrl;
  List<DocumentSnapshot> templist;
  List<Map<dynamic, dynamic>> list = new List();
  templist = mensajes.documents;
  DocumentSnapshot doc = templist.elementAt(0);
  //mensaje=Mensaje.fromMap(doc.data);
  list = templist.map((DocumentSnapshot docSnapshot) {
    //user= User.fromMap(docSnapshot.data);

    return docSnapshot.data;
  }).toList();
  return list;
}
