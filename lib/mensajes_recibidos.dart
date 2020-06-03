import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fuerzauy/mensaje_base.dart';
import 'package:fuerzauy/user.dart';
import 'package:fuerzauy/user_base.dart';
import 'first_screen.dart';
import 'mensaje.dart';
import 'login_page.dart';
import 'mensajes_recibidos.dart';
import 'sign_in.dart';
import 'upload_screen.dart';
import 'feed_response_page.dart';

class MensajesRecibidos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Mensaje mensaje;

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white70,
        appBar: AppBar(
          title: Text("Mensajes"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return FirstScreen();
              }));
            },
          ),
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

                      if (mensaje.imageUrl != "") {
                        return conImagen(mensaje, context);
                      } else if (mensaje.videoUrl != "") {
                        return conVideo(mensaje, context);
                      } else {
                        return soloTexto(mensaje, context);
                      }
                    });
          },
          future: listadoMensajesXId(user.id),
        ),
      ),
    );
  }

  Widget conImagen(Mensaje mensaje, BuildContext context) {
    return Column(

        children: <Widget>[

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
                            backgroundImage: NetworkImage(mensaje.imgProfile),
                            radius: 20.0,
                          ),

                        ],
                      ),

                    ),
                    new Container(
                      padding: EdgeInsets.only(left: 2.0),
                      child: Row(

                        children: [
                          Text(
                            mensaje.userName,
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
                      padding: EdgeInsets.only(left: 2.0),
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
                color:Colors.white,
                constraints: BoxConstraints(minWidth: 100, maxWidth: 500),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(50, 10, 10, 10),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                                height: 200,
                                decoration: BoxDecoration(

                                    borderRadius: BorderRadius.all(Radius.circular(8.0)),


                                    image: DecorationImage(

                                      fit: BoxFit.fill,
                                      image: NetworkImage(mensaje.imageUrl),
                                    )
                                )
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                            ),
                            Text(
                              mensaje.mensaje,
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
                )

            ),
            new Container(
              color: Colors.white,
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
                              return FeedResponsePage(mensaje.userId,mensaje.userName, mensaje.imgProfile, mensaje.imageUrl,
                                  mensaje.mensaje);
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
          ]
          ),

          Divider(
            height: 1.0,
            color: Colors.grey,
          ),

        ]);
  }

  Widget conVideo(Mensaje mensaje, BuildContext context) {
    return Column(

        children: <Widget>[

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
                            backgroundImage: NetworkImage(mensaje.imgProfile),
                            radius: 20.0,
                          ),

                        ],
                      ),

                    ),
                    new Container(
                      padding: EdgeInsets.only(left: 2.0),
                      child: Row(

                        children: [
                          Text(
                            mensaje.userName,
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
                      padding: EdgeInsets.only(left: 2.0),
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
                color:Colors.white,
                constraints: BoxConstraints(minWidth: 100, maxWidth: 500),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(50, 10, 10, 10),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                                height: 200,
                                decoration: BoxDecoration(

                                    borderRadius: BorderRadius.all(Radius.circular(8.0)),


                                    image: DecorationImage(

                                      fit: BoxFit.fill,
                                      image: NetworkImage(mensaje.imageUrl),
                                    )
                                )
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                            ),
                            Text(
                              mensaje.mensaje,
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
            new Container(
              color: Colors.white,
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
                              return FeedResponsePage(mensaje.userId,mensaje.userName, mensaje.imgProfile, null,
                                  mensaje.mensaje);
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
          Divider(
            height: 1.0,
            color: Colors.grey,
          ),
        ]);
  }

  Widget soloTexto(Mensaje mensaje, BuildContext context) {
    return Column(
        children: <Widget>[
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
                            backgroundImage: NetworkImage(mensaje.imgProfile),
                            radius: 20.0,
                          ),
                        ],
                      ),
                    ),
                    new Container(
                      padding: EdgeInsets.only(left: 2.0),
                      child: Row(
                        children: [
                          Text(
                            mensaje.userName,
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
                      padding: EdgeInsets.only(left: 2.0),
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
                color:Colors.white,
                constraints: BoxConstraints(minWidth: 100, maxWidth: 500),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(50, 10, 10, 10),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              mensaje.mensaje,
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
            new Container(
              color: Colors.white,
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
                              return FeedResponsePage(mensaje.userId,mensaje.userName, mensaje.imgProfile, null,
                                  mensaje.mensaje);
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
          Divider(
            height: 1.0,
            color: Colors.grey,
          ),
        ]);
  }

  /*Row(

                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:[
                              CircleAvatar(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                ),
                                backgroundImage: NetworkImage(

                                  imagenDestinoUrl,
                                ),
                                radius: 20,

                                backgroundColor: Colors.transparent,
                              ),

                              Text("4:08 PM",

                                style: TextStyle(
                                  fontSize: 16.0,

                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.none,


                                ),
                              ),
                              IconButton(
                                  icon:Icon(Icons.arrow_forward_ios),
                                  iconSize: 10,
                                  tooltip: 'Imagen',
                                  onPressed: () {

                                  }
                              )
                            ]

                        ),




                      ],
                    ),

                  ),
                 /* new Container(

                      padding: const EdgeInsets.fromLTRB(70,10,10,8),

                      child:

                      Image.network(

                          mensaje.imageUrl
                      )),



                  new Container(

                    padding: const EdgeInsets.fromLTRB(70,10,10,30),

                    child:
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,


                      children:[
                        Align(
                          alignment: Alignment.centerLeft,
                          child:
                          Column(

                            children: <Widget>[


                              Text(mensaje.mensaje,

                                style: TextStyle(
                                  fontSize: 20.0,

                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.none,


                                ),
                              ),


                            ],
                          ),
                        ),
                      ],

                    ),

                  ),
                  new Container(
                    padding: const EdgeInsets.fromLTRB(0, 0,10,0),
                    child:  Column(

                      children: [

                        Align(
                          alignment: Alignment.bottomRight,
                          child:
                          RaisedButton(
                            onPressed: (){
                              Navigator.of(mContext).pop();
                              Navigator.of(mContext).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return FeedPage(mensaje.userId);
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
                  )*/
                ],

                crossAxisAlignment: CrossAxisAlignment.center,
              )
          ),

        ]

    );
  }

  Widget soloTexto(){
    return Column(


        children: <Widget>[


          Card(

              color: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[


                  new Container(

                    padding: const EdgeInsets.all(10),

                    child:


                    Column(

                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:[
                              CircleAvatar(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                ),
                                backgroundImage: NetworkImage(
                                  imageUrl,
                                ),
                                radius: 20,

                                backgroundColor: Colors.transparent,
                              ),

                              Text("4:08 PM",

                                style: TextStyle(
                                  fontSize: 16.0,

                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.none,


                                ),
                              ),
                            ]

                        ),




                      ],
                    ),

                  ),
                  new Container(
                    padding: const EdgeInsets.fromLTRB(70,0,0,20),
                    child: Column(



                        children:[
                          Align(
                            alignment: Alignment.topCenter,
                            child:
                            Column(

                              children: <Widget>[


                                Text(mensaje.mensaje,

                                  style: TextStyle(
                                    fontSize: 20.0,

                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.none,


                                  ),
                                ),


                              ],
                            ),
                          ),
                        ]
                    ),
                  ),


                ],


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

                    padding: const EdgeInsets.all(10),

                    child:


                    Column(

                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:[
                              CircleAvatar(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                ),
                                backgroundImage: NetworkImage(
                                  imageUrl,
                                ),
                                radius: 20,

                                backgroundColor: Colors.transparent,
                              ),

                              Text("4:08 PM",

                                style: TextStyle(
                                  fontSize: 16.0,

                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.none,


                                ),
                              ),
                            ]

                        ),




                      ],
                    ),

                  ),
                  new Container(

                      padding: const EdgeInsets.all(8.0),

                      child:

                      Image.network(
                          mensaje.imageUrl
                      )),


                  new Container(

                    padding: const EdgeInsets.fromLTRB(70,10,10,30),

                    child:
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,


                      children:[
                        Align(
                          alignment: Alignment.centerLeft,
                          child:
                          Column(

                            children: <Widget>[


                              Text(mensaje.mensaje,

                                style: TextStyle(
                                  fontSize: 20.0,

                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.none,


                                ),
                              ),


                            ],
                          ),
                        ),
                        Column(

                          children: [
                            Align(
                              alignment: Alignment.bottomRight,
                              child:
                              RaisedButton(
                                onPressed: (){

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
                      ],

                    ),

                  )
                ],

                crossAxisAlignment: CrossAxisAlignment.center,
              )
          ),

        ]

    );
  }*/

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
