import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pharmadrive/Global/SizeConfig.dart';

class LocalisationSolo extends StatefulWidget {
  final double lat;
  final double lon;
  final String nom;
  const LocalisationSolo({Key key, this.lat, this.lon, this.nom})
      : super(key: key);

  @override
  _LocalisationSoloState createState() => _LocalisationSoloState(lat, lon, nom);
}

class _LocalisationSoloState extends State<LocalisationSolo> {
  final double lat;
  final double lon;
  final String nom;

  _LocalisationSoloState(this.lat, this.lon, this.nom);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xffffa140),
          centerTitle: true,
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          title: Text(
            nom,
            style: TextStyle(
                fontSize: SizeConfig.blockSizeHorizontal * 5,
                fontWeight: FontWeight.w800,
                color: Colors.black),
          )),
      body: _buildTramList(context),
    );
  }

  Container _buildTramList(BuildContext context) {
    List<Marker> markers = [
      Marker(
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        infoWindow: InfoWindow(
          title: nom,
        ),
        markerId: MarkerId(nom),
        position: LatLng(lat, lon),
      ),
    ];

    return Container(
      height: double.infinity,
      width: double.infinity,
      child: GoogleMap(
        markers: Set.from(markers),
        initialCameraPosition: CameraPosition(
          target: LatLng(lat, lon),
          zoom: 18,
        ),
      ),
    );
  }
}
