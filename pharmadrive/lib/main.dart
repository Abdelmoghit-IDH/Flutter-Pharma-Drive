import 'package:flutter/material.dart';
import 'package:pharmadrive/Screens/Loading.dart';

import 'Screens/Bienvenue.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/':                (context) => Loading(),
        '/BienvenueScreen': (context) => BienvenueScreen(),
      },
    );
  }
}
