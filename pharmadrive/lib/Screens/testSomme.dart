import 'package:flutter/material.dart';

class TestSomme extends StatelessWidget {
  TestSomme({Key key, this.somme}) : super(key: key);
  final somme;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:  Center(child: Text('the somme is $somme')),
    );
  }
}
