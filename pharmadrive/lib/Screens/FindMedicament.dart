import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pharmadrive/Global/SizeConfig.dart';
import 'package:pharmadrive/model/Drugs.dart';

class FindMedicament extends StatefulWidget {
  FindMedicament({Key key}) : super(key: key);

  @override
  _FindMedicamentState createState() => _FindMedicamentState();
}

class _FindMedicamentState extends State<FindMedicament> {
  //***on ajoute cette valeur pour controler la barre de recherche***//
  TextEditingController _searchController = TextEditingController();

  //***declaration des list utilisée pour faire la recherche***//
  List _allResult = [];
  List _resultList = [];
  // ignore: unused_field
  Future _resultLoaded;

  //***fonction pour avoir les medicament depuis firebase***//
  getMedicamentStreamSnapshots() async {
    // ignore: deprecated_member_use
    var data = await Firestore.instance.collection('Drugs').getDocuments();
    setState(() {
      // ignore: deprecated_member_use
      _allResult = data.documents;
    });
    searchResultsList();
    return 'Tous le données sont prés à utilisée';
  }

  //***Filtrer le resultat on se basant sur ce qui ecrit l user***//
  searchResultsList() {
    var showResult = [];

    //**User il cherche something**/
    if (_searchController.text != '') {
      for (var medicamentSnapShot in _allResult) {
        final medicamentName =
            Drug.fromSnapshot(medicamentSnapShot).drugName.toLowerCase();
        if (medicamentName.contains(_searchController.text.toLowerCase())) {
          showResult.add(medicamentSnapShot);
        }
      }
    }
    //**si controller.text='' vide on va afficher tous le resultat**/
    else {
      showResult = List.from(_allResult);
    }

    setState(() {
      _resultList = showResult;
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
    //***Effacer TextField lorsque l'utilisateur commence à effacer***/
    super.dispose();
    _searchController.removeListener(_onSearchChange);
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.orange[100],
        body: Stack(children: [
          MedicamentSearch(
              searchController: _searchController, resultList: _resultList),
          NumberOfProducts(resultList: _resultList),
        ]));
  }
}

// Todo: Stack Elements

class NumberOfProducts extends StatelessWidget {
  const NumberOfProducts({
    Key key,
    @required List resultList,
  })  : _resultList = resultList,
        super(key: key);

  final List _resultList;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          SizedBox(
            height: SizeConfig.blockSizeVertical * 17,
          ),
          Text("${_resultList.length} Products",
              style: TextStyle(
                fontSize: SizeConfig.blockSizeHorizontal * 5,
                fontWeight: FontWeight.bold,
              )),
        ],
      ),
    );
  }
}

class MedicamentSearch extends StatelessWidget {
  const MedicamentSearch({
    Key key,
    @required TextEditingController searchController,
    @required List resultList,
  })  : _searchController = searchController,
        _resultList = resultList,
        super(key: key);

  final TextEditingController _searchController;
  final List _resultList;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: SizeConfig.blockSizeVertical * 3),
            Container(
              height: SizeConfig.blockSizeVertical * 20,
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
                        "Trouver un médicament",
                        style: TextStyle(
                          fontFamily: "Rota",
                          fontSize: SizeConfig.blockSizeHorizontal * 6,
                          color: Color(0xff2b383a),
                        ),
                      ),
                    ),
                    trailing: Icon(null),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      height: SizeConfig.blockSizeVertical * 6,
                      child: CupertinoSearchTextField(
                        itemSize: SizeConfig.blockSizeHorizontal * 8,
                        controller: _searchController,
                        style: TextStyle(
                          fontSize: SizeConfig.blockSizeHorizontal * 5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: SizeConfig.blockSizeVertical * 75,
              child: ListView.builder(
                itemCount: _resultList.length,
                itemBuilder: (BuildContext context, int index) =>
                    _custumWidgetDrug(context, _resultList[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Todo: fin Stack Elements

// Todo: Reasuble widget design medicament

Widget _custumWidgetDrug(BuildContext context, DocumentSnapshot document) {
  final drug = Drug.fromSnapshot(document);
  return Padding(
    padding: const EdgeInsets.only(left: 10, right: 10, bottom: 8),
    child: Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.2),
            spreadRadius: 4,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      width: SizeConfig.blockSizeHorizontal * 100,
      height: SizeConfig.blockSizeVertical * 20,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        color: Colors.white,
        child: InkWell(
          child: Row(children: <Widget>[
            Container(
              height: SizeConfig.blockSizeVertical * 20,
              width: SizeConfig.blockSizeHorizontal * 35,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  drug.urlImage,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: SizeConfig.blockSizeHorizontal * 2.5,
            ),
            Container(
              width: SizeConfig.blockSizeHorizontal * 50,
              child: IntrinsicWidth(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      drug.drugName,
                      style: TextStyle(
                        fontSize: SizeConfig.blockSizeHorizontal * 7,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      drug.description == null ? "null" : drug.description,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: SizeConfig.blockSizeHorizontal * 3,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${drug.price} MAD',
                          style: TextStyle(
                            fontSize: SizeConfig.blockSizeHorizontal * 5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // ignore: deprecated_member_use
                        Container(
                          width: SizeConfig.blockSizeHorizontal * 20,
                          // ignore: deprecated_member_use
                          child: FlatButton(
                            color: Color(0xffff8000),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(28.0),
                            ),
                            onPressed: () {},
                            child: Text(
                              "Acheter",
                              style: TextStyle(
                                fontSize: SizeConfig.blockSizeHorizontal * 3,
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    ),
  );
}
