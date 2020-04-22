import 'package:flutter/material.dart';
import 'package:fuerzauy/user.dart';
import 'package:fuerzauy/user_base.dart';


class ListadoUsuariosSalud extends StatefulWidget{
  @override
  _ListadoState createState() =>_ListadoState();

}

class _ListadoState extends State<ListadoUsuariosSalud>{




  @override
  Widget build(BuildContext context) {

    return FutureBuilder(

        builder: (context, listado) {

          if (listado.connectionState == ConnectionState.none &&
              listado.hasData == null) {

            return Container();
          }

          return listado.data==null? Container(): ListView.builder(

              itemCount: listado.data.length,
              itemBuilder: (context, position) {
                User user=User.fromMap(listado.data[position]);
                return Column(

                    children: <Widget>[

                      Row(

                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(10, 10, 0, 6.0),
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                      user.imageUrl,
                                    ),
                                    radius: 30,
                                    backgroundColor: Colors.transparent,
                                  ),

                                ),


                              ],
                            ),

                            Padding(
                              padding:
                              const EdgeInsets.fromLTRB(20, 10, 0, 6.0),
                                child: Column(

                                    children: <Widget>[

                                    Text(
                                      user.fullName,
                                      style: TextStyle(
                                          fontSize: 22.0,
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue
                                      ),
                                    ),
                                      Padding(
                                        padding:
                                        const EdgeInsets.fromLTRB(20, 0, 12.0, 6.0),
                                        child: Text(
                                          user.departamento,
                                          style: TextStyle(fontSize: 18.0,
                                              decoration: TextDecoration.none,
                                              color: Colors.lightBlueAccent),
                                        ),
                                      ),
                ]
                                ),
                            ),


                          ]
                      ),
                      Divider(
                        height: 2.0,
                        color: Colors.grey,
                      )
                    ]
                );
              }

          );
        },

        future: listadoXRol("1"),

    );
  }
}


