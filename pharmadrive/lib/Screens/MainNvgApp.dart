import "package:flutter/material.dart";
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:pharmadrive/Global/SizeConfig.dart';
import 'package:pharmadrive/Providers/dataCenter.dart';
import 'package:pharmadrive/Screens/pharmacieDeGuarde.dart';
import 'package:pharmadrive/Utiles/TapPages/Home.dart';
import 'package:pharmadrive/Utiles/TapPages/MapPharma.dart';
import 'package:provider/provider.dart';

class MainNvgApp extends StatefulWidget {
  MainNvgApp({Key key}) : super(key: key);

  @override
  _MainNvgAppState createState() => _MainNvgAppState();
}

class _MainNvgAppState extends State<MainNvgApp> {
  int selectedIndex = 0;
  int _bottomNavIndex = 0;
  final iconList = <IconData>[
    Icons.home,
    Icons.location_on,
    Icons.phone_callback,
    Icons.brightness_7,
  ];

  //***This array contain all Tap***//

  final _tabPages = <Widget>[
    Home(),
    MapPharma(),
    PharmacieDeGuarde(),
    Home(),
  ];

  @override
  Widget build(BuildContext context) {
    DataCenter data = Provider.of<DataCenter>(context);
    return AnimatedContainer(
      transform: Matrix4.translationValues(
          data.getXOffsite(), data.getYOffsite(), data.zOffsite)
        ..scale(data.checkState(data.getActiveNvg())),
      duration: Duration(microseconds: 100),
      curve: Curves.easeInOutCirc,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.3),
            spreadRadius: 4,
            blurRadius: 8,
            offset: Offset(0, 3), // Todo: changes position of shadow
          ),
        ],
        color: Color(0xff0E0B1E),
      ),
      child: Scaffold(
        extendBody: true,
        body: Stack(
          children: [
            _tabPages[selectedIndex],
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xffff8000),
          child: Icon(Icons.add),
          onPressed: () {},
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: AnimatedBottomNavigationBar.builder(
          height: SizeConfig.blockSizeVertical * 7.5,
          itemCount: iconList.length,
          tabBuilder: (int index, bool isActive) {
            final color = isActive ? Color(0xffff8000) : Colors.black;
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  iconList[index],
                  size: SizeConfig.safeBlockHorizontal * 9,
                  color: color,
                ),
                const SizedBox(height: 4),
              ],
            );
          },
          backgroundColor: Colors.white,
          activeIndex: _bottomNavIndex,
          splashColor: Colors.orange,
          splashSpeedInMilliseconds: 300,
          notchSmoothness: NotchSmoothness.defaultEdge,
          gapLocation: GapLocation.center,
          leftCornerRadius: 32,
          rightCornerRadius: 32,
          onTap: (index) => setState(() {
            _bottomNavIndex = index;
            selectedIndex = index;
          }),
        ),
      ),
    );
  }
}
