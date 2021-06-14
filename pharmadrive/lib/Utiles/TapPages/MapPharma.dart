import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pharmadrive/Global/SizeConfig.dart';
import 'package:pharmadrive/Providers/dataCenter.dart';
import 'package:pharmadrive/model/pharma.dart';
import 'package:provider/provider.dart';
import '../CustumAppBar.dart';

class MapPharma extends StatefulWidget {
  MapPharma({
    Key key,
    this.listPharma,
  }) : super(key: key);
  final List<Pharmacie> listPharma;

  @override
  _MapPharmaState createState() => _MapPharmaState(listPharma);
}

class _MapPharmaState extends State<MapPharma> {
  _MapPharmaState(this.listPharma);
  List<Pharmacie> listPharma;

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    double fontSizeAppBar = SizeConfig.safeBlockHorizontal * 5.5;
    double middleSpace = (SizeConfig.blockSizeVertical * 7) / 2 +
        statusBarHeight -
        fontSizeAppBar / 2;
    DataCenter data = Provider.of<DataCenter>(context);
    listPharma = data.listPharmacies;
    print("teeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee111");
    print(listPharma);
    List<Marker> markers = [];

    listPharma.forEach((element) {
      markers.add(
        Marker(
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          infoWindow: InfoWindow(
            title: element.nomPharma,
          ),
          markerId: MarkerId(element.nomPharma),
          position: LatLng(element.latitude, element.longtitude),
        ),
      );
    });

    return Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          child: GoogleMap(
            zoomControlsEnabled: false,
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
              target: LatLng(34.0104413, -6.8592775),
              zoom: 10,
            ),
            markers: Set.from(markers),
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

getPharmacies(DataCenter data) async {
  QuerySnapshot snapshot =
      await FirebaseFirestore.instance.collection('pharmacie').get();
  List<Pharmacie> listPharma = [];
  snapshot.docs.forEach((doc) {
    Pharmacie pharmacie = toPharmacie(doc.data());
    print("................................................................");
    print(pharmacie);
    listPharma.add(pharmacie);
  });
  data.listPharmacies = listPharma;
}
