import 'package:flutter/material.dart';
import 'package:fuerzauy/feed_base.dart';
import 'mensaje.dart';
import 'upload_screen.dart';

class FeedPage extends StatefulWidget {
  @override
  _FeedPageState createState() {
    return _FeedPageState();
  }
}

class _FeedPageState extends State<FeedPage> {

  @override
  Widget build(BuildContext context) {
    Scaffold(
      appBar: AppBar(
        title: const Text('Fuerza Uruguay'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Menu'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Mensajes Recibidos'),
              onTap: () {
               // Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FeedPage()),
                );

              },
            ),
            ListTile(
              title: Text('Crear Mensaje'),
              onTap: () {
                //Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UploadPage()),
                );

              },
            ),
          ],
        ),
      ),
    );
    return FutureBuilder(

      builder: (context, listado) {

        if (listado.connectionState == ConnectionState.none &&
            listado.hasData == null) {

          return Container();
        }

        return listado.data==null? Container(): ListView.builder(

            itemCount: listado.data.length,
            itemBuilder: (context, position) {
              Mensaje mensaje=Mensaje.fromMap(listado.data[position]);

              return Column(

                  children: <Widget>[

               Card(

              color: Colors.white,

                  child: Column(

                    children: <Widget>[

                      new Container(
                          width:350,
                          height:200,

                          padding: const EdgeInsets.fromLTRB(8.0,50,8,20),


                          decoration: BoxDecoration(

                        image: DecorationImage(

                        fit: BoxFit.contain,

                          image:NetworkImage(
                              mensaje.imageUrl,


                          ),
                        ),
                          ),
                      ),
                      Divider(
                        height: 20.0,
                        color: Colors.grey,

                      ),
                      new Container(
                        width:350,

                        padding: const EdgeInsets.fromLTRB(0.0,0.0,10.0,10.0),
                        child:
                        Column(

                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[


                            Text(mensaje.mensaje,
                        style: TextStyle(
                            fontSize: 16.0,
                            decoration: TextDecoration.none,


                        ),
                            ),

                          ],
                        ),

                      )
                    ],


                  )
              ),

                  ]
              );
            }

        );
      },

      future: listadoMensajes(),

    );
  }
}

