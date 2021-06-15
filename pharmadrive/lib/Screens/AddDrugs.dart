import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pharmadrive/Global/SizeConfig.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:pharmadrive/model/user.dart';

List listImage = [];
List list = [];

// ignore: must_be_immutable
class AddDrugs extends StatefulWidget {
  AddDrugs({Key key, this.userFirebase}) : super(key: key);
  final WholeUserModel userFirebase;
  @override
  _AddDrugsState createState() => _AddDrugsState();
}

class _AddDrugsState extends State<AddDrugs> {
  final List<Map<String, dynamic>> listDrug = [];
  bool uploading = false;
  firebase_storage.Reference ref;
  File _imaage;
  final _pickedImage = ImagePicker();

  //**Controller textFields**\\
  TextEditingController myControllerNameDrug = TextEditingController();
  TextEditingController myControllerPrice = TextEditingController();
  TextEditingController myControllerDescription = TextEditingController();

  //**define variables textFields**\\
  String description;
  String nameMedicament;
  int price;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: uploading
          ? Container(
              //..........................this is for loading after uploading an image
              width: double.infinity,
              height: double.infinity,
              child: Center(
                  child: CircularProgressIndicator(
                backgroundColor: Theme.of(context).primaryColor,
              )),
            )
          : Center(
              child: SingleChildScrollView(
                child: Container(
                  height: SizeConfig.blockSizeVertical * 100,
                  width: SizeConfig.blockSizeHorizontal * 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                            "Ajouter un médicament",
                            style: TextStyle(
                              fontFamily: "Rota",
                              fontSize: SizeConfig.blockSizeHorizontal * 6,
                              color: Color(0xff2b383a),
                            ),
                          ),
                        ),
                        trailing: Icon(null),
                      ),
                      Stack(children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                SizeConfig.blockSizeVertical * 30),
                            border: Border.all(color: Colors.black38, width: 3),
                          ),
                          child: CircleAvatar(
                            radius: width * 0.5 / 2,
                            backgroundColor: Color(0x55ffffff),
                            child: _imaage == null
                                ? Container(
                                    width: SizeConfig.blockSizeHorizontal * 50,
                                    height: SizeConfig.blockSizeHorizontal * 50,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              "https://image.freepik.com/free-vector/medicine-drugs-white_25030-44630.jpg"),
                                          fit: BoxFit.fill),
                                    ),
                                  )
                                : CircleAvatar(
                                    backgroundImage: _pickedImage != null
                                        ? FileImage(_imaage)
                                        : null,
                                    radius: width * 0.5 / 2,
                                    backgroundColor: Color(0x55ffffff),
                                  ),
                          ),
                        ),
                        Container(
                          width: SizeConfig.blockSizeHorizontal * 13,
                          height: SizeConfig.blockSizeHorizontal * 13,
                          decoration: BoxDecoration(
                            color: Colors.orangeAccent,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white.withOpacity(0.2),
                                spreadRadius: 4,
                                blurRadius: 8,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: IconButton(
                            onPressed: () {
                              onClickAddPhoto();
                            },
                            icon: Icon(Icons.camera_alt),
                          ),
                        ),
                      ]),
                      Container(
                        height: SizeConfig.blockSizeVertical * 35,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                top: SizeConfig.blockSizeVertical * 2,
                                right: SizeConfig.blockSizeHorizontal * 5,
                                left: SizeConfig.blockSizeHorizontal * 5,
                              ),
                              child: Theme(
                                data:
                                    ThemeData(primaryColor: Color(0xffffa140)),
                                child: TextField(
                                  onChanged: (change) {
                                    print(change);
                                    nameMedicament = change;
                                  },
                                  controller: myControllerNameDrug,
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                  decoration: InputDecoration(
                                    filled: true,
                                    border: OutlineInputBorder(),
                                    hintText: "Nom du médicament",
                                    labelText: "Nom du médicament",
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: SizeConfig.blockSizeVertical * 2,
                                right: SizeConfig.blockSizeHorizontal * 5,
                                left: SizeConfig.blockSizeHorizontal * 5,
                              ),
                              child: Theme(
                                data:
                                    ThemeData(primaryColor: Color(0xffffa140)),
                                child: TextField(
                                  onChanged: (change) {
                                    price = int.parse(change);
                                  },
                                  controller: myControllerPrice,
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                  decoration: InputDecoration(
                                    filled: true,
                                    border: OutlineInputBorder(),
                                    hintText: "Prix médicament",
                                    labelText: "Prix médicament",
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: SizeConfig.blockSizeVertical * 2,
                                right: SizeConfig.blockSizeHorizontal * 5,
                                left: SizeConfig.blockSizeHorizontal * 5,
                              ),
                              child: Theme(
                                data:
                                    ThemeData(primaryColor: Color(0xffffa140)),
                                child: TextField(
                                  onChanged: (change) {
                                    description = change;
                                  },
                                  controller: myControllerDescription,
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                  decoration: InputDecoration(
                                    filled: true,
                                    border: OutlineInputBorder(),
                                    hintText: "Description",
                                    labelText: "Description",
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      TextButton(
                          onPressed: () async {
                            setState(() {
                              uploading = true;
                            });
                            uploadFile(myControllerNameDrug.text).whenComplete(
                                () => Navigator.of(context).pop());
                          },
                          child: Container(
                            height: 50,
                            width: width * 0.8,
                            decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                                child: Text(
                              "Ajouter ce médicament",
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            )),
                          ))
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Future uploadFile(String filename) async {
    var collection = FirebaseFirestore.instance.collection('pharmacie');
    var drugscollection = FirebaseFirestore.instance.collection('Drugs');
    ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('MedicamentImages/$filename');

    await ref.putFile(_imaage).whenComplete(() async {
      var downurl = await ref.getDownloadURL();
      drugscollection
          .doc()
          .set({
            'drugName': nameMedicament,
            'urlImage': downurl.toString(),
            'description': nameMedicament,
            'price': price,
            'nombre': 1,
          })
          .then((_) => print('Ajouter avec succés (drugs)'))
          .catchError((error) => print('Add failed: $error'));

      collection
          .doc(widget.userFirebase.uid.toString())
          .collection('Médicaments')
          .doc(nameMedicament)
          .set({
            'drugName': nameMedicament,
            'urlImage': downurl.toString(),
            'description': nameMedicament,
            'price': price,
            'nombre': 1,
          })
          .then((_) => print('Ajouter avec succés (médicaments)'))
          .catchError((error) => print('Add failed: $error'));
    });
  }

  onClickAddPhoto() {
    var ad = AlertDialog(
      title: Text("Choisir de "),
      content: Container(
        height: 150,
        child: Column(
          children: [
            Divider(
              color: Colors.black,
            ),
            Container(
              width: 300,
              color: Theme.of(context).primaryColor.withOpacity(0.1),
              child: ListTile(
                leading: Icon(Icons.image),
                title: Text("Gallerie"),
                onTap: () {
                  chooseImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 300,
              color: Theme.of(context).primaryColor.withOpacity(0.1),
              child: ListTile(
                leading: Icon(Icons.add_a_photo),
                title: Text("Camera"),
                onTap: () {
                  chooseImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ),
    );
    showDialog(context: context, builder: (BuildContext context) => ad);
  }

  chooseImage(ImageSource x) async {
    final pickedFile = await _pickedImage.getImage(source: x);
    setState(() {
      _imaage = File(pickedFile?.path);
    });
    if (pickedFile.path == null) retrieveLostData();
  }

  Future<void> retrieveLostData() async {
    final LostData response = await _pickedImage.getLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _imaage = File(response.file.path);
      });
    } else {
      print(response.file);
    }
  }
}
