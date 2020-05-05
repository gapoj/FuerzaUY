import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fuerzauy/user.dart';
import 'package:fuerzauy/user_base.dart';
import 'Common/UploadImage.dart';
import 'Common/upload_text.dart';
import 'first_screen.dart';

class MensajeEnvio extends StatefulWidget {
  @override
  _MensajeEnvioState createState() => _MensajeEnvioState();
}

class _MensajeEnvioState extends State<MensajeEnvio> with SingleTickerProviderStateMixin {
  bool btnEnvioState;
  bool usuarioSeleccionado = false;

  valorTextEditCallback() {
    setState(() {
      myController.text.length > 0
          ? btnEnvioState = true
          : btnEnvioState = false;
    });
  }

  @override
  void initState() {
    super.initState();
    myController.addListener((valorTextEditCallback));
  }

  @override
  void dispose() {
    super.dispose();
    myController.dispose();
  }

  Widget image;
  String _uploadedFileURL;
  UploadText uploaderText;
  UploadImage uploaderImage;
  Widget camera;
  String mIdDestino = '';
  bool enviado = false;
  String mensajeEnviado;
  bool todos = false;
  String departamento = 'Departamento';
  bool listaUsuarios = false;
  String idenvio;
  bool seleccionUsuario;
  bool btnEnvio = false;
  Widget itemUsuario;
  User usuarioEnvio;

  final myController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    uploaderImage = new UploadImage();
    uploaderText = new UploadText();

