

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fuerzauy/sign_in.dart';

import 'Common/UploadImage.dart';
import 'Common/upload_text.dart';
import 'first_screen.dart';

class MensajeEnvio extends StatefulWidget{


  @override
  _MensajeEnvioState createState() {
    return _MensajeEnvioState();
  }


}

class _MensajeEnvioState extends State<MensajeEnvio>{

  Widget image;
  String _uploadedFileURL;
  UploadText uploaderText;
  UploadImage uploaderImage;
  Widget camera;
  String mIdDestino;
  bool enviado = false;
  String mensajeEnviado;
  final myController = TextEditingController();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text('Mensaje Nuevo'),
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
        body: Card(

          color: Colors.white,
          child: Column(
            children: <Widget>[
              new Container(
                  padding: const EdgeInsets.fromLTRB(8.0,30.0,8.0,20.0),
                  child:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,


                    children: <Widget>[


                      CircleAvatar(
                        backgroundImage: NetworkImage(imageUrl),

                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,

                        children: <Widget>[
                          Text(
                            '10:21',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),

                        ],
                      ),
                    ],
                  )
              ),
              new Container(
                padding: const EdgeInsets.fromLTRB(8.0,18.0,8.0,0),
                child:
                Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[
                      TextField(
                        controller: myController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Escribe tu mensaje aquí'
                        ),
                      ),
                    ]),
              ),

              new Container(
                child:
                Column(

                    crossAxisAlignment: CrossAxisAlignment.end,
                    children:<Widget>[
                      image != null
                          ? IconButton(
                          icon:Icon(Icons.close),
                          iconSize: 25,
                          tooltip: 'Imagen',
                          onPressed: () {
                            setState(() {
                              clearSelection();
                            });}
                      ):Container(),
                      image != null && _uploadedFileURL == null
                          ? image
                          : Container(height: 150),
                      image == null
                          ? IconButton(
                          icon:Icon(Icons.image),
                          iconSize: 60,
                          tooltip: 'Imagen',
                          onPressed: () {
                            setState(() {
                              chooseFile();
                            });}
                      ): Container(),
                      camera==null
                          ?  IconButton(
                          icon:Icon(Icons.photo_camera),
                          iconSize: 60,
                          tooltip: 'Imagen',
                          onPressed: () {
                            setState(() {
                              chooseFile();
                            });}
                      ):Container(),

                      _uploadedFileURL != null
                          ? Image.network(
                        _uploadedFileURL,
                        height: 150,
                      ):Container(),

                    ]

                ),
              ),

              new Container(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MaterialButton(
                      minWidth: 150.0,
                      height: 40.0,
                      child: Text('Enviar',style: TextStyle(color: Colors.white,fontSize: 25)),
                      onPressed: (){
                        if(_uploadedFileURL!=null) {
                          uploadFile();
                        }else{
                          setState(() {
                            uploadText();
                          });
                        }
                      },
                      color: Colors.cyan,

                    ),
                  ],
                ),
              )

            ],
          ),
        ));


  }

  void uploadFile() {
    FutureBuilder(
        builder: (context,url){
          if (url.connectionState == ConnectionState.none &&
              url.hasData == null) {

            return Container();
          }
          if(url.connectionState==ConnectionState.waiting){
            //return load();
          }
          url==null?Container():_uploadedFileURL=url.data.toString();
        },
        future: uploaderImage.uploadFile(id,mIdDestino,myController.text)

    );


  }

  Widget uploadText() {
    uploaderText.uploadText(id,mIdDestino,myController.text).then((value) => {
      setState(() {
        mensajeEnviado = value;
        enviado=true;

      })
    });

  }


  void clearSelection() {
    setState(() {
      image = null;
      _uploadedFileURL = null;
    });
  }
  void chooseFile() {
    uploaderImage.chooseFile().then((value) => {
      setState(() {
        image = value;
      })
    });
  }



}