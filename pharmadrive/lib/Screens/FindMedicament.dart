import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:pharmadrive/Global/SizeConfig.dart';
import 'package:pharmadrive/model/Drugs.dart';
import 'package:pharmadrive/repository/dataRepository.dart';

class FindMedicament extends StatefulWidget {
  FindMedicament({Key key}) : super(key: key);

  @override
  _FindMedicamentState createState() => _FindMedicamentState();
}

class _FindMedicamentState extends State<FindMedicament> {
  final DataRepository repository = DataRepository();

  //***on ajoute cette valeur pour controler la barre de recherche***//
  TextEditingController _searchController = TextEditingController();

  List _allResult = [];
  List _resultList = [];
  // ignore: unused_field
  Future _resultLoaded;

  getMedicamentStreamSnapshots() async {
    // ignore: deprecated_member_use
    var data = await Firestore.instance.collection('Drugs').getDocuments();
    setState(() {
      // ignore: deprecated_member_use
      _allResult = data.documents;
    });
    searchResultsList();
    return 'Complete';
  }

  searchResultsList() {
    var showResult = [];

    if (_searchController.text != '') {
      //**User il cherche something**/
      for (var medicamentSnapShot in _allResult) {
        final medicamentName =
            Drug.fromSnapshot(medicamentSnapShot).drugName.toLowerCase();
        if (medicamentName.contains(_searchController.text.toLowerCase())) {
          showResult.add(medicamentName);
        }
      }
    } else {
      //**si controller.text='' vide on va afficher tous le resultat**/
      showResult = List.from(_allResult);
    }

    setState(() {
      _resultList = _allResult;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _resultLoaded = getMedicamentStreamSnapshots();
  }

  @override
  void initState() {
    super.initState();
    //***si searchController detecte un changement on faire apple à la fonction _onSearchChange***/
    _searchController.addListener(_onSearchChange);
  }

  _onSearchChange() {
    searchResultsList();
    print(_searchController.text);
  }

  @override
  void dispose() {
    //***Effacer la valeur quand l'utilisateur efface dans TextField***/
    super.dispose();
    _searchController.removeListener(_onSearchChange);
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
        width: SizeConfig.blockSizeHorizontal * 100,
        height: SizeConfig.blockSizeVertical * 100,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(prefix: Icon(Icons.search)),
              ),
            ),
            Container(
              height: SizeConfig.blockSizeVertical * 70,
              child: ListView.builder(
                itemCount: _resultList.length,
                itemBuilder: (BuildContext context, int index) =>
                    _custumDrug(context, _resultList[index]),
              ),
            ),
          ],
        ),
      )),
    );
  }
}

Widget _custumDrug(BuildContext context, DocumentSnapshot document) {
  final drug = Drug.fromSnapshot(document);

  return Container(
    child: Card(
      child: InkWell(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                child: Row(children: <Widget>[
                  Text(
                    drug.drugName,
                    style: TextStyle(fontSize: 23),
                  ),
                  Spacer(),
                ]),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}



/*
StreamBuilder<QuerySnapshot>(
              stream: repository.getStream(),
              builder: (context, snapshot) {
                return (snapshot.connectionState == ConnectionState.waiting)
                    ? Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        // ignore: deprecated_member_use
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (context, index) {
                          // ignore: deprecated_member_use
                          DocumentSnapshot data =
                              // ignore: deprecated_member_use
                              snapshot.data.documents[index];
                          return Card(
                            child: Row(
                              children: <Widget>[
                                Image.network(
                                  data['urlImage'],
                                  width: 150,
                                  height: 100,
                                  fit: BoxFit.fill,
                                ),
                                SizedBox(
                                  width: 25,
                                ),
                                Text(
                                  data['drugName'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
              }),


*/