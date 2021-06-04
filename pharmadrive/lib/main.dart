import 'package:flutter/material.dart';
import 'package:pharmadrive/Screens/Loading.dart';
import 'package:pharmadrive/Utiles/Drawer%20Elements/subScreensDrawer/ProfilEditing.dart';
import 'package:provider/provider.dart';
import 'Providers/dataCenter.dart';
import 'Screens/Bienvenue.dart';
import 'Screens/MainNvgApp.dart';
import 'Screens/StackProfilHome.dart';
import 'Screens/signUp.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DataCenter(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => Loading(),
          '/BienvenueScreen': (context) => BienvenueScreen(),
          '/MainNvgApp': (context) => MainNvgApp(),
          '/StackProfilHome': (context) => StackProfilHome(),
          '/ProfilEditing': (context) => ProfilEditing(),
          '/SignUp': (context) => SignUp(),
        },
      ),
    );
  }
}
