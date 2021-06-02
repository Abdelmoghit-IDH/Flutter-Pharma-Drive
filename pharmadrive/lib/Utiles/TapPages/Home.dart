import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pharmadrive/Global/SizeConfig.dart';

class Home extends StatelessWidget {
  Home({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ClipPath(
        clipper: WaveClipper(),
        child: Container(
          height: SizeConfig.safeBlockVertical * 40,
          width: double.infinity,
          color: Color(0xffff8000),
          child: Stack(children: [
            ProfilCircle(),
            ImageManDelivery(),
            TitleApp(),
            TextScannerVOrdon()
          ]),
        ),
      ),
    );
  }
}

//Todo : Home Page Componants (all widgets used to build home page as defind bellow)

//***Text (Scannez votre ordannonce)***//

class TextScannerVOrdon extends StatelessWidget {
  const TextScannerVOrdon({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.safeBlockVertical * 40 -
          SizeConfig.blockSizeHorizontal * 12,
      alignment: Alignment.bottomCenter,
      child: Text(
        "Scannez votre ordonnance",
        style: TextStyle(
          color: Colors.white,
          fontFamily: "Rota",
          fontSize: SizeConfig.safeBlockHorizontal * 7,
        ),
      ),
    );
  }
}

//***Widget Title <Pharma'Tram>***//

class TitleApp extends StatelessWidget {
  const TitleApp({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: SizeConfig.blockSizeVertical * 3.5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: SizeConfig.blockSizeHorizontal * 3.5),
            Text(
              "Pharma'drive",
              style: TextStyle(
                color: Color(0xff2b383a),
                fontFamily: "Rota",
                fontSize: SizeConfig.blockSizeHorizontal * 7,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

//***Widget Man above the custumable container***//

class ImageManDelivery extends StatelessWidget {
  const ImageManDelivery({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            height: SizeConfig.blockSizeVertical * 40,
            child: Container(
              width: SizeConfig.blockSizeHorizontal * 35,
              child: Image.asset(
                "assets/images/home/mandeliver.png",
              ),
            ),
          ),
        ),
      ],
    );
  }
}

//***Widget Profil picture***//

class ProfilCircle extends StatelessWidget {
  const ProfilCircle({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: SizeConfig.blockSizeVertical * 5),
        Container(
          width: SizeConfig.safeBlockHorizontal * 95,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
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
        ),
      ],
    );
  }
}

//***Widget to custum the shape of our container in the home page***//

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double radius = SizeConfig.blockSizeHorizontal * 12;
    var path = new Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..arcToPoint(Offset(size.width - radius, size.height - radius),
          radius: Radius.circular(radius), clockwise: false)
      ..lineTo(radius, size.height - radius)
      ..arcToPoint(
          Offset(
            0,
            size.height - radius * 2,
          ),
          radius: Radius.circular(radius),
          clockwise: true)
      ..lineTo(0, 0)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
    //if new instance have different instance than old instance
    //then you must return true;
  }
}