    return Scaffold(
        appBar: AppBar(
          title: Text('Mensaje Nuevo'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return FirstScreen();
              }));
            },
          ),
        ),
        body: SingleChildScrollView(
            child: Card(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              new Container(
                padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Text("A todos"),
                  Checkbox(
                    value: todos,
                    onChanged: (bool newValue) {
                      setState(() {
                        todos = newValue;
                        listaUsuarios = false;
                        usuarioEnvio = null;
                      });
                    },
                  ),
                  Text("A funcionario/a en: "),
                  new DropdownButton<String>(
                    items: <String>[
                      'Artigas',
                      'Canelones',
                      'Cerro Largo',
                      'Colonia',
                      'Durazno',
                      'Flores',
                      'Florida',
                      'Lavalleja',
                      'Maldonado',
                      'Montevideo',
                      'Paysandú',
                      'Río Negro',
                      'Rivera',
                      'Rocha',
                      'Salto',
                      'San José',
                      'Soriano',
                      'Tacuarembó',
                      'Treinta y Tres'
                    ].map((String value) {
                      return new DropdownMenuItem<String>(
                        value: value,
                        child: new Text(value),
                      );
                    }).toList(),
                    hint: Text(departamento),
                    onChanged: (String value) {
                      departamento = value;
                      setState(() {
                        listaUsuarios = true;
                        usuarioEnvio = null;
                      });
                    },
                  )
                ]),
              ),
              listaUsuarios == false && usuarioEnvio != null
                  ? new Container(
                      color: Colors.lightGreen[200],
                      child: itemUsuario,
                    )
                  : new Container(
                      constraints: BoxConstraints(
                          minWidth: 100, maxWidth: 500, maxHeight: 150),
                      child: FutureBuilder(
                        builder: (context, listado) {
                          if (listado.connectionState == ConnectionState.none &&
                              listado.hasData == null) {
                            listaUsuarios = false;
                            return Container();
                          }

                          return listado.data == null
                              ? Container()
                              : new Container(
                                  child: ListView.builder(
                                      itemCount: listado.data.length,
                                      itemBuilder: (context, position) {
                                        User user = User.fromMap(
                                            listado.data[position]);

                                        return Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Column(children: <Widget>[
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: <Widget>[
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                10, 10, 0, 6.0),
                                                        child: CircleAvatar(
                                                          backgroundImage:
                                                              NetworkImage(
                                                            user.imageUrl,
                                                          ),
                                                          radius: 20,
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .fromLTRB(
                                                        20, 10, 10, 6.0),
                                                    child: Column(
                                                        children: <Widget>[
                                                          InkWell(
                                                            child: Text(
                                                              user.fullName,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      22.0,
                                                                  decoration:
                                                                      TextDecoration
                                                                          .none,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .blue),
                                                            ),
                                                            onTap: () {
                                                              setState(() {
                                                                listaUsuarios =
                                                                    false;
                                                                usuarioEnvio =
                                                                    user;
                                                                itemUsuario =
                                                                    funcionarioSeleccionado(
                                                                        usuarioEnvio);
                                                                todos = false;
                                                              });
                                                            },
                                                          ),
                                                        ]),
                                                  ),
                                                ]),
                                            Divider(
                                              height: 2.0,
                                              color: Colors.grey,
                                            )
                                          ]),
                                        );
                                      }),
                                );
                        },
                        future: listadolXDepartamento(departamento),
                        //listadolXDepartamento(departamento),
                      ),
                    ),
              new Container(
                  padding: const EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: NetworkImage(user.imageUrl),
                      ),
                    ],
                  )),
              new Container(
                padding: const EdgeInsets.fromLTRB(50.0, 0, 8.0, 0),
                // new line

                child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: myController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Escribe tu mensaje aquí'),
                      ),
                    ]),
              ),
              new Container(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
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
                      image != null && _uploadedFileURL == null
                          ? Container(
                              constraints:
                                  BoxConstraints(minWidth: 100, maxWidth: 500),
                              padding: EdgeInsets.only(right: 10),
                              child: SizedBox(
                                width: 350,
                                height: 200,
                                child: Card(
                                  child: (FittedBox(
                                    child: image,
                                    fit: BoxFit.fill,
                                  )),
                                ),
                              ),
                            )
                          : Container(),
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
                              height: 150,
                            )
                          : Container(),
                    ]),
              ),
              new Container(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MaterialButton(
                      minWidth: 100.0,
                      height: 40.0,
                      child: Text('Enviar',
                          style: TextStyle(color: Colors.white, fontSize: 25)),
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
        )));
  }

  void uploadFile(User usuarioEnviar) {
    FutureBuilder(
        builder: (context, url) {
          if (url.connectionState == ConnectionState.none &&
              url.hasData == null) {
            return Container();
          }
          if (url.connectionState == ConnectionState.waiting) {
            //return load();
          }
          url == null ? Container() : _uploadedFileURL = url.data.toString();
          setState(() {
            enviado = true;
            myController.dispose();
          });
          if (todos == false) {
            Fluttertoast.showToast(
                msg: "Tu mensaje ha sido enviado a " + usuarioEnviar.fullName,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                backgroundColor: Colors.black,
                textColor: Colors.white,
                fontSize: 16.0);
          } else {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => FirstScreen()));
          }
        },
        future: todos == false
            ? uploaderImage.uploadFile(user.id, user.fullName, usuarioEnviar.id,
                myController.text, user.imageUrl)
            : uploaderImage.uploadFile(
                user.id, user.fullName, '', myController.text, user.imageUrl));
  }

  Widget uploadText(User usuarioEnviar) {
    if (todos == false) {
      uploaderText
          .uploadText(user.id, usuarioEnviar.id, myController.text,
              user.imageUrl, user.fullName)
          .then((value) => {
                setState(() {
                  mensajeEnviado = value;
                  enviado = true;
                  myController.dispose();
                }),
                Fluttertoast.showToast(
                    msg: "Tu mensaje ha sido enviado a " +
                        usuarioEnviar.fullName,
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.CENTER,
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                    fontSize: 16.0)
              });
    } else {
      uploaderText
          .uploadText(
              user.id, '', myController.text, user.imageUrl, user.fullName)
          .then((value) => {
                setState(() {
                  mensajeEnviado = value;
                  enviado = true;
                }),
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FirstScreen()))
              });
    }
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

  void listadoUsuarios() {
    listadoXRol('1').then((value) => {
          setState(() {
            listaUsuarios = value;
          })
        });
  }

  void enviar() {
    if (todos == true || usuarioEnvio != null) {
      if (image != null) {
        uploadFile(usuarioEnvio);
      } else {
        setState(() {
          uploadText(usuarioEnvio);
        });
      }
      clearSelection();
    } else {
      Fluttertoast.showToast(
          msg: "Selecciona a quien irá dirigido tu mensaje.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  Widget funcionarioSeleccionado(User user) {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 0, 6.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                user.imageUrl,
              ),
              radius: 20,
              backgroundColor: Colors.transparent,
            ),
          ),
        ],
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 10, 6.0),
        child: Column(children: <Widget>[
          Text(
            user.fullName,
            style: TextStyle(
                fontSize: 22.0,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.bold,
                color: Colors.blue),
          ),
        ]),
      ),
    ]);
  }
  Widget listadoEnvio() {
    Container(
      child: Row(children: [
        CheckboxListTile(
          title: const Text('Enviar a todos'),
          value: todos,
          onChanged: (bool newValue) {
            setState(() {
              todos = newValue;
            });
          },
          secondary: const Icon(Icons.hourglass_empty),
        ),
      ]),
    );
  }
}
