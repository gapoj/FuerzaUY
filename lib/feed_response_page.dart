import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fuerzauy/Common/upload_text.dart';
import 'package:fuerzauy/mensaje_base.dart';
import 'package:fuerzauy/sign_in.dart';
import 'package:fuerzauy/user.dart';
import 'package:fuerzauy/user_base.dart';
import 'Common/UploadImage.dart';
import 'first_screen.dart';
import 'mensaje.dart';
import 'upload_screen.dart';

class FeedResponsePage extends StatefulWidget {
  String idDestino;
  String imagenDestino;
  String imagen;
  String textoM;
  String mUserName;

  FeedResponsePage(String userId,String userName, imgPerfilDestino, imagenUrl, textoMensaje) {
    idDestino = userId;
    imagenDestino = imgPerfilDestino;
    imagen = imagenUrl;
    textoM = textoMensaje;
    mUserName=userName;
  }

  @override
  _FeedResponsePageState createState() {
    return _FeedResponsePageState(idDestino,mUserName, imagenDestino, imagen, textoM);
  }
}

class _FeedResponsePageState extends State<FeedResponsePage> {
  Widget image;
  String _uploadedFileURL;
  UploadText uploaderText;
  UploadImage uploaderImage;
  Widget camera;
  String mIdDestino;
  bool enviado = false;
  String mensajeEnviado;
  String imgDestinoUrl;
  String imagenPublicada;
  String textoMensaje;
  String videoUrl;
  String mUserName;
  bool btnEnvioState;
  String textAux;
  bool imagen=false;
  bool texto;


  final myController = TextEditingController();

  _FeedResponsePageState(String idDestino,String userName, String imgPerfil, String imagen, String texto) {
    mIdDestino = idDestino;
    imgDestinoUrl = imgPerfil;
    imagenPublicada = imagen;
    textoMensaje = texto;
    mUserName=userName;
  }

