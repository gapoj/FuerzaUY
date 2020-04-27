
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fuerzauy/mensaje_base.dart';
import 'package:fuerzauy/user.dart';
import 'package:fuerzauy/user_base.dart' ;
import 'first_screen.dart';
import 'mensaje.dart';
import 'login_page.dart';
import 'mensajes_recibidos.dart';
import 'sign_in.dart';
import 'upload_screen.dart';
import 'feed_response_page.dart';

class MensajesRecibidos extends StatelessWidget{
  Mensaje mensaje;
  bool rolSalud=true;
  String imagenEmisor;
  BuildContext  mContext;

  @override
  Widget build(BuildContext context) {
    mContext=context;
    return MaterialApp(

      home:
      Scaffold(
        backgroundColor: Colors.white70,

        appBar: AppBar(

          title: Text("Mensajes"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) {
                        return FirstScreen();
                      })
              );


            },
          ),
        ),
        body:

        FutureBuilder(

          builder: (context, listado) {


            if (listado.connectionState == ConnectionState.none &&
                listado.hasData == null) {

              return Container();
            }
            if(listado.connectionState==ConnectionState.waiting){
              return load();
            }
            return listado.data==null? Container(): ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.all(1.0),
                itemCount: listado.data.length,
                itemBuilder: (context, position) {
                  mensaje = Mensaje.fromMap(listado.data[position]);

                    if (mensaje.imageUrl != "") {
                      return conImagen();
                    } else if (mensaje.videoUrl != "") {
                      return conVideo();
                    } else {
                      return soloTexto();
                    }

                }
            );
          },

          future: listadoMensajesXId(id),

        ),

    ),
    );


  }
  Widget conImagen(){
    return Column(


        children: <Widget>[

          Card(

              color: Colors.white,
              child: Column(

                children: <Widget>[
                  new Container(
                      padding: const EdgeInsets.all(8.0),
                      child:
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,


                        children: <Widget>[
                          // Sección izquierda

                          CircleAvatar(
                            backgroundImage: NetworkImage(imagenDestinoUrl),

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
                              IconButton(
                                  icon:Icon(Icons.delete),
                                  iconSize: 20,
                                  tooltip: 'Imagen',
                                  onPressed: () {

                                  }
                              )
                            ],
                          ),
                        ],
                      )
                  ),
                  new Container(



                    child:
                          Row(
                            children: <Widget>[
                            // Sección izquierda





                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(50, 10, 10, 10),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Image.network(

                                          mensaje.imageUrl
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                                      ),
                                      Text(mensaje.mensaje,

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
                          )
                          ),
                  new Container(
                    padding: const EdgeInsets.all(8.0),

                    child:
                    Column(

                    children:[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [

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

                      ],
                    ),
                      ]
                    ),
                  ),

                    ]
                  ),
                )
    ]
    );
  }
  Widget conVideo(){
    return Column(


        children: <Widget>[

          Card(

            color: Colors.white,
            child: Column(

                children: <Widget>[
                  new Container(
                      padding: const EdgeInsets.all(8.0),
                      child:
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,


                        children: <Widget>[
                          // Sección izquierda

                          CircleAvatar(
                            backgroundImage: NetworkImage(imagenDestinoUrl),

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
                              IconButton(
                                  icon:Icon(Icons.delete),
                                  iconSize: 20,
                                  tooltip: 'Imagen',
                                  onPressed: () {

                                  }
                              )
                            ],
                          ),
                        ],
                      )
                  ),
                  new Container(

                      padding: const EdgeInsets.all(10),

                      child:
                      Row(
                        children: <Widget>[
                          // Sección izquierda





                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Image.network(

                                      mensaje.imageUrl
                                  ),
                                  Text(mensaje.mensaje,

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
                      )
                  ),
                  new Container(
                    padding: const EdgeInsets.all(8.0),

                    child:
                    Column(

                        children:[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [

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

                            ],
                          ),
                        ]
                    ),
                  ),

                ]
            ),
          )
        ]
    );
  }
  Widget soloTexto(){
    return Column(


        children: <Widget>[

          Card(

            color: Colors.white,
            child: Column(

                children: <Widget>[
                  new Container(
                      padding: const EdgeInsets.all(8.0),
                      child:
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,


                        children: <Widget>[
                          // Sección izquierda

                          CircleAvatar(
                            backgroundImage: NetworkImage(imagenDestinoUrl),

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
                              IconButton(
                                  icon:Icon(Icons.delete),
                                  iconSize: 20,
                                  tooltip: 'Imagen',
                                  onPressed: () {

                                  }
                              )
                            ],
                          ),
                        ],
                      )
                  ),
                  new Container(

                      padding: const EdgeInsets.all(10),

                      child:
                      Row(
                        children: <Widget>[
                          // Sección izquierda





                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[

                                  Text(mensaje.mensaje,

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
                      )
                  ),
                  new Container(
                    padding: const EdgeInsets.all(8.0),

                    child:
                    Column(

                        children:[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [

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

                            ],
                          ),
                        ]
                    ),
                  ),

                ]
            ),
          )
        ]
    );
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
            children: <Widget>[
              new CircularProgressIndicator()
            ],
          ),
        ),
      ),
    );
  }

}