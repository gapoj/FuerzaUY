


import 'dart:convert';

import 'mensaje.dart';

class Mensajes {

  final List<Mensaje> items;

  Mensajes({this.items});

  factory Mensajes.fromJson(String str) => Mensajes.fromMap(json.decode(str));
  factory Mensajes.fromMap(Map<String, dynamic> json) => Mensajes(
    items: json["graphql"] == null
        ? null
        : List<Mensaje>.from(json["graphql"].map((x) => Mensaje.fromMapString(x))),
  );

}