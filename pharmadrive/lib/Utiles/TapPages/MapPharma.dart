import "package:flutter/material.dart";
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pharmadrive/Global/SizeConfig.dart';
import '../CustumAppBar.dart';


class MapPharma extends StatelessWidget {
  MapPharma({
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
