import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


List listImage=[];
List list = [];

// ignore: must_be_immutable
class AddDrugs extends StatelessWidget {
  AddDrugs({Key key}) : super(key: key);

  List<Map<String, dynamic>> listDrug = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
                icon: Icon(Icons.sanitizer_outlined),
                onPressed: () {
                  var rng = new Random();

                  for (int i = 0; i < list.length; i++) {
                    listDrug.add({
                      'drugName': list[i],
                      'urlImage': listImage[rng.nextInt(11)],
                      'description':
                          "Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum",
                      'price': rng.nextInt(150),
                    });
                  }
                  print("done");
                }),
            Center(child: Text("idhsaine")),
            IconButton(
                icon: Icon(Icons.sanitizer_outlined),
                onPressed: () {
                  for (int i = 0; i < listDrug.length; i++) {
                    var collection =
                        FirebaseFirestore.instance.collection('Drugs');

                    collection
                        .doc()
                        .set(listDrug[i]) // <-- Your data
                        .then((_) => print('Added'))
                        .catchError((error) => print('Add failed: $error'));
                  }
                }),
          ],
        ),
      ),
    );
  }
}
