import 'package:flutter/material.dart';
import 'package:fuerzauy/feed_base.dart';
import 'mensaje.dart';
import 'login_page.dart';
import 'sign_in.dart';
import 'upload_screen.dart';
import 'feed_page.dart';

class FirstScreen extends StatelessWidget {
  Mensaje mensaje;
  @override
  Widget build(BuildContext context) {

    return MaterialApp(

        home:
       Scaffold(
         backgroundColor: Colors.white70,
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(

                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage('assets/logo.png'),),
                ),

              ),
              ListTile(
                title: Text('Mensajes Recibidos'),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                  MaterialPageRoute(
                  builder: (context) {
                    return FeedPage();
                  },
                  ),
                  );

                },
              ),
              Divider(
                height: 20.0,
                color: Colors.grey,

              ),
              ListTile(
                title: Text('Crear Mensaje'),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return UploadPage();
                      },
                    ),
                  );

                },
              ),
              Divider(
                height: 20.0,
                color: Colors.grey,

              ),
            ],
          ),
        ),
        appBar: AppBar(

      title: Text("Fuerza Uruguay"),

          actions: <Widget>[

            CircleAvatar(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              ),
              backgroundImage: NetworkImage(
                imageUrl,
              ),
              radius: 30,

              backgroundColor: Colors.transparent,
            ),
            SizedBox(height: 30),
            RaisedButton(
              onPressed: () {
                signOutGoogle();
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) {return LoginPage();}), ModalRoute.withName('/'));
              },
              color: Colors.deepPurple,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  'Salir',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
          ],
        ),
      body:

        FutureBuilder(

          builder: (context, listado) {


          if (listado.connectionState == ConnectionState.none &&
          listado.hasData == null) {

          return Container();
        }

        return listado.data==null? Container(): ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.all(15.0),
          itemCount: listado.data.length,
          itemBuilder: (context, position) {
            mensaje = Mensaje.fromMap(listado.data[position]);

            if (mensaje.imageUrl != "") {
              return conImagen();
            }else if(mensaje.videoUrl!=""){
              return conVideo();
            }else{
              return soloTexto();
            }
          }
        );
        },

          future: listadoMensajes(),

        ),



      ),

      );


  }
  Widget conImagen(){
    return Column(

        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[

          Card(

              color: Colors.white,
              child: Column(

                children: <Widget>[

                  new Container(

                      padding: const EdgeInsets.all(8.0),

                      child:

                      Image.network(
                          mensaje.imageUrl
                      )),
                  Divider(
                    height: 20.0,
                    color: Colors.grey,

                  ),
                  new Container(

                    padding: const EdgeInsets.all(10),
                    child:
                    Column(
                      mainAxisAlignment: MainAxisAlignment
                          .spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,


                      children: <Widget>[


                        Text(mensaje.mensaje,

                          style: TextStyle(
                            fontSize: 16.0,

                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.none,


                          ),
                        ),

                      ],
                    ),

                  )
                ],

                crossAxisAlignment: CrossAxisAlignment.center,
              )
          ),

        ]

    );
  }

  Widget soloTexto(){
    return Column(

        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[

          Card(

              color: Colors.white,
              child: Column(

                children: <Widget>[


                  new Container(

                    padding: const EdgeInsets.all(20),
                    child:
                    Column(
                      mainAxisAlignment: MainAxisAlignment
                          .spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,


                      children: <Widget>[


                        Text(mensaje.mensaje,

                          style: TextStyle(
                            fontSize: 16.0,

                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.none,


                          ),
                        ),

                      ],
                    ),

                  )
                ],

                crossAxisAlignment: CrossAxisAlignment.center,
              )
          ),

        ]

    );
  }

  Widget conVideo(){
    return Column(

        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[

          Card(

              color: Colors.white,
              child: Column(

                children: <Widget>[

                  new Container(

                      padding: const EdgeInsets.all(8.0),

                      child:

                      Image.network(
                          mensaje.videoUrl
                      )),
                  Divider(
                    height: 20.0,
                    color: Colors.grey,

                  ),
                  new Container(

                    padding: const EdgeInsets.all(10),
                    child:
                    Column(
                      mainAxisAlignment: MainAxisAlignment
                          .spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,


                      children: <Widget>[


                        Text(mensaje.mensaje,

                          style: TextStyle(
                            fontSize: 16.0,

                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.none,


                          ),
                        ),

                      ],
                    ),

                  )
                ],

                crossAxisAlignment: CrossAxisAlignment.center,
              )
          ),

        ]

    );
  }
}
