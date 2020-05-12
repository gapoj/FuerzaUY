import 'package:cloud_firestore/cloud_firestore.dart';
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

import 'package:fuerzauy/instagramPost.dart';

class ValidateInstagramScreen extends StatelessWidget {
  String colectionName="instagram-fuerza-uruguay-WID";

  ValidateInstagramScreen(String colectionName) {
    this.colectionName=colectionName;
  }
  @override
  Widget build(BuildContext context) {
    String userRole = baseUsuario.userRole;
    InstagramPost instagramPost;
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
                      guardaridFirebase(null);
                      return LoginPage();
                    }), ModalRoute.withName('/'));
              },
              color: Colors.white,
            ),
          ],
        ),
        body: StreamBuilder(
          stream: Firestore.instance
            .collection(colectionName)
            .orderBy('likesCount',descending: true)
            .where('valido', isEqualTo: false)
            .limit(30)
            .snapshots(),
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
                itemCount: listado.data.documents.length,
                itemBuilder: (context, position) {
                    instagramPost = InstagramPost.fromMap(listado.data.documents[position].data );
                    return instagramWidget(instagramPost, context) ;
                  }
                );
          },

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


 void enviar(String documentId){
  Firestore.instance.collection(colectionName).document(documentId).updateData({'valido':true});
 }

  void eliminar(String documentId){
    Firestore.instance.collection(colectionName).document(documentId).delete();
  }

  Widget instagramWidget(InstagramPost msj, BuildContext context) {
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
                new Container(
                  padding: EdgeInsets.only(left: 12.0),
                  child: Row(
                    children: [
                      Text(
                        msj.ownerUserName,
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
                        msj.fecha,
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
                       Row(
                         children:<Widget>[
                           MaterialButton(
                             minWidth: 100.0,
                             height: 40.0,
                             child: Text('Validar',
                                 style: TextStyle(color: Colors.white, fontSize: 25)),
                             onPressed: (){enviar(msj.id);},
                             color: Colors.green,
                             shape: RoundedRectangleBorder(
                                 borderRadius: BorderRadius.circular(5)),
                           ),
                           MaterialButton(
                             minWidth: 100.0,
                             height: 40.0,
                             child: Text('Eliminar',
                                 style: TextStyle(color: Colors.white, fontSize: 25)),
                             onPressed: (){eliminar(msj.id);},
                             color: Colors.redAccent,
                             shape: RoundedRectangleBorder(
                                 borderRadius: BorderRadius.circular(5)),
                           )
                         ]
                       )
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
}
