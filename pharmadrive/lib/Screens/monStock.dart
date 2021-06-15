import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pharmadrive/Global/SizeConfig.dart';
import 'package:pharmadrive/Providers/dataCenter.dart';
import 'package:pharmadrive/model/user.dart';
import 'package:provider/provider.dart';

import 'AddDrugs.dart';

class MonStock extends StatefulWidget {
  MonStock({Key key}) : super(key: key);

  @override
  _MonStockState createState() => _MonStockState();
}

class _MonStockState extends State<MonStock> {
  WholeUserModel userFirebase;
  @override
  Widget build(BuildContext context) {
    DataCenter data = Provider.of<DataCenter>(context);
    userFirebase = data.utilisateurConnecte;
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(
          Icons.add,
          color: Color(0xffffa140),
        ),
        label: Text(
          "Ajouter un nouveau medicament",
          style: TextStyle(color: Color(0xffffa140)),
        ),
        backgroundColor: Theme.of(context).bottomAppBarColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddDrugs(
                      userFirebase: userFirebase,
                    )),
          );
        },
      ),
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
                "Gérer mon stock",
                style: TextStyle(
                  fontFamily: "Rota",
                  fontSize: SizeConfig.blockSizeHorizontal * 6,
                  color: Color(0xff2b383a),
                ),
              ),
            ),
            trailing: Icon(null),
          ),
          Container(
            width: SizeConfig.blockSizeHorizontal * 100,
            height: SizeConfig.blockSizeVertical * 70,
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("pharmacie")
                  .doc(userFirebase.uid.toString())
                  .collection('Médicaments')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.data != null) {
                  List<QueryDocumentSnapshot> docs = snapshot.data.docs;

                  return buildListView(docs, userFirebase);
                } else {
                  return Center(
                      child: CircularProgressIndicator(
                    backgroundColor: Theme.of(context).primaryColor,
                  ));
                }
              },
            ),
          ),
        ],
      )),
    );
  }
}

ListView buildListView(
    List<QueryDocumentSnapshot> docsList, WholeUserModel userFirebase) {
  return ListView.builder(
      itemCount: docsList.length,
      itemBuilder: (context, index) {
        return MedicamentItem(
          userFirebase: userFirebase,
          price: docsList[index].data()["price"],
          urlMedicament: docsList[index].data()["urlImage"],
          nameMedicament: docsList[index].data()["drugName"],
          nombre: docsList[index].data()["nombre"],
        );
      });
}

class MedicamentItem extends StatefulWidget {
  MedicamentItem({
    this.nameMedicament,
    this.price,
    this.urlMedicament,
    this.nombre,
    this.userFirebase,
    Key key,
  }) : super(key: key);

  final String nameMedicament;
  final String urlMedicament;
  final int price;
  final int nombre;
  final WholeUserModel userFirebase;

  @override
  _MedicamentItemState createState() => _MedicamentItemState();
}

class _MedicamentItemState extends State<MedicamentItem> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: SizeConfig.blockSizeVertical * 12,
              child: Card(
                color: Colors.orange[100],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    right: SizeConfig.blockSizeHorizontal * 2.5,
                    left: SizeConfig.blockSizeHorizontal * 2,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: SizeConfig.blockSizeHorizontal * 20,
                            height: SizeConfig.blockSizeHorizontal * 20,
                            child: Image.network(widget.urlMedicament),
                          ),
                          SizedBox(
                            width: SizeConfig.blockSizeHorizontal * 2,
                          ),
                          IntrinsicWidth(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Text(
                                  widget.nameMedicament,
                                  style: TextStyle(
                                    fontSize:
                                        SizeConfig.blockSizeHorizontal * 5.5,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  widget.price.toString(),
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize:
                                        SizeConfig.blockSizeHorizontal * 4,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      AddSubButton(
                        widget: widget,
                        nameDrug: widget.nameMedicament,
                        nombre: widget.nombre,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ]);
  }
}

// ignore: must_be_immutable
class AddSubButton extends StatefulWidget {
  AddSubButton({
    this.nameDrug,
    this.nombre,
    Key key,
    @required this.widget,
  }) : super(key: key);

  final MedicamentItem widget;
  final String nameDrug;
  int nombre;

  @override
  _AddSubButtonState createState() => _AddSubButtonState();
}

class _AddSubButtonState extends State<AddSubButton> {
  var collection = FirebaseFirestore.instance.collection('pharmacie');
  int nbr;
  @override
  Widget build(BuildContext context) {
    nbr = widget.nombre;
    print(nbr);
    return Container(
      width: SizeConfig.blockSizeHorizontal * 26,
      child: Row(
        children: [
          Container(
            height: SizeConfig.blockSizeHorizontal * 8,
            decoration: BoxDecoration(),
            child: Container(
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[350],
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(
                              SizeConfig.blockSizeHorizontal * 3,
                            ),
                            bottomLeft: Radius.circular(
                              SizeConfig.blockSizeHorizontal * 3,
                            ))),
                    width: SizeConfig.blockSizeHorizontal * 8,
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          nbr++;
                        });
                        collection
                            .doc(widget.widget.userFirebase.uid.toString())
                            .collection('Médicaments')
                            .doc(widget.nameDrug)
                            .update({
                              'nombre': nbr,
                            })
                            .then((_) => print('Ajouter avec succés'))
                            .catchError((error) => print('Add failed: $error'));
                      },
                      child: Text(
                        "+",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: SizeConfig.blockSizeHorizontal * 3.7,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    child: Container(
                      color: Colors.white,
                      child: Center(
                        child: Text(
                          widget.widget.nombre.toString(),
                          style: TextStyle(
                            fontSize: SizeConfig.blockSizeHorizontal * 5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    width: SizeConfig.blockSizeHorizontal * 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[350],
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(
                                SizeConfig.blockSizeHorizontal * 3),
                            bottomRight: Radius.circular(
                                SizeConfig.blockSizeHorizontal * 3))),
                    width: SizeConfig.blockSizeHorizontal * 8,
                    child: Center(
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            nbr > 0 ? nbr-- : nbr = 0;
                          });
                          collection
                              .doc(widget.widget.userFirebase.uid.toString())
                              .collection('Médicaments')
                              .doc(widget.nameDrug)
                              .update({
                                'nombre': nbr,
                              })
                              .then((_) => print('Ajouter avec succés'))
                              .catchError(
                                  (error) => print('Add failed: $error'));
                        },
                        child: Text(
                          "-",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: SizeConfig.blockSizeHorizontal * 3.7,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
