import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/datetime_picker_formfield.dart';
import 'package:myapp/dataStart.dart';

class Config extends StatefulWidget{
  Config({Key key, this.title}) : super(key: key);
  static const String routeName = "/MyItemsPage";
  final String title;
  @override
  ConfigState createState() => new ConfigState();
  
}

class ConfigState extends State<Config>{
  DateTime _date = DateTime.now();
  final myController1 = TextEditingController();
  final myController2 = TextEditingController();
  final myController3 = TextEditingController();
  final myController4 = TextEditingController();

  Future<Null> selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(1970),
      lastDate: DateTime(2100),
      locale: const Locale('fr', ''),
    );
    if(picked != null && picked != _date){
      
      setState(() {
        _date = picked;
        print(_date.toString());
      });
    }
  }
  final format = DateFormat("dd-MM-yyyy HH:mm");
  @override
  Widget build(BuildContext context) {
  
  return Scaffold(
    appBar: AppBar(
      title: Text("Nouveau Timelaps"),
      leading: IconButton(icon:Icon(Icons.arrow_back),
          onPressed:() => Navigator.pop(context),
        )

    ),
    body: SingleChildScrollView(
    child : Column(children: <Widget>[
      Padding(padding: EdgeInsets.all(5.0),),
      Column(mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[
      Text('Début du timelaps :  ',style: 
                          TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold
                            ),),
                        
      DateTimeField(
        controller: myController1,
        decoration: new InputDecoration(
            icon: new Icon(Icons.calendar_today),),
        format: format,
        initialValue :  DateTime.now(),
        onShowPicker: (context, currentValue) async {
          final date = await showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100));
              
          if (date != null) {
            final time = await showTimePicker(
              context: context,
              initialTime:
                  TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
            );
            return DateTimeField.combine(date, time);
          } else {
            return currentValue;
          }
        },
      ),
    ]),
    Padding(padding: EdgeInsets.all(16.0),),
    Column(mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[
      Text('Fin du timelaps :  ',style: 
                          TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold
                            ),),
                        
      DateTimeField(
        controller: myController2,
        decoration: new InputDecoration(
            icon: new Icon(Icons.calendar_today),),
        format: format,
        initialValue :  DateTime.now(),
        onShowPicker: (context, currentValue) async {
          final date = await showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100));
              
          if (date != null) {
            final time = await showTimePicker(
              context: context,
              initialTime:
                  TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
            );
            return DateTimeField.combine(date, time);
          } else {
            return currentValue;
          }
        },
      ),
    ]),
    Padding(padding: EdgeInsets.all(16.0),),
    Column(mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[
      Text('Nom du timelapse :  ',style: 
                          TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold
                            ),),
                        
      TextFormField(
        controller: myController3,
        decoration: new InputDecoration(
            icon: new Icon(Icons.camera),
            labelText: "Entrer un nom"
        ),
      )
    ,
    ]),
    Padding(padding: EdgeInsets.all(16.0),),
    Column(mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[

      Text('Nombre de photo durant l\'interval :  ',style: 
                          TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold
                            ),),
                        
      TextFormField(
        controller: myController4,
        decoration: new InputDecoration(
            icon: new Icon(Icons.settings_input_antenna),
            labelText: "Entrer une fréquence",
            
        ),
        keyboardType: TextInputType.number,
      )
    ,
    ]),
    Padding(padding: EdgeInsets.all(16.0),),
    Column(mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[
      Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            RaisedButton(
              padding: const EdgeInsets.all(8.0),
              textColor: Colors.white,
              color: Colors.orange,
              onPressed: (){
                if(myController1.text!='' && myController2.text != '' && myController3.text != '' && myController4.text != ''){
                    var toto = DataStart(myController1.text,myController2.text,myController3.text,int.parse(myController4.text));
                    print(toto.toJson());
                    return showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          // Retrieve the text the user has entered by using the
                          // TextEditingController.
                          content: Text( "Date début : " +myController1.text +
                          "\nDate fin : " +myController2.text+
                          "\n Nom : " +myController3.text+
                          "\n Nombre de photo : " +myController4.text ),
                        );
                      },
                    );
                }else{
                  return showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          
                          shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(20.0)), //this right here
                          child: Container(
                            height: 100,
                            child: Column(children: <Widget>[
                              
                              TextField(
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    
                                    hintText: 'Merci de compléter tous les champs !'),
                                    style: 
                                    TextStyle(
                                      color: Colors.black,
                                      //fontSize: 20.0,
                                      fontWeight: FontWeight.bold
                                    ),
                                    textAlign: TextAlign.center,
                              ),
                              RaisedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "Ok",
                                  style: TextStyle(color: Colors.white),
                                ),
                                color: Colors.grey,
                              ),
                            ],),
                          ),
                          
                        );
                      },
                    );
                }
                
              },
              child: new Text("Demarrer"),
            ),
          ],
          ),
    
    ]),
    ],)
  ));
  
  }
}