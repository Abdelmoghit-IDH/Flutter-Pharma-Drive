import "package:flutter/material.dart";
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:pharmadrive/Global/SizeConfig.dart';

// ignore: must_be_immutable
class TrouverPharma extends StatefulWidget {
  TrouverPharma({Key key}) : super(key: key);

  @override
  _TrouverPharmaState createState() => _TrouverPharmaState();
}

class _TrouverPharmaState extends State<TrouverPharma> {
  int selectedIndex = 0;
  String text = "Home";
  int _bottomNavIndex = 0;
  final iconList = <IconData>[
    Icons.home,
    Icons.location_on,
    Icons.phone_callback,
    Icons.brightness_7,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            child: GoogleMap(
              zoomControlsEnabled: false,
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
                target: LatLng(19.018255973653343, 72.84793849278007),
                zoom: 12,
              ),
            ),
          ),
          Stack(
            children: [
              Container(
                color: Colors.red,
                width: double.infinity,
                height: SizeConfig.safeBlockVertical * 10,
                child: Center(
                  child: Text(
                    "Map",
                    style: TextStyle(color: Colors.white, fontSize: 23),
                  ),
                ),
              ),
              Column(
                children: [
                  SizedBox(height: SizeConfig.safeBlockVertical * 4),
                  Container(
                    width: SizeConfig.safeBlockHorizontal * 98,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: EdgeInsets.all(20),
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image:
                                    ExactAssetImage('assets/images/profil.png'),
                                fit: BoxFit.fill),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        itemCount: iconList.length,
        tabBuilder: (int index, bool isActive) {
          final color = isActive ? Colors.blue : Colors.black;
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
        onTap: (index) => setState(() => _bottomNavIndex = index),
      ),
    );
  }
}
