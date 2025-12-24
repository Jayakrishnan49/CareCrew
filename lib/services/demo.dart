import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:project_2/main.dart';

void main()async{
  Firebase.initializeApp();
  runApp(MyApp());
}

final FirebaseFirestore _firestore=FirebaseFirestore.instance;


Future addData()async{
  await FirebaseFirestore.instance.collection('collectionPath').add({
    'name':'jayakrishnan',
    'age':24,
  });
}

