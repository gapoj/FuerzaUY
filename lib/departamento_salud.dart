import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:fuerzauy/sign_in.dart';
import 'user_base.dart';
import 'package:fuerzauy/first_screen.dart';

String departamento='Departamento';
class DepartamentoSaludPage extends StatefulWidget{

  DepartamentoSaludPage():super();

  @override
  _DepartamentoSaludPage createState()=> _DepartamentoSaludPage();

}

class _DepartamentoSaludPage extends State<DepartamentoSaludPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body:Container(
          decoration: BoxDecoration(
          gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [Colors.blue[100], Colors.blue[400]],
        ),
      ),
            child: Center(
              child: Column(

                children:<Widget> [
                  new Padding(padding: new EdgeInsets.all(40.0),),
                  Text('Selecciona el departamento en el cual trabajas',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54),),
                new Padding(padding: new EdgeInsets.all(20.0),
            child:  new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new DropdownButton<String>(
                  items: <String>['Artigas', 'Canelones','Cerro Largo', 'Colonia', 'Durazno','Flores','Florida','Lavalleja','Maldonado','Montevideo','Paysandú','Río Negro','Rivera','Rocha','Salto','San José','Soriano','Tacuarembó','Treinta y Tres'].map((String value) {
                    return new DropdownMenuItem<String>(
                      value: value,
                      child: new Text(value),
                    );
                  }).toList(),
                  hint: Text(departamento),
                  onChanged: (String value) {
                    
                    departamento=value;
                    setState(() {});
                  },
                )
                ],
            ),
                ),
                  RaisedButton(
                    onPressed: (){
                      if(departamento!='Departamento') {
                        createProfile(id, 1, departamento).whenComplete(() {
                          if (true) {
                            Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) {
                                      return FirstScreen();
                                    })
                            );
                          }
                        });
                      }else{
                        Fluttertoast.showToast(
                            msg: "Selecciona un departamento",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIos: 1
                        );
                      }
                    },
                    color: Colors.deepPurple,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Aceptar',
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      ),
                    ),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40)),
                  )
                ],
              ),
            ),
    ),
    );
  }


}