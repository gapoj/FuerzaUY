

import 'package:fuerzauy/sign_in.dart';

class User{

  final String id;
  final String fullName;
  final String imageUrl;
  final String email;
  final String userRole;
  final String departamento;

  User({
    this.id,
    this.fullName,
    this.email,
    this.userRole,
    this.imageUrl,
    this.departamento

  });

  static User fromMap(Map<String,dynamic>map){
      if(map==null) return null;
      return User(
        id:map['id'],
        fullName:map['name'],
        imageUrl:map['imageUrl'],
        userRole:map['userRole'],
        email:map['email'],
        departamento: map['departamento']
      );
  }



  Map<String, dynamic> toMap() {
    return {
      'id':id,
      'name': fullName,
      'email': email,
      'userRole': userRole,
      'imageUrl':imageUrl,
      'departamento':departamento
    };
  }

  String getImageUrl(){
    return imageUrl;
  }
}