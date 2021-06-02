import "package:flutter/material.dart";
import 'package:pharmadrive/Global/SizeConfig.dart';
import 'package:pharmadrive/Screens/Home.dart';

class BienvenueScreen extends StatelessWidget {
  const BienvenueScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: BodyBienvenueScreen(),
        ),
      ),
    );
  }
}

int currentPage = 0;

PageController _controller = PageController(initialPage: 0, keepPage: false);

void passerButtonTapped() {
  _controller.animateToPage(2,
      duration: Duration(milliseconds: 500), curve: Curves.bounceIn);
}

class BodyBienvenueScreen extends StatefulWidget {
  BodyBienvenueScreen({
    Key key,
  }) : super(key: key);

  @override
  _BodyBienvenueScreenState createState() => _BodyBienvenueScreenState();
}

class _BodyBienvenueScreenState extends State<BodyBienvenueScreen> {
  List<Map> listBodyBienvenuScreen = [
    {
      "image": "assets/images/bienvenueImages/home.png",
      "textTop": "Bienvenu chez",
      "textBottom": "Pharma'drive",
      "width": SizeConfig.screenWidth * 0.75,
    },
    {
      "image": "assets/images/bienvenueImages/map.png",
      "textTop": "Bienvenu chez",
      "textBottom": "Pharma'drive",
      "width": SizeConfig.screenWidth * 0.55,
    },
    {
      "image": "assets/images/bienvenueImages/logo-PharmaDrive.png",
      "textTop": "Bienvenu chez",
      "textBottom": "Pharma'drive",
      "width": SizeConfig.screenWidth * 0.55,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackgroundBienvenueScreen(),
        Container(
          width: SizeConfig.safeBlockHorizontal * 100,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              currentPage == 2
                  ? PasserButton(state: false)
                  : PasserButton(state: true),
              Container(
                width: double.infinity,
                height: SizeConfig.safeBlockVertical * 45,
                child: PageView.builder(
                  onPageChanged: (value) {
                    setState(() {
                      currentPage = value;
                    });
                  },
                  controller: _controller,
                  itemCount: listBodyBienvenuScreen.length,
                  itemBuilder: (context, index) => MiddleWidgets(
                    width: listBodyBienvenuScreen[index]["width"],
                    image: listBodyBienvenuScreen[index]["image"],
                    textTop: listBodyBienvenuScreen[index]["textTop"],
                    textBottom: listBodyBienvenuScreen[index]["textBottom"],
                  ),
                ),
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      listBodyBienvenuScreen.length,
                      (index) => buildItemsMiddle(index: index),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 1.5,
                  ),
                  CommencerButton(),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}

AnimatedContainer buildItemsMiddle({int index}) {
  return AnimatedContainer(
    duration: Duration(milliseconds: 300),
    margin: EdgeInsets.only(
      right: SizeConfig.safeBlockHorizontal * 1.5,
    ),
    height: SizeConfig.safeBlockHorizontal * 2,
    width: currentPage == index
        ? SizeConfig.safeBlockHorizontal * 5
        : SizeConfig.safeBlockHorizontal * 2,
    decoration: BoxDecoration(
      color: currentPage == index ? Color(0xffff7c00) : Color(0xffffbf7c),
      borderRadius: BorderRadius.circular(3),
    ),
  );
}

class MiddleWidgets extends StatelessWidget {
  MiddleWidgets({
    Key key,
    @required this.width,
    @required this.textTop,
    @required this.textBottom,
    @required this.image,
  }) : super(key: key);

  final String textTop, textBottom, image;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          textTop,
          style: TextStyle(
            fontFamily: "JosefinSans",
            fontWeight: FontWeight.bold,
            fontSize: SizeConfig.safeBlockHorizontal * 10,
          ),
        ),
        SizedBox(
          height: SizeConfig.blockSizeVertical,
        ),
        Text(
          textBottom,
          style: TextStyle(
            fontFamily: "Rota",
            fontSize: SizeConfig.safeBlockHorizontal * 15,
          ),
        ),
        SizedBox(
          height: SizeConfig.blockSizeVertical * 2,
        ),
        Container(
          width: width,
          child: Image.asset(
            image,
            scale: 1,
          ),
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class PasserButton extends StatefulWidget {
  PasserButton({
    Key key,
    @required this.state,
  }) : super(key: key);
  bool state;

  @override
  _PasserButtonState createState() => _PasserButtonState();
}

class _PasserButtonState extends State<PasserButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.safeBlockHorizontal * 95,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: () {
              setState(() {
                passerButtonTapped();
              });
            },
            child: widget.state
                ? Container(
                    width: SizeConfig.blockSizeHorizontal * 25,
                    height: SizeConfig.blockSizeVertical * 5,
                    decoration: BoxDecoration(
                      color: Color(0xfff0f0f0),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: widget.state
                        ? Center(
                            child: Text(
                            "Passer",
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: "JosefinSans",
                              fontWeight: FontWeight.w600,
                              fontSize: SizeConfig.safeBlockHorizontal * 6,
                            ),
                          ))
                        : null,
                  )
                : null,
          )
        ],
      ),
    );
  }
}

class CommencerButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pushReplacementNamed(context, '/TrouverPharma');
      },
      child: Container(
        width: SizeConfig.blockSizeHorizontal * 80,
        height: SizeConfig.blockSizeVertical * 10,
        decoration: BoxDecoration(
          color: Color(0xfff0f0f0),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Center(
            child: Text(
          "Commencer",
          style: TextStyle(
            color: Colors.black,
            fontFamily: "Rota",
            fontWeight: FontWeight.w700,
            fontSize: SizeConfig.safeBlockHorizontal * 8,
          ),
        )),
      ),
    );
  }
}

class BackgroundBienvenueScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Image.asset(
        "assets/images/background-bienvenue.jpg",
        fit: BoxFit.fill,
      ),
    );
  }
}
