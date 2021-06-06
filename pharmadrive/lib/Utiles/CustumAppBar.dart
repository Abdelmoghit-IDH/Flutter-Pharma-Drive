import 'package:flutter/material.dart';
import 'package:pharmadrive/Global/SizeConfig.dart';
import 'package:pharmadrive/Providers/dataCenter.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget {
  CustomAppBar({
    Key key,
    @required this.statusBarHeight,
    @required this.middleSpace,
    @required this.fontSizeAppBar,
  }) : super(key: key);

  final double statusBarHeight;
  final double middleSpace;
  final double fontSizeAppBar;

  //This value is used to center the drawer
  final double middle = (SizeConfig.blockSizeVertical * 100 -
          SizeConfig.blockSizeVertical * 100 * 0.75) /
      2;

  @override
  Widget build(BuildContext context) {
    DataCenter data = Provider.of<DataCenter>(context);
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
            SizedBox(height: SizeConfig.safeBlockVertical * 4.5),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // ignore: deprecated_member_use
                FlatButton(
                  shape: CircleBorder(),
                  onPressed: () {
                    //Todo: Show Drawer
                    data.setXOffsite(SizeConfig.blockSizeHorizontal * 70);
                    data.setYOffsite(middle + statusBarHeight / 2);
                    data.setActiveNvg(false);
                  },
                  child: Container(
                    margin: EdgeInsets.all(20),
                    width: SizeConfig.blockSizeHorizontal * 15,
                    height: SizeConfig.blockSizeHorizontal * 15,
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
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}
