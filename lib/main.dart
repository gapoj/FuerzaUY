//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fuerzauy/first_screen.dart';
import 'package:fuerzauy/init_app.dart';
import 'package:fuerzauy/shared_preferences.dart';
import 'package:fuerzauy/user_base.dart';

///import 'package:firebase_auth/firebase_auth.dart';
import 'login_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future id;

  @override
  Widget build(BuildContext context) {
    @override
    void initState() {
      super.initState();
      id = getFirebaseId();
    }

    return MaterialApp(
        title: 'Fuerza Uruguay',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          body: FutureBuilder(
              future: getFirebaseId(),
              builder: (context, userId) {
                if (userId.connectionState == ConnectionState.waiting) {
                  return splash();
                }
                if (userId.hasData) {
                  if(userId.data!=null) {
                    checkUser(userId.data).whenComplete(() {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        if (user != null) {
                          return FirstScreen();
                        } else {
                          return LoginPage();
                        }
                      }));
                    });
                  }else{
                    Navigator.of(context).push(MaterialPageRoute(builder: (context){
                      return LoginPage();
                    }));
                  }
                }else{
                  return LoginPage();
                }
                return splash();

              }),
        ));
  }

  Widget splash() {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(
                image: AssetImage('assets/logo.png'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

