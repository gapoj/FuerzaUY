import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fuerzauy/Common/upload_text.dart';
import 'package:fuerzauy/mensaje_base.dart';
import 'package:fuerzauy/sign_in.dart';
import 'Common/UploadImage.dart';
import 'first_screen.dart';
import 'mensaje.dart';
import 'upload_screen.dart';

class FeedPage extends StatefulWidget {

  String idDestino;

  FeedPage(String userId){
    idDestino=userId;
  }




  @override
  _FeedPageState createState() {
    return _FeedPageState(idDestino);
  }
}

class _FeedPageState extends State<FeedPage> {
  Widget image;
  String _uploadedFileURL;
  UploadText uploaderText;
  UploadImage uploaderImage;
  Widget camera;
  String mIdDestino;
  bool enviado=false;
  String mensajeEnviado;
  final myController = TextEditingController();

  _FeedPageState(String idDestino){
    mIdDestino=idDestino;
  }
  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    uploaderImage = new UploadImage();
    uploaderText= new UploadText();
   return Scaffold(
      appBar: AppBar(
        title: Text('Respuesta'),
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


      child: ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.all(1.0),
        itemCount: 1,
        itemBuilder: (context, position) {


          return Column(


            children: <Widget>[
                new Container(
                  child: Column(


                    children: <Widget>[

                    Card(

                      color: Colors.lightGreen[300],
                      child: Column(

                        children: <Widget>[
                        new Container(
                          padding: const EdgeInsets.all(8.0),
                          child:
                          Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,


                            children: <Widget>[


                              CircleAvatar(
                                backgroundImage: NetworkImage(imagenDestinoUrl),

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
                          ]
                        ),
                      )
                    ]
                  ),
                ),
              enviado==false?
              Card(

                color: Colors.white,
                        child: Column(
                          children: <Widget>[
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
                                    hintText: 'Escribe tu respuesta aquí'
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
    ): Card(
          color: Colors.lightBlue[200],
          child:
          ListView.builder(

            shrinkWrap: true,
            padding: const EdgeInsets.all(1.0),
            itemCount: 1,
            itemBuilder: (context, position) {
            return Column(

              children: <Widget>[

              new Container(
              padding: const EdgeInsets.all(8.0),
              child:
              Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,


              children: <Widget>[
                CircleAvatar(
                  backgroundImage: NetworkImage(imageUrl),

                ),
              // Sección izquierda
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


          child:
          Row(
          children: <Widget>[
          // Sección izquierda


          Expanded(
          child: Padding(
          padding: const EdgeInsets.fromLTRB(
          50, 10, 10, 10),
          child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment
              .center,
          children: <Widget>[

          Padding(
          padding: const EdgeInsets.fromLTRB(
          0, 20, 0, 0),
          ),
          Text(mensajeEnviado,

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


          ]
          );
          }
          )
          ),
          ],
          );

        }


    ),
    ));
            }

  void chooseFile() {
    uploaderImage.chooseFile().then((value) => {
      setState(() {
        image = value;
      })
    });
  }

  void uploadFile() {
    FutureBuilder(
      builder: (context,url){
        if (url.connectionState == ConnectionState.none &&
            url.hasData == null) {

          return Container();
        }
        if(url.connectionState==ConnectionState.waiting){
          return load();
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


