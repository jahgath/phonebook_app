import 'package:flutter/material.dart';
import 'package:phone_app/UI/theme_switch/toggle_theme.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PhoneBook App"),
        leading: IconButton(icon: Icon(Icons.lightbulb_outline),onPressed: (){changeBrightness(context);},),
      ),
      body: Center(

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.insert_drive_file), title: Text("Tab 1")),
          BottomNavigationBarItem(
              icon: Icon(Icons.show_chart), title: Text("Tab 2")),
        ],
      ),
    );
  }

}