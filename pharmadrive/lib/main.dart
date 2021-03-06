import 'package:flutter/material.dart';
import 'package:pharmadrive/Screens/Loading.dart';
import 'package:pharmadrive/Screens/createPharma.dart';
import 'package:pharmadrive/Screens/logIn.dart';
import 'package:pharmadrive/Screens/monStock.dart';
import 'package:pharmadrive/Screens/shipping.dart';
import 'package:pharmadrive/Screens/signUp.dart';
import 'package:pharmadrive/Screens/justificatif.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'Providers/dataCenter.dart';
import 'Screens/AddDrugs.dart';
import 'Screens/Bienvenue.dart';
import 'Screens/FindMedicament.dart';
import 'Screens/MainNvgApp.dart';
import 'Screens/StackProfilHome.dart';
import 'Screens/pharmacieDeGuarde.dart';
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
          '/': (context) => Loading(),
          '/BienvenueScreen': (context) => BienvenueScreen(),
          '/signIn': (context) => LogIn(),
          '/signUp': (context) => SignUp(),
          '/MainNvgApp': (context) => MainNvgApp(),
          '/StackProfilHome': (context) => StackProfilHome(),
          '/EditProfil': (context) => EditProfil(),
          '/FindMedicament': (context) => FindMedicament(),
          '/pharmaGarde': (context) => PharmacieDeGuarde(),
          '/createPharma': (context) => CreatePharma(),
          '/Justificatif': (context) => Justificatif(),
          '/monStock': (context) => MonStock(),
          '/AddDrugs': (context)=> AddDrugs(),
          '/Shipping':(context)=> Shipping(),
        },
      ),
    );
  }
}
