
import 'mensaje.dart';
import 'sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

  Mensaje mensaje;

  final CollectionReference _mensajesCollectionReference=Firestore.instance.collection('archives2');

  Future listadoMensajes() async{
    var mensajes=await _mensajesCollectionReference.getDocuments();
    List<DocumentSnapshot> templist;
    List<Map<dynamic, dynamic>> list = new List();
    templist=mensajes.documents;
    list = templist.map((DocumentSnapshot docSnapshot){
      //user= User.fromMap(docSnapshot.data);
      return docSnapshot.data;
    }).toList();
    return list;
  }