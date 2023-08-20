import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Map<String,dynamic> scoremap={};
  
  Future<void> getDataFromFirebase() async {
    CollectionReference livescore = firestore.collection('football');
    final DocumentReference docReference = livescore.doc('!_ban_vs_ind');
     final data = await docReference.get();
     print(data.data());
    scoremap=jsonDecode(data.data().toString());

  }
  @override
  void initState() {
    getDataFromFirebase();

    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Live Score'),
        ),
        body:  FutureBuilder(
          future: firestore.collection('football').doc('!_ban_vs_ind').get(),
          builder: (context,AsyncSnapshot <DocumentSnapshot<Object?>> data ) {
            print(data.data?.data());
            if(data.connectionState == ConnectionState.waiting){
              return Center(child: CircularProgressIndicator(),);
            }else if(data.connectionState == ConnectionState.done){
              if(data.hasError){
                return Center(child: Text('Something wrong please try again',style: TextStyle(fontSize: 25),),);
              }
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                SizedBox(height: 100,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text('520',style: TextStyle(fontSize: 30),),
                        Text('Bangladesh',style: TextStyle(fontSize: 25),)
                      ],
                    ),
                    Column(
                      children: [
                        Text('VS',style: TextStyle(fontSize: 25),),
                      ],
                    ),
                    Column(
                      children: [
                        Text('520',style: TextStyle(fontSize: 30),),
                        Text('Bangladesh',style: TextStyle(fontSize: 25),)
                      ],
                    )
                  ],
                ),
              ],
            );
          }
        ),
      ),
    );
  }
}




