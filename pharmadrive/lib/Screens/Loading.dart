import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pharmadrive/Global/SizeConfig.dart';
import 'package:pharmadrive/Providers/dataCenter.dart';
import 'package:pharmadrive/Utiles/TapPages/MapPharma.dart';
import 'package:provider/provider.dart';

//the goal of this screen is to show the logo of the app when
//the user opens the app

class Loading extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<Loading> {
  @override
  void initState() {
    super.initState();
    startTime();
    DataCenter data = Provider.of<DataCenter>(context, listen: false);
    getPharmacies(data);
  }

  startTime() async {
    var duration = new Duration(seconds: 5);
    return new Timer(duration, route);
  }

  route() {
    Navigator.pushReplacementNamed(context, '/BienvenueScreen');
  }

  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: SizeConfig.screenWidth * 0.55,
                child: Image.asset(
                  "assets/images/bienvenueImages/logo-PharmaDrive.png",
                  scale: 1,
                ),
              ),
              Text(
                "Pharma'drive",
                style: TextStyle(
                  color: Color(0xff333b3d),
                  fontFamily: "Rota",
                  fontSize: SizeConfig.safeBlockHorizontal * 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
