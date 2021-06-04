import 'package:flutter/material.dart';
import 'package:pharmadrive/Global/SizeConfig.dart';

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
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.4),
                        spreadRadius: 4,
                        blurRadius: 8,
                        offset:
                            Offset(0, 3), // Todo: changes position of shadow
                      ),
                    ],
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
