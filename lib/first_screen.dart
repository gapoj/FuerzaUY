import 'dart:convert';

import 'package:async/async.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fuerzauy/detalle_imagen_listview.dart';
import 'package:fuerzauy/mensaje_base.dart';
import 'package:fuerzauy/mensaje_nuevo.dart';
import 'package:fuerzauy/shared_preferences.dart';
import 'package:html/dom.dart' as html;
import 'package:html/parser.dart' as phtml;
import 'package:http/http.dart' ;
import 'mensaje.dart';
import 'login_page.dart';
import 'mensajes.dart';
import 'mensajes_recibidos.dart';
import 'sign_in.dart';
import 'user_base.dart' as baseUsuario;
import 'upload_screen.dart';
import 'feed_response_page.dart';
import 'dart:async';
import 'package:rxdart/rxdart.dart';



class FirstScreen extends StatefulWidget {
  @override
  FirstScreenState createState() => FirstScreenState();
}

class FirstScreenState extends State<FirstScreen> {
  ScrollController _scrollController;




  _scrollToTop() {
    _scrollController.animateTo(_scrollController.position.minScrollExtent,
        duration: Duration(milliseconds: 500), curve: Curves.easeIn);
  }

  /*Future<List<Mensaje>> initiate() async {
    // Make API call to Hackernews homepage
    var client = Client();
    Response response = await client.get('https://www.instagram.com/explore/tags/fuerzauruguay?__a=1');





    return parseMessages(response.body);
  }
  Mensajes msjs;
  List<Mensaje> parseMessages(String responseBody) {
    //final parsed = json.decode(responseBody);
    msjs= Mensajes.fromJson(responseBody);
    return msjs.items;
   // return responseBody.map<Mensaje>((json) => Mensajes.fromJson(json)).toList();
  }*/
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
   // initiate();

  }

  var url = 'https://example.com/whatsit/create';

  Future<Response>listadoInstagram(Client client) async {
    return client.get('https://www.instagram.com/explore/tags/fuerzauruguay/');
  }

  @override
  Widget build(BuildContext context) {
    //String userRole = '1';


    Stream mensajes = Firestore.instance
        .collection('archives2')
        .where('idDestino', isEqualTo: "")
        .orderBy('fecha', descending: true)
        .limit(20)
        .snapshots();

    Stream instagram =
    Firestore.instance.collection("instagram-fuerza-uruguay-WID").orderBy('timestamp',descending: true).limit(20).snapshots();
    getData() {

      return StreamGroup.merge(([instagram,mensajes]));
    }

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
                  guardaridFirebase(null);
                  return LoginPage();
                }), ModalRoute.withName('/'));
              },
              color: Colors.white,
            ),
          ],
        ),
        body: StreamBuilder<List<QuerySnapshot>>(

          stream: CombineLatestStream.list([
            mensajes,instagram
          ]) ,
          builder: (context,AsyncSnapshot<List<QuerySnapshot>> listado) {

         //  if(initiate()!=null){
           //  var ini=initiate();
            // CombineLatestStream.list([mensajes,ini.asStream()]);
          // }
            int lengthOfDocs=0;
            int querySnapShotCounter = 0;
            int counter = 0;
            int counterAux=0;
            int querySnapShotCounterAux = 1;
            if(listado.hasData){

              listado.data.forEach((snap){lengthOfDocs = lengthOfDocs + snap.documents.length;});

               //aux=querySnapshotData;
               //aux2=querySnapshotData.data[1];
              //aux[1].forEach((element)=>aux[0].add(element));

            }
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

                    controller: _scrollController,
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(1.0),
                    itemCount: lengthOfDocs,
                    itemBuilder: (context, index) {

                      //listado.data.forEach((snap){lengthOfDocs = lengthOfDocs + snap.documents.length;});
                     try{

                       mensaje = Mensaje.fromMap(
                           listado.data[querySnapShotCounter].documents[counter].data);
                       counter = counter + 1 ;
                     }catch(RangeError){



                       mensaje = Mensaje.fromInstagramMap(
                           listado.data[querySnapShotCounterAux].documents[counterAux].data);

                       counterAux = counterAux + 1 ;
                       return desdeInstagram(mensaje, context);
                     }
                      if (baseUsuario.user.userRole == "0") {
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
        ),
        floatingActionButton:
            Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          Container(
            padding: EdgeInsets.only(bottom: 25),
            height: 55,
            width: 55,
            child: FloatingActionButton(
              heroTag: null,
              onPressed: _scrollToTop,
              backgroundColor: Colors.white70,
              foregroundColor: Colors.black54,
              tooltip: 'Ir al principio',
              child: Icon(Icons.arrow_upward),
            ),
          ),
          FloatingActionButton(
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
        ]),
      ),
    );
  }
  Widget desdeInstagram(Mensaje msj, BuildContext context) {
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
                        child: Image.asset('assets/banner.png'),
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children:<Widget> [

                      Text(
                        msj.fecha.substring(0,10),
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        DetalleImagenLV(msj.imageUrl)));
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
                    mainAxisAlignment: MainAxisAlignment.start,
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        DetalleImagenLV(msj.imageUrl)));
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          msj.fecha,
                          style: TextStyle(
                            color: Colors.green[700],
                            fontSize: 16.0,
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          DetalleImagenLV(msj.imageUrl)));
                            },
                          ),
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
        new Container(
          color: Colors.white,
          constraints: BoxConstraints(minWidth: 100, maxWidth: 500),
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon:Icon(Icons.reply),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return FeedResponsePage(msj.userId, msj.userName,
                              msj.imgProfile, msj.imageUrl, msj.mensaje);
                        },
                      ),
                    );
                  },
                  color: Colors.lightBlue,

                ),
              ],
            ),

          ]),
        ),
        Divider(
          height: 1.0,
          color: Colors.grey,
        ),
      ]);
    } else if (msj.videoUrl != "") {
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
                      mainAxisAlignment: MainAxisAlignment.start,
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          DetalleImagenLV(msj.imageUrl)));
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
        new Container(
          color: Colors.white,
          constraints: BoxConstraints(minWidth: 100, maxWidth: 500),
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                 IconButton(
                  icon: Icon(Icons.reply),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return FeedResponsePage(msj.userId, msj.userName,
                              msj.imgProfile, msj.imageUrl, msj.mensaje);
                        },
                      ),
                    );
                  },
                  color: Colors.lightBlue,

                ),
              ],
            ),
          ]),
        ),
        Divider(
          height: 1.0,
          color: Colors.grey,
        ),
      ]);
    } else {
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
        new Container(
          color: Colors.white,
          constraints: BoxConstraints(minWidth: 100, maxWidth: 500),
          padding: const EdgeInsets.fromLTRB(0, 0, 10, 10),
          child: Column(
            children: [
              Align(
                alignment: Alignment.bottomRight,
                child: IconButton(
                  icon: Icon(Icons.reply),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return FeedResponsePage(msj.userId, msj.userName,
                              msj.imgProfile, null, msj.mensaje);
                        },
                      ),
                    );
                  },
                  color: Colors.lightBlue,


                ),
              ),
            ],
          ),
        ),
        Divider(
          height: 1.0,
          color: Colors.grey,
        ),
      ]);
    }
  }
}
