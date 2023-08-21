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

  Map<String, dynamic> scoremap = {};

  Future<void> getDataFromFirebase() async {
    CollectionReference livescore = firestore.collection('football');
    final DocumentReference docReference = livescore.doc('!_ban_vs_ind');
    final data = await docReference.get();
    print(data.data());
    scoremap = jsonDecode(data.data().toString());
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
        body: StreamBuilder(
            stream: firestore
                .collection('football')
                .doc('!_ban_vs_ind')
                .snapshots(),
            builder:
                (context, AsyncSnapshot<DocumentSnapshot<Object?>> snapshot) {
              print(snapshot.data?.data());
              final score = snapshot.data!;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  Center(
                    child: Text(
                      score.get('match_name'),
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                            score.get('score_a').toString(),
                            style: TextStyle(fontSize: 30),
                          ),
                          Text(
                            score.get('team_a'),
                            style: TextStyle(fontSize: 25),
                          )
                        ],
                      ),
                      const Column(
                        children: [
                          Text(
                            'VS',
                            style: TextStyle(fontSize: 25),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            score.get('score_b').toString(),
                            style: TextStyle(fontSize: 30),
                          ),
                          Text(
                            score.get('team_b'),
                            style: TextStyle(fontSize: 25),
                          )
                        ],
                      )
                    ],
                  ),
                ],
              );
            }),
      ),
    );
  }
}
