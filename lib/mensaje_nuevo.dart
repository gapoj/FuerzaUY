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
        body:enviado==true?load(): SingleChildScrollView(

            child: new Container(
          height: 800,
          color: Colors.white,
          child: Column(

            children: <Widget>[
              new Flexible(flex: 1,
                child:Container(
                  height: 100,
                color: Colors.blue[200],
                padding:const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                child:
                    Wrap(direction: Axis.vertical, children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                    Text("A todos",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
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
                    Text("A funcionario/a en: ",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
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
                  ],)

                ]),
              )),
              listaUsuarios == false && usuarioEnvio != null
                  ? new Flexible(flex:2,
                  child: Container(
                    height: 200,
                      color: Colors.lightGreen[200],
                      child: itemUsuario,
                    ))
                  : new Flexible(flex:2,
                child: Container(
                  height: 200,
                      constraints: BoxConstraints(
                          minWidth: 100, maxWidth: 500, maxHeight: 200),
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
                                      padding: EdgeInsets.all(10.0),
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
                    )),

                new Flexible(flex:1,
                child: Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: NetworkImage(user.imageUrl),
                      ),
                    ],
                  ))),
              new Flexible(flex:1,
                child: Container(
                  height: 50,
                padding: const EdgeInsets.fromLTRB(50.0, 0, 8.0, 0),
                // new line

                child:

                Column(
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
              )),
              enviado==true?load(): new Flexible(flex:4,
                child: Container(
                  padding: EdgeInsets.fromLTRB(10.0,0.0,10.0,0.0),
                  height: 300,

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
                              color: Colors.deepPurple,
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
                              color: Colors.teal,
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
              )),
              new Flexible(flex:1,
                child: Container(
                  height: 100,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MaterialButton(
                      minWidth: 100.0,
                      height: 40.0,
                      child: Text('Enviar',
                          style: TextStyle(color: Colors.white, fontSize: 25)),
                      onPressed: btnEnvioState == true ?enviar : null,
                      color: Colors.cyan,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                    ),
                  ],
                ),
              ))
            ],
          ),
        )));
  }

  void uploadFile(User usuarioEnviar) {
    enviado = true;
          if (todos == false) {
            uploaderImage.uploadFile(user.id, user.fullName, usuarioEnviar.id,
                myController.text, user.imageUrl).then((value) => {
              setState(() {
                mensajeEnviado = value;
                enviado = true;
                myController.dispose();
              }),
            });
            Fluttertoast.showToast(
                msg: "Tu mensaje ha sido enviado a " + usuarioEnviar.fullName,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                backgroundColor: Colors.black,
                textColor: Colors.white,
                fontSize: 16.0);
          } else {
            uploaderImage.uploadFile(user.id, user.fullName, '',
                myController.text, user.imageUrl).then((value) => {
            setState(() {
            mensajeEnviado = value;
            enviado = true;
            }),
            Navigator.push(context,
            MaterialPageRoute(builder: (context) => FirstScreen()))
            });}


  }

  Widget uploadText(User usuarioEnviar) {
    enviado = true;
    if (todos == false) {
      uploaderText
          .uploadText(user.id, usuarioEnviar.id, myController.text,
              user.imageUrl, user.fullName)
          .then((value) => {
        setState(() {
          mensajeEnviado = value;
          enviado = true;
        }),
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => FirstScreen()))
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

          uploadText(usuarioEnvio);
        
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
