



import 'dart:convert';

import 'package:flutter/material.dart';
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
  final String userRole;


  Mensaje({this.id,this.userName,this.mensaje, this.imageUrl, this.userId, this.videoUrl, this.fecha,this.imgProfile,this.userRole});



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
    assert(map['userRole']!=null);
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
        userName: map['userName'],
        userRole: map['userRole']
    );
  }

  static fromInstagramMap(Map<String,dynamic>map){
    if(map==null) return null;


    assert(map['imageUrl']!=null);
    assert(map['firstComment']!=null);
    assert(map['ownerUsername']!=null);
    assert(map['timestamp']!=null);

    return Mensaje(

        userId:'',
        mensaje:map['firstComment'],
        imageUrl:map['imageUrl'],
        id:'',
        fecha:map['timestamp'],
        videoUrl: '',
        imgProfile: '',
        userName: map['ownerUsername']
    );
  }

  static fromMapString(Map<String,dynamic>json){
    if(json==null) return null;


    assert(json['imageUrl']!=null);
    assert(json['firstComment']!=null);
    assert(json['ownerUsername']!=null);
    assert(json['timestamp']!=null);

    return Mensaje(

        userId:'',
        mensaje:json['firstComment'],
        imageUrl:json['imageUrl'],
        id:'',
        fecha:json['timestamp'],
        videoUrl: '',
        imgProfile: '',
        userName: json['ownerUsername']
    );
  }

  static fromJson(String str) => fromMapStringList(json.decode(str));
  static fromMapStringList(Map<String,dynamic>json){
    if(json==null) return null;


    assert(json['edge']!=null);
    assert(json['imageUrl']!=null);
    assert(json['firstComment']!=null);
    assert(json['ownerUsername']!=null);
    assert(json['timestamp']!=null);

    return Mensaje(

        userId:'',
        mensaje:json['firstComment'],
        imageUrl:json['imageUrl'],
        id:'',
        fecha:json['timestamp'],
        videoUrl: '',
        imgProfile: '',
        userName: json['ownerUsername']
    );
  }
}