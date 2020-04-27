import 'package:flutter/material.dart';
import 'package:fuerzauy/user.dart';
import 'package:fuerzauy/user_base.dart';
import 'package:fuerzauy/user_profile_page.dart';
import 'sign_in.dart';
import 'first_screen.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
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
              SizedBox(height: 50),
              _signInButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _signInButton() {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () {

          signInWithGoogle().whenComplete(() {
            if (name != null) {
              checkUser(id).whenComplete(() {
                _isLoading=!_isLoading;
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      if (user != null) {
                        return FirstScreen();
                      } else {
                        return UserProfilePage();
                      }
                    },
                  ),
                );
              });
            }
          });

      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/google_logo.png"), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }


}
