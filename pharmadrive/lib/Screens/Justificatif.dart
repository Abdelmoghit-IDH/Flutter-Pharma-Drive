import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:intl/intl.dart';
import 'package:path/path.dart' as Path;
import 'package:pharmadrive/Providers/dataCenter.dart';
import 'package:pharmadrive/model/user.dart';
import 'package:provider/provider.dart';

class Justificatif extends StatefulWidget {
  Justificatif({
    Key key,
  }) : super(key: key);
  @override
  _JustificatifState createState() => _JustificatifState();
}

class _JustificatifState extends State<Justificatif> {
  File _imaage;
  final picker = ImagePicker();
  TextEditingController myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    DataCenter data = Provider.of<DataCenter>(context);
    WholeUserModel userFirebase = data.utilisateurConnecte;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffffa140),
        iconTheme: IconThemeData(color: Colors.black //change your color here
            ),
        centerTitle: true,
        title: Text(
          'Envoyer un justificatif',
        ),
        foregroundColor: Colors.black,
        actions: [
          //................................boutton upload
          TextButton(
              onPressed: () async {
                ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                  content: Text("Votre demande sera traité"),
                  duration: new Duration(seconds: 2),
                ));
                Future.delayed(Duration(seconds: 2), () {});
                await userFirebase.pharmaUser();
                setState(() {
                  data.utilisateurConnecte.aPharma = true;
                  userFirebase.aPharma = true;
                });
                //! todo hnaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa 7bst
                Navigator.pushReplacementNamed(context, '/StackProfilHome');
              },
              child: Icon(
                Icons.done_rounded,
                size: 40,
                color: Colors.black, //todo
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.91,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                  //..........................ya hadi ya hadi
                  child: _imaage == null
                      ? IconButton(
                          //..................boutton pour ajouter image
                          icon: Icon(
                            Icons.add_a_photo_outlined,
                            size: 50,
                            color: Color(0xffffa140),
                          ),
                          onPressed: onClickAddPhoto)
                      : Padding(
                          //..................l'image apres etre selectionne
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              height: MediaQuery.of(context).size.height * 0.5,
                              child: Image.file(_imaage)),
                        )),
              //..............................................TextField
              Theme(
                data: Theme.of(context),
                child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: buildTitleTextField(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Theme buildTitleTextField(BuildContext context) {
    return Theme(
      data: ThemeData(primaryColor: Color(0xffffa140)),
      child: TextField(
        controller: myController,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
            filled: true,
            border: OutlineInputBorder(),
            hintText: "Ajouter un commentaire",
            labelText: "Commentaire",
            icon: Icon(
              Icons.comment,
              size: 35,
              color: Color(0xffffa140),
            )),
      ),
    );
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
    final pickedFile = await picker.getImage(source: x);
    setState(() {
      _imaage = File(pickedFile?.path);
    });
    if (pickedFile.path == null) retrieveLostData();
  }

  Future<void> retrieveLostData() async {
    final LostData response = await picker.getLostData();
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

  /*Future uploadFile(String filename) async {
    ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('stations/$stationsName/${Path.basename(_imaage.path)}');
    await ref.putFile(_imaage).whenComplete(() async {
      var downurl = await ref.getDownloadURL();
      var decodedImage = await decodeImageFromList(_imaage.readAsBytesSync());
      await FileStorageService.loadImage(
          stationsName,
          downurl.toString(),
          filename,
          decodedImage.width.toDouble(),
          decodedImage.height.toDouble());
    });
  }*/
}
/*
class FileStorageService extends ChangeNotifier {
  FileStorageService();
  static Future<dynamic> loadImage(String stationName, String imageUrl,
      String filename, double imageWidth, double imageHeight) async {
    await FirebaseFirestore.instance.collection(stationName).add({
      'date': DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now()),
      'imageUrl': imageUrl,
      'title': filename,
      'imageWidth': imageWidth,
      'imageHeight': imageHeight,
    });
  }
}*/
