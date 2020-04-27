import 'package:flutter/material.dart';
import 'package:fuerzauy/mensaje_base.dart';
import 'package:fuerzauy/mensaje_envio.dart';
import 'mensaje.dart';
import 'login_page.dart';
import 'mensajes_recibidos.dart';
import 'sign_in.dart';
import 'upload_screen.dart';
import 'feed_response_page.dart';

class FirstScreen extends StatelessWidget {
  Mensaje mensaje;
  bool rolSalud=true;

  BuildContext  mContext;

  @override
  Widget build(BuildContext context) {
  mContext=context;
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
                imageUrl,
              ),
              radius: 30,

              backgroundColor: Colors.transparent,
            ),
            SizedBox(height: 20),
            IconButton(
              icon:Icon(Icons.person_outline),
              iconSize: 40,
              onPressed: () {
                signOutGoogle();
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) {return LoginPage();}), ModalRoute.withName('/'));
              },
              color: Colors.white,

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
          if(listado.connectionState==ConnectionState.waiting){
            return load();
          }

        return listado.data==null? Container(): ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.all(1.0),
          itemCount: listado.data.length,
          itemBuilder: (context, position) {
            mensaje = Mensaje.fromMap(listado.data[position]);
            if (rolSalud == false) {
              if (mensaje.imageUrl != "") {
                return conImagen();
              } else if (mensaje.videoUrl != "") {
                return conVideo();
              } else {
                return soloTexto();
              }
            }else{
              return getRolSalud();
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
                            backgroundImage: NetworkImage(imageUrl),

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
                      )
                  ),
                  new Container(

                      padding: const EdgeInsets.all(10),

                      child:
                      Row(
                        children: <Widget>[


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
  }
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
  Widget getRolSalud(){

    if (mensaje.imageUrl != "") {

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
                              backgroundImage: NetworkImage(imageUrl),

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
                        )
                    ),
                    new Container(



                        child:
                        Row(
                          children: <Widget>[


                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(50, 10, 10, 10),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
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

    }else if(mensaje.videoUrl!=""){
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

                        padding: const EdgeInsets.fromLTRB(50, 10, 10, 10),

                        child:
                        Row(
                          children: <Widget>[


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
                    )
                  ],

                  crossAxisAlignment: CrossAxisAlignment.center,
                )
            ),

          ]

      );
    }else{
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
                              backgroundImage: NetworkImage(imageUrl),

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
                        )
                    ),
                    new Container(

                        padding: const EdgeInsets.all(10),

                        child:
                        Row(
                          children: <Widget>[


                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 40.0),
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
                      padding: const EdgeInsets.fromLTRB(0, 0,10,10),
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
                    )
                  ]
              ),
            )
          ]
      );
    }





    }



}
