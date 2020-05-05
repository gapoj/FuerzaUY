
import 'package:flutter/material.dart';
import 'package:fuerzauy/first_screen.dart';
import 'package:fuerzauy/login_page.dart';
import 'package:fuerzauy/shared_preferences.dart';
import 'package:fuerzauy/user_base.dart';
import 'package:flutter/cupertino.dart';

class InitApp extends StatefulWidget{
  @override
  StateInitApp createState() =>StateInitApp();



}

class StateInitApp extends State<InitApp>{


  bool logIn;
  String idFirebase;
  @override
  Widget build(BuildContext context) {
    String  id;
    bool _isLoading = false;

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

                id!=null?iniciar(id):new Container(),
              ],
            ),
          ),
        ),
      );

  }

  iniciar(userId){


    FutureBuilder(
        builder: (context,user) {
          if (user.connectionState == ConnectionState.none &&
              user.hasData == null) {
            return Container();
          }
          if (user.connectionState == ConnectionState.waiting) {
            return splash();
          }

            return user.data == null ? new Container() : Navigator.of(context)
                .push(
              MaterialPageRoute(
                builder: (context) {
                  if (user != null) {
                    return FirstScreen();
                  } else {
                    return LoginPage();
                  }
                },
              ),
            );
          },
        future: checkUser(userId),
    );
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
    getId()async{





    }
}