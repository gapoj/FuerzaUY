import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fuerzauy/first_screen.dart';
import 'package:fuerzauy/sign_in.dart';
import 'package:fuerzauy/departamento_salud.dart';
import 'user_base.dart';

int profile=-1;

class UserProfilePage extends StatefulWidget {
  UserProfilePage() : super();

  @override
  _UserProfilePage createState() => _UserProfilePage();
}

class _UserProfilePage extends State<UserProfilePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.blue[100], Colors.blue[400]],
          ),
        ),
        child: Center(
          child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Integras el personal de la salud?',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54),
                ),
                new Padding(
                  padding: new EdgeInsets.all(20.0),
                  child: new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Radio(
                          value: 0,
                          groupValue: profile,
                          onChanged: (int value) {
                            setState(() {
                              profile = value;
                            });
                          },
                        ),
                        new Text(
                          'No',
                          style: new TextStyle(fontSize: 16.0),
                        ),
                        new Radio(
                          value: 1,
                          groupValue: profile,
                          onChanged: (int value) {
                            setState(() {
                              profile = value;
                            });
                          },
                        ),
                        new Text(
                          'Si',
                          style: new TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ]),
                ),
              RaisedButton(
                  onPressed: () {
                    if(profile!=-1) {
                      if (profile == 0) {
                        createProfile(id, profile, '').whenComplete(() {
                          if (true) {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return FirstScreen();
                            }));
                          }
                        });
                      } else {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return DepartamentoSaludPage();
                        }));
                      }
                    }else{
                      Fluttertoast.showToast(
                          msg: "Selecciona a una opción por favor.",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.CENTER,
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                  },
                  color: Colors.deepPurple,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Aceptar',
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                  ),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)),
                ),
              ]),
        ),
      ),
    );
  }
}
