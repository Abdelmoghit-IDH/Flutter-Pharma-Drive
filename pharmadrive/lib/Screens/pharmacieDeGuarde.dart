import 'package:flutter/material.dart';
import 'package:pharmadrive/Global/SizeConfig.dart';
import 'package:pharmadrive/Screens/localisationSolo.dart';

class PharmacieDeGuarde extends StatefulWidget {
  PharmacieDeGuarde({Key key}) : super(key: key);

  @override
  _PharmacieDeGuardeState createState() => _PharmacieDeGuardeState();
}

class _PharmacieDeGuardeState extends State<PharmacieDeGuarde> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[100],
      body: SafeArea(
          child: Column(
        children: [
          ListTile(
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back,
                size: SizeConfig.blockSizeHorizontal * 8,
              ),
              color: Color(0xff2b383a),
            ),
            title: Center(
              child: Text(
                "Pharmacie de garde",
                style: TextStyle(
                  fontFamily: "Rota",
                  fontSize: SizeConfig.blockSizeHorizontal * 6,
                  color: Color(0xff2b383a),
                ),
              ),
            ),
            trailing: Icon(null),
          ),
          Expanded(
            child: Container(
              child: ListView.builder(
                itemCount: listePharmacieDeGuarde.length,
                padding: EdgeInsets.all(8),
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.white, // Theme.of(context).cardColor,
                    shadowColor:
                        Colors.black, //Theme.of(context).primaryColor, 
                    elevation: 10,
                    child: ListTile(
                      leading: IconButton(
                        padding: const EdgeInsets.all(0.0),
                        icon: Icon(
                          Icons.location_pin,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          //todo
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LocalisationSolo(
                                      nom: listePharmacieDeGuarde[index]['nom'],
                                      lat: double.parse(
                                          listePharmacieDeGuarde[index]['lat']),
                                      lon: double.parse(
                                          listePharmacieDeGuarde[index]['lon']),
                                    )),
                          );
                        },
                      ),
                      title: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Container(
                          //color: Colors.orangeAccent,
                          child: Column(
                            //crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      //'test',
                                      listePharmacieDeGuarde[index]['nom'],
                                      textAlign: TextAlign.start,
                                      //lignes[index],
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Jura-VariableFont',
                                        fontSize: 23,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                listePharmacieDeGuarde[index]['adresse'],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                        ),
                      ),
                      trailing: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.phone,
                          color: Colors.black,
                          size: 26,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      )),
    );
  }
}

List listePharmacieDeGuarde = [
  {
    'nom': 'Pharmacie Wadi Edahab',
    'adresse': 'Rabat, Hassan, rue Zerktouni',
    'lat': '33.999604',
    'lon': '-6.84453'
  },
  {
    'nom': 'Pharmacie El Baraka',
    'adresse': 'Rabat, Hay Riad, avenue Mahaj',
    'lat': '33.9881815',
    'lon': '-6.8514438'
  },
  {
    'nom': 'Pharmacie El Mohit',
    'adresse': 'Rabat, L Ocean, rue Regitaba',
    'lat': '34.0001770',
    'lon': '-6.8680175'
  },
  {
    'nom': 'Pharmacie El Assala',
    'adresse': 'Rabat, Takadoum, rue Ibn Tachafin',
    'lat': '34.0104413',
    'lon': '-6.8592775'
  },
  {
    'nom': 'Pharmacie L avenir',
    'adresse': 'Rabat, Residence Es-Sabah',
    'lat': '34.0193788',
    'lon': '-6.8499759'
  },
];
