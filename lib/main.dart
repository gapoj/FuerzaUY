//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
///import 'package:firebase_auth/firebase_auth.dart';
import 'login_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}
