import 'package:flutter/material.dart';
import 'package:phone_app/UI/theme_switch/toggle_theme.dart';
import 'package:phone_app/services/crud.dart';
import 'package:random_color/random_color.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dialogs.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

RandomColor _randomColor = RandomColor();
Dialogs dialogs = Dialogs();

class _MyHomePageState extends State<MyHomePage> {

  Stream contacts;
  crudMethods crudObj = new crudMethods();

  @override
  void initState() {
    crudObj.getData().then((results) {
      setState(() {
        contacts = results;
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
              onPressed: () {
                dialogs.addDialog(context);
              },
            ),
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                crudObj.getData().then((results) {
                  setState(() {
                    contacts = results;
                  });
                });
              },
            )
          ],
        ),
        body: _contactList());
  }

  Widget _contactList() {
    if (contacts != null) {
      return StreamBuilder(
        stream: contacts,
        builder: (context, snapshot) {
          return ListView.separated(
            separatorBuilder: (context, index) {
              return Divider();
            },
            itemCount: snapshot.data.documents.length,
            padding: EdgeInsets.all(5),
            itemBuilder: (context, index) {
              return new ListTile(
                title: Text(snapshot.data.documents[index].data['contactName']),
                subtitle:
                    Text(snapshot.data.documents[index].data['contactNumber']),
                onTap: () {
                  dialogs.customDialog(
                      snapshot.data.documents[index].data['contactName'],
                      snapshot.data.documents[index].data['contactNumber'],
                      snapshot.data.documents[index].data['contactInfo'],
                      context,
                      snapshot.data.documents[index].documentID);
                },
                leading: CircleAvatar(
                  backgroundColor: _randomColor.randomColor(),
                  child: Text(
                      '${snapshot.data.documents[index].data['contactName'][0]}'),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    crudObj
                        .deleteData(snapshot.data.documents[index].documentID);
                  },
                ),
              );
            },
          );
        },
      );
    } else {
      return Center(
        child: SpinKitRotatingCircle(
          color: Colors.blue,
          size: 30.0,
        ),
      );
      ;
    }
  }
}
