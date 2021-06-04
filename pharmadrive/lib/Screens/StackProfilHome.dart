import 'package:flutter/material.dart';
import 'package:pharmadrive/Providers/dataCenter.dart';
import 'package:pharmadrive/Screens/MainNvgApp.dart';
import 'package:pharmadrive/Utiles/Drawer%20Elements/ProfilClient.dart';
import 'package:provider/provider.dart';

class StackProfilHome extends StatelessWidget {
  const StackProfilHome({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DataCenter data = Provider.of<DataCenter>(context);
    return Scaffold(
      body: Stack(children: [
        ProfilClient(),
        data.getActiveNvg()
            ? MainNvgApp()
            : GestureDetector(
                onTap: () {
                  data.setXOffsite(0);
                  data.setYOffsite(0);
                  data.setActiveNvg(true);
                },
                child: MainNvgApp(),
              ),
      ]),
    );
  }
}
