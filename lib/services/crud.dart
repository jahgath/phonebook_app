import 'package:cloud_firestore/cloud_firestore.dart';

class crudMethods {
  Future<void> addData(contactData) async {
    Firestore.instance.collection('testcrud').add(contactData).catchError((e) {
      print(e);
    });
  }

  getData() async {
    return await Firestore.instance.collection('testcrud').snapshots();
  }

  updateData(selectedDoc, newValues) {
    Firestore.instance
        .collection('testcrud')
        .document(selectedDoc)
        .updateData(newValues)
        .catchError((e) {
      print(e);
    });
  }

  deleteData(docId) {
    Firestore.instance
        .collection('testcrud')
        .document(docId)
        .delete()
        .catchError((e) {
      print(e);
    });
  }
}
