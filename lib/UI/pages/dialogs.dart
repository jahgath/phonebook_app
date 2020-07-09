import 'package:flutter/material.dart';
import 'package:phone_app/services/crud.dart';

class Consts {
  Consts._();

  static const double padding = 16.0;
  static const double avatarRadius = 66.0;
}

class Dialogs {
  String contactName;
  String contactNumber;
  String contactInfo;

  Stream contacts;
  crudMethods crudObj = new crudMethods();

  customDialog(
      String title, String number, String info, BuildContext context, docID) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Consts.padding),
            ),
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(
                    top: Consts.avatarRadius + Consts.padding,
                    bottom: Consts.padding,
                    left: Consts.padding,
                    right: Consts.padding,
                  ),
                  margin: EdgeInsets.only(top: Consts.avatarRadius),
                  decoration: new BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(Consts.padding),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        number,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        info,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      SizedBox(height: 24.0),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            updateDialog(context, docID);
                          },
                          child: Icon(Icons.edit),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: Consts.padding,
                  right: Consts.padding,
                  child: CircleAvatar(
                    child: Text(
                      '${title[0]}',
                      style: TextStyle(fontSize: Consts.avatarRadius / 1.5),
                    ),
                    backgroundColor: Colors.blue,
                    radius: Consts.avatarRadius,
                  ),
                ),
              ],
            ),
          );
        });
  }

  Future<bool> addDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Container(
            child: AlertDialog(
              title: Text(
                'Add Data',
                style: TextStyle(fontSize: 15.0),
              ),
              content: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(hintText: 'Enter contact Name'),
                    onChanged: (value) {
                      this.contactName = value;
                    },
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    decoration:
                        InputDecoration(hintText: 'Enter contact Number'),
                    onChanged: (value) {
                      this.contactNumber = value;
                    },
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextField(
                    decoration: InputDecoration(hintText: 'Additional Info'),
                    onChanged: (value) {
                      this.contactInfo = value;
                    },
                  ),
                ],
              ),
              actions: [
                FlatButton(
                  child: Text('add'),
                  textColor: Colors.blue,
                  onPressed: () {
                    Navigator.of(context).pop();
                    Map<String, dynamic> contactData = {
                      "contactName": this.contactName,
                      "contactNumber": this.contactNumber,
                      "contactInfo": this.contactInfo
                    };
                    crudObj.addData(contactData).then((result) {
                      dialogTrigger(context);
                    }).catchError((e) {
                      print(e);
                    });
                  },
                )
              ],
            ),
          );
        });
  }

  Future<bool> updateDialog(BuildContext context, selectedDoc) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Update Data',
              style: TextStyle(fontSize: 15.0),
            ),
            content: Column(
              children: [
                TextField(
                  decoration: InputDecoration(hintText: 'Enter contact Name'),
                  onChanged: (value) {
                    this.contactName = value;
                  },
                ),
                SizedBox(
                  height: 5,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(hintText: 'Enter contact Number'),
                  onChanged: (value) {
                    this.contactNumber = value;
                  },
                ),
                TextField(
                  decoration: InputDecoration(hintText: 'Enter contact Info'),
                  onChanged: (value) {
                    this.contactInfo = value;
                  },
                ),
              ],
            ),
            actions: [
              FlatButton(
                child: Text('update'),
                textColor: Colors.blue,
                onPressed: () {
                  Navigator.of(context).pop();
                  Map<String, dynamic> contactData = {
                    "contactName": this.contactName,
                    "contactNumber": this.contactNumber
                  };
                  crudObj.updateData(selectedDoc, contactData).then((result) {
                    dialogTrigger(context);
                  }).catchError((e) {
                    print(e);
                  });
                },
              )
            ],
          );
        });
  }

  Future<bool> dialogTrigger(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Updated', style: TextStyle(fontSize: 15)),
            actions: [
              FlatButton(
                child: Icon(Icons.arrow_forward),
                textColor: Colors.blue,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}
