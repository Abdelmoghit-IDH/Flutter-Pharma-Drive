import "package:flutter/material.dart";
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:pharmadrive/Global/SizeConfig.dart';
import 'package:pharmadrive/Utiles/TapPages/Home.dart';
import 'package:pharmadrive/Utiles/TapPages/MapPharma.dart';


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
    Home(),
    Home(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}


