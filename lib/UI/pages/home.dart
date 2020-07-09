import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:phone_app/UI/theme_switch/toggle_theme.dart';
import 'package:phone_app/services/crud.dart';


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String carModel;
  String carColor;

  QuerySnapshot cars;
  crudMethods crudObj = new crudMethods();

  Future<bool> addDialog(BuildContext context) async{
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text('Add Data', style: TextStyle(fontSize: 15.0),),
          content: Column(
            children: [
              TextField(
                decoration: InputDecoration(hintText: 'Enter Car Name'),
                onChanged: (value){
                  this.carModel = value;
                },
              ),
              SizedBox(height: 5,),
              TextField(
                decoration: InputDecoration(hintText: 'Enter Car Color'),
                onChanged: (value){
                  this.carColor = value;
                },
              ),
            ],
          ),
          actions: [
            FlatButton(
              child: Text('add'),
              textColor: Colors.blue,
              onPressed: (){
                Navigator.of(context).pop();
                Map<String,dynamic> carData = {
                  "carName": this.carModel,
                  "carColor": this.carColor
                };
                crudObj.addData(carData).then((result){
                  dialogTrigger(context);
                }).catchError((e){
                  print(e);
                });
              },
            )
          ],
        );
      }
    );
  }

  Future<bool> dialogTrigger(BuildContext context) async{
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text('Job Done', style: TextStyle(fontSize: 15)),
          content:  Text('Added'),
          actions: [
            FlatButton(
              child: Text('Alright'),
              textColor: Colors.blue,
              onPressed: (){
                Navigator.of(context).pop();
              },
            )
          ],
        );
      }
    );
  }

  @override
  void initState() {
    crudObj.getData().then((results){
      setState(() {
        cars = results;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("PhoneBook App"),
        leading: IconButton(
          icon: Icon(Icons.lightbulb_outline),
          onPressed: () {
            changeBrightness(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: (){
              addDialog(context);
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: (){
              crudObj.getData().then((results){
                setState(() {
                  cars = results;
                });
              });
            },
          )
        ],
      ),
      body: _carList() );
  }

  Widget _carList(){
    if(cars != null){
      return ListView.builder(
        itemCount: cars.documents.length,
        padding: EdgeInsets.all(5),
        itemBuilder: (context, index){
          return new ListTile(
            title: Text(cars.documents[index].data['carName']),
            subtitle: Text(cars.documents[index].data['carColor']),
          );
        },
      );
    }
    else{
      return Text('Loading, Please wait');
    }
  }
}
