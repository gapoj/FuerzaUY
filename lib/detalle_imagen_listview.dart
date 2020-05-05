
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fuerzauy/first_screen.dart';

import 'package:fuerzauy/sign_in.dart';
import 'package:image_downloader/image_downloader.dart';

class DetalleImagenLV extends StatefulWidget{

  String imgUrl;
  DetalleImagenLV(final String imageUrl){
    imgUrl=imageUrl;
  }

  @override
  DetalleImagenListView createState() => DetalleImagenListView(imgUrl);

}

class DetalleImagenListView  extends State<DetalleImagenLV>{


  String url;
  static const String GuardarImg='Guardar';
  List<String> choices =<String>[GuardarImg];
  int _progress=0;
  bool descargando=false;
  DetalleImagenListView(String imageUrl){
    url=imageUrl;
  }
  @override
  void initState() {
    super.initState();

    ImageDownloader.callback(onProgressUpdate: (String image, int progress) {
      setState(() {
        _progress = progress;
      });
    });
  }

  @override
  Widget build(context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
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
            actions: <Widget>[


              PopupMenuButton<String>(
                onSelected: guardarImagen,
                itemBuilder: (BuildContext context) {
                  return choices.map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text('Guardar'),
                    );
                  }).toList();
                },
              )],
          ),
      body: descargando==true?new Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,

          children: <Widget>[

            Text('Descargando: $_progress %'),

            Image.network(url)
          ],
        ),
      ): new Container(


          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,

            children: <Widget>[
              Image.network(url)
            ],
          ),
        ),
      ),
    );

  }
   void guardarImagen(String choice){
    switch(choice){
      case 'Guardar':
       descargar();
        break;

    }
  }
  void descargar()async{

    setState(() {
      descargando=true;
    });
    try{

      var image= await ImageDownloader.downloadImage(url).whenComplete((){
        setState(() {
          descargando=false;
          Fluttertoast.showToast(
              msg: "Descarga completa.",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 16.0);
        });
        });

      if(image==null){
        return;
      }


    } on PlatformException catch (error) {
      print(error);
    }
  }
}
