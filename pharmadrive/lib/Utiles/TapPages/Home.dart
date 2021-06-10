import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pharmadrive/Global/SizeConfig.dart';
import 'package:pharmadrive/Providers/dataCenter.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          ClipPath(
            clipper: WaveClipper(),
            child: Container(
              height: SizeConfig.safeBlockVertical * 40,
              width: double.infinity,
              color: Color(0xffff8000),
              child: Stack(children: [
                ProfilCircle(),
                ImageManDelivery(),
                TitleApp(),
                TextScannerVOrdon(),
              ]),
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: SizeConfig.blockSizeVertical * 37,
              ),
              Center(
                child: Container(
                  height: SizeConfig.blockSizeVertical * 60,
                  width: SizeConfig.blockSizeHorizontal * 95,
                  color: Colors.white,
                  child: ListView(
                    children: [
                      ComponentHome(
                        title: "Trouvez un médicament",
                        image: "assets/images/home/Pharma1.jpg",
                        function: () =>
                            Navigator.pushNamed(context, "/FindMedicament"),
                      ),
                      ComponentHome(
                        title: "Pharmacies de garde",
                        image: "assets/images/home/Pharma3.jpg",
                      ),
                      ComponentHome(
                        title: "Trouvez un docteur",
                        image: "assets/images/home/Pharma2.jpg",
                      ),
                      ComponentHome(
                        title: "Trouvez un clinique",
                        image: "assets/images/home/Pharma4.jpg",
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

// Todo: all widget used to build home page

//***Tape***//

class ComponentHome extends StatelessWidget {
  ComponentHome({
    Key key,
    @required this.title,
    @required this.image,
    this.function,
  }) : super(key: key);

  final String title;
  final String image;
  final Function function;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      // ignore: deprecated_member_use
      child: FlatButton(
        onPressed: function,
        child: Container(
          height: SizeConfig.safeBlockVertical * 25,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color(0xffc8c7c6).withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 9,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Card(
            color: Color(0xfff7e6dc),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusDirectional.circular(20),
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: SizeConfig.safeBlockVertical * 18,
                  child: Image.asset(
                    image,
                    fit: BoxFit.cover,
                    width: double.maxFinite,
                  ),
                ),
                Container(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontFamily: "Rota",
                      fontWeight: FontWeight.bold,
                      fontSize: SizeConfig.blockSizeHorizontal * 6,
                      color: Color(0xffff8000),
                    ),
                  ),
                ),
                SizedBox()
              ],
            ),
          ),
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

// ignore: must_be_immutable
class ProfilCircle extends StatelessWidget {
  ProfilCircle({
    Key key,
  }) : super(key: key);

  //This value is used to center the drawer
  final double middle = (SizeConfig.blockSizeVertical * 100 -
          SizeConfig.blockSizeVertical * 100 * 0.75) /
      2;

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    DataCenter data = Provider.of<DataCenter>(context);
    return Column(
      children: [
        SizedBox(height: SizeConfig.blockSizeVertical * 5),
        Container(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // ignore: deprecated_member_use
              FlatButton(
                shape: CircleBorder(),
                padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 1.5),
                onPressed: () {
                  //Todo: Show Drawer
                  data.setXOffsite(SizeConfig.blockSizeHorizontal * 70);
                  data.setYOffsite(middle + statusBarHeight / 2);
                  data.setActiveNvg(false);
                },
                child: Container(
                  width: SizeConfig.blockSizeHorizontal * 15,
                  height: SizeConfig.blockSizeHorizontal * 15,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.3),
                        spreadRadius: 4,
                        blurRadius: 8,
                        offset: Offset(0, 3),
                      ),
                    ],
                    image: DecorationImage(
                        //image: ExactAssetImage('assets/images/profil.png'),
                        image: data.utilisateurConnecte.imageUrl == null
                            ? ExactAssetImage('assets/images/profil.png')
                            : NetworkImage(data.utilisateurConnecte.imageUrl),
                        fit: BoxFit.fill),
                  ),
                ),
              )
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
    double radius = SizeConfig.blockSizeHorizontal * 11;
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
