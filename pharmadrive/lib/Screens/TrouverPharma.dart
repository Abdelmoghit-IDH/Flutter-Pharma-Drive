import "package:flutter/material.dart";
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:pharmadrive/Global/SizeConfig.dart';
import 'Home.dart';

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

  final _tabPages = <Widget>[
    Home(),
    Map(),
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

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key key,
    @required this.statusBarHeight,
    @required this.middleSpace,
    @required this.fontSizeAppBar,
  }) : super(key: key);

  final double statusBarHeight;
  final double middleSpace;
  final double fontSizeAppBar;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.orange[700],
          width: double.infinity,
          height: statusBarHeight + SizeConfig.blockSizeVertical * 7,
          child: Column(
            children: [
              SizedBox(
                height: middleSpace,
              ),
              Text(
                "Trouver une pharmacie",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: fontSizeAppBar,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Column(
          children: [
            SizedBox(height: SizeConfig.safeBlockVertical * 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.all(20),
                  width: SizeConfig.safeBlockHorizontal * 13,
                  height: SizeConfig.safeBlockHorizontal * 13,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: ExactAssetImage('assets/images/profil.png'),
                        fit: BoxFit.fill),
                  ),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}

class Map extends StatelessWidget {
  Map({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    double fontSizeAppBar = SizeConfig.safeBlockHorizontal * 5.5;
    double middleSpace = (SizeConfig.blockSizeVertical * 7) / 2 +
        statusBarHeight -
        fontSizeAppBar / 2;
    return Stack(
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
        CustomAppBar(
          statusBarHeight: statusBarHeight,
          middleSpace: middleSpace,
          fontSizeAppBar: fontSizeAppBar,
        )
      ],
    );
  }
}
