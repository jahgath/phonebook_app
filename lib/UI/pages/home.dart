import 'package:flutter/material.dart';
import 'package:phone_app/UI/theme_switch/toggle_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String todoTitle = "";

  createTodos(){
    DocumentReference documentReference = 
      Firestore.instance.collection("MyTodos").document( todoTitle);

      Map<String,String> todos = {
        "todoTitle": todoTitle
      };

      documentReference.setData(todos).whenComplete(() {
        print("$ todoTitle created");
      });
  }

  deleteTodos(item){
    DocumentReference documentReference = 
      Firestore.instance.collection("MyTodos").document(item);

      documentReference.delete().whenComplete(() {
        print("deleted");
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PhoneBook App"),
        leading: IconButton(
          icon: Icon(Icons.lightbulb_outline),
          onPressed: () {
            changeBrightness(context);
          },
        ),
      ),
      body: StreamBuilder(stream: Firestore.instance.collection("MyTodos").snapshots(),builder: (context,snapshots){
        return ListView.builder(
          itemCount: snapshots.data.documents.length,
          itemBuilder: (BuildContext context, int index) {
            DocumentSnapshot documentSnapshot = snapshots.data.documents[index];
            return Dismissible(
              onDismissed: (direction){
                deleteTodos(documentSnapshot['todoTitle']);
              },
              key: Key(documentSnapshot['todoTitle']),
              child: Card(
                margin: EdgeInsets.all(8),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child: ListTile(
                  title: Text(documentSnapshot["todoTitle"]),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                     deleteTodos(documentSnapshot["todoTitle"]);
                    },
                  ),
                ),
              ),
            );
          });
      },),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  title: Text("Add todolist"),
                  content: TextField(
                    onChanged: (String value) {
                       todoTitle = value;
                    },
                  ),
                  actions: [
                    FlatButton(
                      onPressed: () {
                        createTodos();
                        Navigator.of(context).pop();
                      },
                      child: Text("Add"),
                    )
                  ],
                );
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
