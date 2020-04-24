
import 'package:fuerzauy/first_screen.dart';

import 'sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fuerzauy/user.dart';
import 'sign_in.dart';


  final CollectionReference _usersCollectionReference=Firestore.instance.collection('users');


User user;



  Future createProfile (String pId,int userRole,String departamento) async {

    try{

     await _usersCollectionReference.document(id).setData(User(id:pId,fullName: fullName,email: email,userRole: userRole.toString(),imageUrl: imageUrl, departamento:departamento).toMap());
     return true;
    }catch(e){
      return e.toString();
    }
      
  }



  Future checkUser(String pId) async{
    try {

      var userData = await _usersCollectionReference.document(pId).get();
      user= User.fromMap(userData.data);
      return user;
    }catch(e){
      return e.toString();
    }
  }

    Future listadoXRol(String pRol) async{
    try {

      var userData =await _usersCollectionReference.where('userRole', isEqualTo: pRol).getDocuments() ;
      List<DocumentSnapshot> templist;
      List<Map<dynamic, dynamic>> list = new List();
      templist = userData.documents;
      list = templist.map((DocumentSnapshot docSnapshot){
        //user= User.fromMap(docSnapshot.data);
        return docSnapshot.data;
      }).toList();
      //list.add(user.toMap());
      return list;

    }catch(e){
      return e;
    }


  }

  Future listadolXDepartamento( String pDepartamento)async{
    try {

      var userData =await _usersCollectionReference.where('departamento', isEqualTo: pDepartamento).getDocuments() ;
      List<DocumentSnapshot> templist;
      List<Map<dynamic, dynamic>> list = new List();
      templist = userData.documents;
      list = templist.map((DocumentSnapshot docSnapshot){
        //user= User.fromMap(docSnapshot.data);
        return docSnapshot.data;
      }).toList();
      //list.add(user.toMap());
      return list;

    }catch(e){
      return e;
    }
  }