  valorTextEditCallback(){
    setState(() {
      myController.text.length > 0
          ? btnEnvioState = true
          : btnEnvioState = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
    myController.dispose();

  }
  @override
  void initState() {
    super.initState();
    myController.addListener((valorTextEditCallback));
  }
  @override
  Widget build(BuildContext context) {
    uploaderImage = new UploadImage();
    uploaderText = new UploadText();
    if (imagenPublicada != null) {
      return conImagen();
    } else if (videoUrl != null) {
      return conVideo();
    } else {
      return soloTexto();
    }
  }

  Widget conImagen() {
    return Scaffold(
        appBar: AppBar(
          title: Text('Respuesta'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return FirstScreen();
              }));
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
                      constraints: BoxConstraints(minWidth: 100, maxWidth: 500),
                      child: Column(children: <Widget>[
                        Card(
                          color: Colors.lightGreen[300],
                          child: Column(children: <Widget>[
                            new Container(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    CircleAvatar(
                                      backgroundImage:
                                          NetworkImage(imgDestinoUrl),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Text(
                                          mUserName,
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          '10:21',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                            new Container(
                                child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        50, 10, 10, 10),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Image.network(
                                          imagenPublicada,
                                          height: 80,
                                          fit: BoxFit.contain,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 20, 0, 0),
                                        ),
                                        Text(
                                          textoMensaje,
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
                        )
                      ]),
                    ),
                    enviado == false
                        ? Card(
                            color: Colors.white,
                            child: Column(
                              children: <Widget>[
                                new Container(
                                  padding: const EdgeInsets.fromLTRB(
                                      8.0, 18.0, 8.0, 0),
                                  child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextField(
                                          controller: myController,
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText:
                                                  'Escribe tu respuesta aquí'),
                                        ),
                                      ]),
                                ),
                                new Container(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: <Widget>[
                                        image != null
                                            ? IconButton(
                                                icon: Icon(Icons.close),
                                                iconSize: 25,
                                                tooltip: 'Imagen',
                                                onPressed: () {
                                                  setState(() {
                                                    clearSelection();
                                                  });
                                                })
                                            : Container(),
                                        image != null &&
                                                _uploadedFileURL == null
                                            ? image
                                            : Container(height: 150),
                                        image == null && camera == null
                                            ? IconButton(
                                                icon: Icon(Icons.image),
                                                iconSize: 60,
                                                tooltip: 'Imagen',
                                                onPressed: () {
                                                  setState(() {
                                                    chooseFile();
                                                  });
                                                })
                                            : Container(),
                                        camera == null && image == null
                                            ? IconButton(
                                                icon: Icon(Icons.photo_camera),
                                                iconSize: 60,
                                                tooltip: 'Imagen',
                                                onPressed: () {
                                                  setState(() {
                                                    chooseFile();
                                                  });
                                                })
                                            : Container(),
                                        _uploadedFileURL != null
                                            ? Image.network(
                                                _uploadedFileURL,
                                                height: 200,
                                                fit: BoxFit.contain,
                                              )
                                            : Container(),
                                      ]),
                                ),
                                new Container(
                                  padding: EdgeInsets.only(bottom: 10),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      MaterialButton(
                                        minWidth: 150.0,
                                        height: 40.0,
                                        child: Text('Enviar',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 25)),
                                        onPressed: btnEnvioState == true ? enviar : null,
                                        color: Colors.cyan,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(5)),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        :imagen==true?Card(
                            color: Colors.lightBlue[200],
                            child: ListView.builder(
                                shrinkWrap: true,
                                padding: const EdgeInsets.all(1.0),
                                itemCount: 1,
                                itemBuilder: (context, position) {
                                  return Column(children: <Widget>[
                                    new Container(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            CircleAvatar(
                                              backgroundImage:
                                                  NetworkImage(user.imageUrl),
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
                                        )),
                                    new Container(
                                        child: Row(
                                      children: <Widget>[
                                        // Sección izquierda

                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                50, 10, 10, 10),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Image.network(_uploadedFileURL,
                loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                loadingProgress.expectedTotalBytes
                    : null,
                ),);}),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          0, 20, 0, 0),
                                                ),
                                                Text(
                                                  textAux,
                                                  style: TextStyle(
                                                    fontSize: 20.0,
                                                    decoration:
                                                        TextDecoration.none,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                                  ]);
                                })):new Container()
                  ],
                );
              }),
        ));
  }

  Widget conVideo() {
    return Scaffold(
        appBar: AppBar(
          title: Text('Respuesta'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return FirstScreen();
              }));
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
                      constraints: BoxConstraints(minWidth: 100, maxWidth: 500),
                      child: Column(children: <Widget>[
                        Card(
                          color: Colors.lightGreen[300],
                          child: Column(children: <Widget>[
                            new Container(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    CircleAvatar(
                                      backgroundImage:
                                          NetworkImage(imgDestinoUrl),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Text(
                                          mUserName,
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          '10:21',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                            new Container(
                                child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        50, 10, 10, 10),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Image.network(
                                          imagenPublicada,
                                          height: 80,
                                          fit: BoxFit.contain,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 20, 0, 0),
                                        ),
                                        Text(
                                          textoMensaje,
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
                        )
                      ]),
                    ),
                    enviado == false
                        ? Card(
                            color: Colors.white,
                            child: Column(
                              children: <Widget>[
                                new Container(
                                  padding: const EdgeInsets.fromLTRB(
                                      8.0, 18.0, 8.0, 0),
                                  child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextField(
                                          controller: myController,
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText:
                                                  'Escribe tu respuesta aquí'),
                                        ),
                                      ]),
                                ),
                                new Container(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: <Widget>[
                                        image != null
                                            ? IconButton(
                                                icon: Icon(Icons.close),
                                                iconSize: 25,
                                                tooltip: 'Imagen',
                                                onPressed: () {
                                                  setState(() {
                                                    clearSelection();
                                                  });
                                                })
                                            : Container(),
                                        image != null &&
                                                _uploadedFileURL == null
                                            ? image
                                            : Container(height: 150),
                                        image == null && camera == null
                                            ? IconButton(
                                                icon: Icon(Icons.image),
                                                iconSize: 60,
                                                tooltip: 'Imagen',
                                                onPressed: () {
                                                  setState(() {
                                                    chooseFile();
                                                  });
                                                })
                                            : Container(),
                                        camera == null && image == null
                                            ? IconButton(
                                                icon: Icon(Icons.photo_camera),
                                                iconSize: 60,
                                                tooltip: 'Imagen',
                                                onPressed: () {
                                                  setState(() {
                                                    chooseFile();
                                                  });
                                                })
                                            : Container(),
                                        _uploadedFileURL != null
                                            ? Image.network(
                                                _uploadedFileURL,
                                                height: 200,
                                                fit: BoxFit.contain,
                                              )
                                            : Container(),
                                      ]),
                                ),
                                new Container(
                                  padding: EdgeInsets.only(bottom: 10),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      MaterialButton(
                                        minWidth: 150.0,
                                        height: 40.0,
                                        child: Text('Enviar',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 25)),
                                        onPressed: btnEnvioState == true ? enviar : null,
                                        color: Colors.cyan,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(5)),

                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        : Card(
                            color: Colors.lightBlue[200],
                            child: ListView.builder(
                                shrinkWrap: true,
                                padding: const EdgeInsets.all(1.0),
                                itemCount: 1,
                                itemBuilder: (context, position) {
                                  return Column(children: <Widget>[
                                    new Container(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            CircleAvatar(
                                              backgroundImage:
                                                  NetworkImage(user.imageUrl),
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
                                        )),
                                    new Container(
                                        child: Row(
                                      children: <Widget>[
                                        // Sección izquierda

                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                50, 10, 10, 10),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Image.network(_uploadedFileURL),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          0, 20, 0, 0),
                                                ),
                                                Text(
                                                  textAux,
                                                  style: TextStyle(
                                                    fontSize: 20.0,
                                                    decoration:
                                                        TextDecoration.none,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                                  ]);
                                })),
                  ],
                );
              }),
        ));
  }

  Widget soloTexto() {
    return Scaffold(
        appBar: AppBar(
          title: Text('Respuesta'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return FirstScreen();
              }));
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
                      constraints: BoxConstraints(minWidth: 100, maxWidth: 500),
                      child: Column(children: <Widget>[
                        Card(
                          color: Colors.lightGreen[300],
                          child: Column(children: <Widget>[
                            new Container(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    CircleAvatar(
                                      backgroundImage:
                                          NetworkImage(imgDestinoUrl),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Text(
                                          mUserName,
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          '10:21',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                            new Container(
                                child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        50, 10, 10, 10),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          textoMensaje,
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
                        )
                      ]),
                    ),
                    enviado == false
                        ? Card(
                            color: Colors.white,
                            child: Column(
                              children: <Widget>[
                                new Container(
                                  padding: const EdgeInsets.fromLTRB(
                                      8.0, 18.0, 8.0, 0),
                                  child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextField(
                                          controller: myController,
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText:
                                                  'Escribe tu respuesta aquí'),
                                        ),
                                      ]),
                                ),
                                new Container(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: <Widget>[
                                        image != null
                                            ? IconButton(
                                                icon: Icon(Icons.close),
                                                iconSize: 25,
                                                tooltip: 'Imagen',
                                                onPressed: () {
                                                  setState(() {
                                                    clearSelection();
                                                  });
                                                })
                                            : Container(),
                                        image != null &&
                                                _uploadedFileURL == null
                                            ? image
                                            : Container(height: 150),
                                        image == null && camera == null
                                            ? IconButton(
                                                icon: Icon(Icons.image),
                                                iconSize: 60,
                                                tooltip: 'Imagen',
                                                onPressed: () {
                                                  setState(() {
                                                    chooseFile();
                                                  });
                                                })
                                            : Container(),
                                        camera == null && image == null
                                            ? IconButton(
                                                icon: Icon(Icons.photo_camera),
                                                iconSize: 60,
                                                tooltip: 'Imagen',
                                                onPressed: () {
                                                  setState(() {
                                                    chooseFile();
                                                  });
                                                })
                                            : Container(),
                                        _uploadedFileURL != null
                                            ? Image.network(
                                                _uploadedFileURL,
                                                height: 200,
                                                fit: BoxFit.contain,
                                              )
                                            : Container(),
                                      ]),
                                ),
                                new Container(
                                  padding: EdgeInsets.only(bottom: 10),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      MaterialButton(
                                        minWidth: 150.0,
                                        height: 40.0,
                                        child: Text('Enviar',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 25)),
                                        onPressed: btnEnvioState == true ? enviar : null,
                                        color: Colors.cyan,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(5)),

                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        :texto==true?Card(
                            color: Colors.lightBlue[200],
                            child: ListView.builder(
                                shrinkWrap: true,
                                padding: const EdgeInsets.all(1.0),
                                itemCount: 1,
                                itemBuilder: (context, position) {
                                  return Column(children: <Widget>[
                                    new Container(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            CircleAvatar(
                                              backgroundImage:
                                                  NetworkImage(user.imageUrl),
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
                                        )),
                                    new Container(
                                        child: Row(
                                      children: <Widget>[
                                        // Sección izquierda

                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                50, 10, 10, 10),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          0, 20, 0, 0),
                                                ),
                                                Text(
                                                  mensajeEnviado,
                                                  style: TextStyle(
                                                    fontSize: 20.0,
                                                    decoration:
                                                        TextDecoration.none,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                                  ]);
                                })):new Container()
                  ],
                );
              }),
        ));
  }

  Widget uploadFile(String usuarioEnviar) {
     textAux=myController.text;
    uploaderImage.uploadFile(user.id, user.fullName, mIdDestino,
        myController.text, user.imageUrl).then((value) => {
       setState((){
         _uploadedFileURL=value;
        imagen=true;
        texto=false;
         enviado=true;

       })
    });
  }

  Widget uploadText(String usuarioEnviar) {

      uploaderText
          .uploadText(user.id, usuarioEnviar, myController.text,
          user.imageUrl, user.fullName)
          .then((value) => {
        setState(() {
          mensajeEnviado = value;
          enviado = true;
          texto=true;
          imagen=false;
          //myController.dispose();
        }),
        Fluttertoast.showToast(
            msg: "Tu mensaje ha sido enviado a " +
                usuarioEnviar,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0)
      });

  }

  void clearSelection() {
    setState(() {
      image = null;
      btnEnvioState = false;
    });
  }

  void chooseFile() {
    uploaderImage.chooseFile().then((value) => {
      setState(() {
        image = value;
        value != null ? btnEnvioState = true : btnEnvioState = false;
      })
    });
  }

  void enviar() {

      if (image != null) {
        setState(() {
          uploadFile(mUserName);
        });

      } else {
        setState(() {
          uploadText(mUserName);
        });
      }
      clearSelection();
    }
  }
  Widget load() {
    return Scaffold(
      body: Container(
        color: Colors.white,

          child: Column(

            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 30),
              new CircularProgressIndicator()
            ],
          ),
        ),

    );
  }

