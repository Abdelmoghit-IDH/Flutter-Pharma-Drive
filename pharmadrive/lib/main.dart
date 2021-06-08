import 'package:flutter/material.dart';
import 'package:pharmadrive/Screens/Loading.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'Providers/dataCenter.dart';
import 'Screens/Bienvenue.dart';
import 'Screens/FindMedicament.dart';
import 'Screens/MainNvgApp.dart';
import 'Screens/StackProfilHome.dart';
import 'Utiles/Drawer Elements/subScreensDrawer/EditProfil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
          '/':                (context) => Loading(),
          '/BienvenueScreen': (context) => BienvenueScreen(),
          '/MainNvgApp':      (context) => MainNvgApp(),
          '/StackProfilHome': (context) => StackProfilHome(),
          '/EditProfil':      (context) => EditProfil(),
          '/FindMedicament':  (context) => FindMedicament(),
        },
      ),
    );
  }
}
