import 'package:flutter/material.dart';
import 'package:fuerzauy/detalle_imagen_listview.dart';
import 'package:fuerzauy/mensaje_base.dart';
import 'package:fuerzauy/mensaje_nuevo.dart';
import 'package:fuerzauy/shared_preferences.dart';
import 'mensaje.dart';
import 'login_page.dart';
import 'mensajes_recibidos.dart';
import 'sign_in.dart';
import 'user_base.dart' as baseUsuario;
import 'upload_screen.dart';
import 'feed_response_page.dart';

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String userRole = baseUsuario.userRole;
    Mensaje mensaje;
    return MaterialApp(

      home: Scaffold(
        backgroundColor: Colors.white70,
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/logo.png'),
                  ),
                ),
              ),
              ListTile(
                title: Text('Mensajes Recibidos'),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return MensajesRecibidos();
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
                        return MensajeEnvio();
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
                padding: const EdgeInsets.all(8.0),
              ),
              backgroundImage: NetworkImage(
                baseUsuario.user.imageUrl,
              ),
              radius: 30,
              backgroundColor: Colors.transparent,
            ),
            SizedBox(height: 30),
            IconButton(
              icon: Icon(Icons.person_outline),
              iconSize: 40,
              onPressed: () {
                signOutGoogle();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) {
                      guardaridFirebase('');
                      return LoginPage();
                    }), ModalRoute.withName('/'));
              },
              color: Colors.white,
            ),
          ],
        ),
        body: FutureBuilder(
          builder: (context, listado) {
            if (listado.connectionState == ConnectionState.none &&
                listado.hasData == null) {
              return Container();
            }
            if (listado.connectionState == ConnectionState.waiting) {
              return load();
            }

            return listado.data == null
                ? Container()
                : ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.all(1.0),
                itemCount: listado.data.length,
                itemBuilder: (context, position) {
                  mensaje = Mensaje.fromMap(listado.data[position]);

                  if (userRole == "0") {
                    if (mensaje.imageUrl != "") {
                      return conImagen(mensaje, context);
                    } else if (mensaje.videoUrl != "") {
                      return conVideo(mensaje, context);
                    } else {
                      return soloTexto(mensaje, context);
                    }
                  } else {
                    return getRolSalud(mensaje, context);
                  }
                });
          },
          future: listadoMensajes(),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.create),
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          tooltip: 'Crear Mensaje',
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return MensajeEnvio();
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Widget conImagen(Mensaje msj, BuildContext context) {
    return Column(children: <Widget>[
      Column(children: <Widget>[
        new Container(
            color: Colors.white,
            constraints: BoxConstraints(minWidth: 100, maxWidth: 500),
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Sección izquierda
                new Container(
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(msj.imgProfile),
                        radius: 25.0,
                      ),
                    ],
                  ),
                ),
                new Container(
                  padding: EdgeInsets.only(left: 12.0),
                  child: Row(
                    children: [
                      Text(
                        msj.userName,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  ),
                ),
                new Container(
                  padding: EdgeInsets.only(left: 12.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        '10:21',
                        style: TextStyle(
                          color: Colors.green[700],
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )),
        new Container(
            color: Colors.white,
            constraints: BoxConstraints(minWidth: 100, maxWidth: 500),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(70, 0, 10, 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        InkWell(

                          child: Container(

                              height: 200,

                              decoration: BoxDecoration(

                                  borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(msj.imageUrl),
                                  ))),
                          onTap: () {
                            Navigator
                                .push(context,MaterialPageRoute(builder: (context)
                            =>
                                DetalleImagenLV(msj.imageUrl)
                            )
                            );

                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        ),
                        Text(
                          msj.mensaje,
                          style: TextStyle(
                            fontSize: 18.0,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )),
      ]),
      Divider(
        height: 1.0,
        color: Colors.grey,
      ),
    ]);
  }

  Widget soloTexto(Mensaje msj, BuildContext context) {
    return Column(children: <Widget>[
      Column(children: <Widget>[
        new Container(
            color: Colors.white,
            constraints: BoxConstraints(minWidth: 100, maxWidth: 500),
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Sección izquierda
                new Container(
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(msj.imgProfile),
                        radius: 25.0,
                      ),
                    ],
                  ),
                ),
                new Container(
                  padding: EdgeInsets.only(left: 12.0),
                  child: Row(
                    children: [
                      Text(
                        msj.userName,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  ),
                ),
                new Container(
                  padding: EdgeInsets.only(left: 12.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        '10:21',
                        style: TextStyle(
                          color: Colors.green[700],
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )),
        new Container(
            color: Colors.white,
            constraints: BoxConstraints(minWidth: 100, maxWidth: 500),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(70, 10, 10, 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          msj.mensaje,
                          style: TextStyle(
                            fontSize: 18.0,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )),
      ]),
      Divider(
        height: 1.0,
        color: Colors.grey,
      ),
    ]);
  }

  Widget conVideo(Mensaje msj, BuildContext context) {
    return Column(children: <Widget>[
      Column(children: <Widget>[
        new Container(
            color: Colors.white,
            constraints: BoxConstraints(minWidth: 100, maxWidth: 500),
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Sección izquierda
                new Container(
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(msj.imgProfile),
                        radius: 25.0,
                      ),
                    ],
                  ),
                ),
                new Container(
                  padding: EdgeInsets.only(left: 12.0),
                  child: Row(
                    children: [
                      Text(
                        msj.userName,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  ),
                ),
                new Container(
                  padding: EdgeInsets.only(left: 12.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        '10:21',
                        style: TextStyle(
                          color: Colors.green[700],
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )),
        new Container(
            color: Colors.white,
            constraints: BoxConstraints(minWidth: 100, maxWidth: 500),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(70, 0, 10, 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            height: 200,
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(msj.imageUrl),
                                ))),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        ),
                        Text(
                          msj.mensaje,
                          style: TextStyle(
                            fontSize: 20.0,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )),
      ]),
      Divider(
        height: 1.0,
        color: Colors.grey,
      ),
    ]);
  }

  Widget load() {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[new CircularProgressIndicator()],
          ),
        ),
      ),
    );
  }

  Widget getRolSalud(Mensaje msj, BuildContext context) {
    if (msj.imageUrl != "") {
      return Column(children: <Widget>[
        Card(
          color: Colors.white,
          child: Column(children: <Widget>[
            new Container(
                constraints: BoxConstraints(minWidth: 100, maxWidth: 500),
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    // Sección izquierda

                    CircleAvatar(
                      backgroundImage: NetworkImage(msj.imgProfile),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          '10:21',
                          style: TextStyle(
                            color: Colors.green[700],
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
            new Container(
                constraints: BoxConstraints(minWidth: 100, maxWidth: 500),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(60, 10, 10, 10),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Image.network(
                              msj.imageUrl,
                              height: 300,
                              fit: BoxFit.contain,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                            ),
                            Text(
                              msj.mensaje,
                              style: TextStyle(
                                fontSize: 20.0,
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
            new Container(
              constraints: BoxConstraints(minWidth: 100, maxWidth: 500),
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    RaisedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return FeedResponsePage(msj.userId,msj.userName, msj.imgProfile,
                                  msj.imageUrl, msj.mensaje);
                            },
                          ),
                        );
                      },
                      color: Colors.lightBlue,
                      child: Text(
                        'Responder',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                    ),
                  ],
                ),
              ]),
            ),
          ]),
        )
      ]);
    } else if (msj.videoUrl != "") {
      return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <
          Widget>[
        Card(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                new Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                              ),
                              backgroundImage: NetworkImage(
                                msj.imgProfile,
                              ),
                              radius: 20,
                              backgroundColor: Colors.transparent,
                            ),
                            Text(
                              "4:08 PM",
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ]),
                    ],
                  ),
                ),
                new Container(
                    padding: const EdgeInsets.fromLTRB(60, 10, 10, 10),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(50, 10, 10, 10),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Image.network(msj.imageUrl),
                                Text(
                                  msj.mensaje,
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )),
                new Container(
                  padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.bottomRight,
                        child: RaisedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return FeedResponsePage(msj.userId,msj.userName, msj.imgProfile,
                                      msj.imageUrl, msj.mensaje);
                                },
                              ),
                            );
                          },
                          color: Colors.lightBlue,
                          child: Text(
                            'Responder',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                        ),
                      ),
                    ],
                  ),
                )
              ],
              crossAxisAlignment: CrossAxisAlignment.center,
            )),
      ]);
    } else {
      return Column(children: <Widget>[
        Card(
          color: Colors.white,
          child: Column(children: <Widget>[
            new Container(
                constraints: BoxConstraints(minWidth: 100, maxWidth: 500),
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    // Sección izquierda

                    CircleAvatar(
                      backgroundImage: NetworkImage(msj.imgProfile),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          '10:21',
                          style: TextStyle(
                            color: Colors.green[700],
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
            new Container(
                constraints: BoxConstraints(minWidth: 100, maxWidth: 500),
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 40.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              msj.mensaje,
                              style: TextStyle(
                                fontSize: 20.0,
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
            new Container(
              constraints: BoxConstraints(minWidth: 100, maxWidth: 500),
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 10),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.bottomRight,
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return FeedResponsePage(msj.userId,msj.userName, msj.imgProfile, null,
                                  msj.mensaje);
                            },
                          ),
                        );
                      },
                      color: Colors.lightBlue,
                      child: Text(
                        'Responder',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                    ),
                  ),
                ],
              ),
            )
          ]),
        )
      ]);
    }
  }
}
