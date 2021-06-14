import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:pharmadrive/Providers/dataCenter.dart';
import 'package:pharmadrive/model/user.dart';
import 'package:pharmadrive/services/auth.dart';
import 'package:path/path.dart' as Path;
import 'package:provider/provider.dart';
import 'package:pharmadrive/model/pharma.dart';

class CreatePharma extends StatefulWidget {
  const CreatePharma({Key key}) : super(key: key);

  @override
  _CreatePharmaState createState() => _CreatePharmaState();
}

class _CreatePharmaState extends State<CreatePharma> {
  File _pickedImage;
  final picker = ImagePicker();
  Future getImage(ImageSource source) async {
    final pickedFile =
        await picker.getImage(source: source, maxWidth: 150, imageQuality: 50);

    setState(() {
      if (pickedFile != null) {
        _pickedImage = File(pickedFile.path);
      } else {
        print("walo walo");
      }
    });
  }

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _locationChoosen = false;

  AuthController _authController = AuthController();

  bool isWaiting = false;

  toggleSpinner() {
    setState(() {
      isWaiting = !isWaiting;
    });
  }

  clearFields() {
    nameController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    //double height = MediaQuery.of(context).size.height;
    DataCenter data = Provider.of<DataCenter>(context);
    LocationData _locationData;
    double lon;
    double lat;

    return ModalProgressHUD(
      inAsyncCall: isWaiting,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Color(0xffffa140),
          body: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.96,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 15,
                    child: Container(),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(1300),
                      border: Border.all(color: Colors.black38, width: 3),
                    ),
                    child: CircleAvatar(
                      backgroundImage:
                          _pickedImage != null ? FileImage(_pickedImage) : null,
                      radius: width * 0.5 / 2,
                      backgroundColor: Color(0x55ffffff),
                      child: _pickedImage == null
                          ? IconButton(
                              icon: Icon(
                                Icons.add_a_photo_outlined,
                                size: 40,
                                color: Colors.black38,
                              ),
                              onPressed: onClickAddPhoto)
                          : null,
                    ),
                  ),
                  Expanded(
                    flex: 15,
                    child: Container(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Theme(
                      data: ThemeData(
                        primaryColor: Color(0xff333b3d),
                      ),
                      child: TextField(
                        controller: nameController,
                        textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(
                            fillColor: Color(0xffffbf80),
                            filled: true,
                            border: OutlineInputBorder(),
                            hintText: "Enter le nom de votre pharmacie",
                            labelText: "Nom de la pharmacie",
                            prefixIcon: Icon(Icons.person)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextButton(
                        onPressed: () async {
                          Location location = new Location();

                          bool _serviceEnabled;
                          PermissionStatus _permissionGranted;
                          LocationData _locationData;

                          _serviceEnabled = await location.serviceEnabled();
                          if (!_serviceEnabled) {
                            _serviceEnabled = await location.requestService();
                            if (!_serviceEnabled) {
                              return;
                            }
                          }
                          _permissionGranted = await location.hasPermission();
                          if (_permissionGranted == PermissionStatus.denied) {
                            _permissionGranted =
                                await location.requestPermission();
                            if (_permissionGranted !=
                                PermissionStatus.granted) {
                              return;
                            }
                          }
                          _locationData = await location.getLocation();
                          setState(() {
                            _locationChoosen = true;
                            lon = _locationData.longitude;
                            lat = _locationData.latitude;
                          });
                          print("heeeeeeeeeeeeeeeh" +
                              _locationData.latitude.toString());
                        },
                        child: Container(
                          child: Row(
                            children: [
                              Icon(
                                Icons.my_location,
                                color: Color(0xff333b3d),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                child: Text(
                                  "Cliquer pour ajouter la postion de votre pharmacie",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Color(0xff333b3d)),
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Icon(
                                _locationChoosen ? Icons.done : null, //todo
                                color: Color(0xff333b3d),
                              ),
                            ],
                          ),
                        )),
                  )
                  /*Padding(
                    padding: const EdgeInsets.all(20),
                    child: Theme(
                      data: ThemeData(
                        primaryColor: Color(0xff333b3d),
                      ),
                      child: TextField(
                        controller: emailController,
                        //textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(
                            fillColor: Color(0xffffbf80),
                            filled: true,
                            border: OutlineInputBorder(),
                            hintText: "Enter votre email",
                            labelText: "Email",
                            prefixIcon: Icon(Icons.email)),
                      ),
                    ),
                  ),*/
                  ,
                  Expanded(
                    flex: 15,
                    child: Container(),
                  ),
                  TextButton(
                      onPressed: () async {
                        if (nameController.text.compareTo("") == 0) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(new SnackBar(
                            content: Text("Entrer le nom de votre pharmacie"),
                            duration: new Duration(seconds: 3),
                          ));
                        } else {
                          if (_locationChoosen == false) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(new SnackBar(
                              content: Text(
                                  "Ajouter la position de votre pharmacie"),
                              duration: new Duration(seconds: 3),
                            ));
                          } else {
                            toggleSpinner(); //todo
                            //var long = _locationData.longitude;
                            Location location = new Location();
                            _locationData = await location.getLocation();
                            var imageUrl;
                            if (_pickedImage != null) {
                              var ref = FirebaseStorage.instance
                                  .ref()
                                  .child("pharmaImage")
                                  .child("${Path.basename(_pickedImage.path)}");
                              await ref.putFile(_pickedImage);
                              imageUrl = await ref.getDownloadURL();
                            }
                            Pharmacie pharmacie = Pharmacie(
                                imageUrl,
                                data.utilisateurConnecte.uid,
                                nameController.text,
                                _locationData.longitude,
                                _locationData.latitude);
                            await pharmacie.ajouterPharmacie();
                            data.pharmaConnecte = pharmacie;
                            clearFields();
                            Navigator.pushNamed(context, '/Justificatif');
                            //_locationData;
                            /*
                               
                                if (response['status'] == 200) {
                                  var imageUrl;
                                  if (_pickedImage != null) {
                                    var ref = FirebaseStorage.instance
                                        .ref()
                                        .child("userImage")
                                        .child(
                                            "${Path.basename(_pickedImage.path)}");
                                    await ref.putFile(_pickedImage);
                                    imageUrl = await ref.getDownloadURL();
                                  }

                                  WholeUserModel userFirebase = WholeUserModel(
                                      //todo ici url par defaut avant l upload
                                      imageUrl,
                                      response['user'].uid,
                                      nameController.text.trim(),
                                      emailController.text.trim(),
                                      _sexeChoisi.index == 0,
                                      false);
                                  await userFirebase.ajouterUtilisateur();
                                  data.utilisateurConnecte = userFirebase;
                                  clearFields();
                                  Navigator.pushReplacementNamed(
                                      context, '/StackProfilHome');
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(new SnackBar(
                                    content: Text(response['error']),
                                    duration: new Duration(seconds: 5),
                                  ));
                                }*/
                            toggleSpinner();
                          }
                        }
                      },
                      child: Container(
                        height: 50,
                        width: width * 0.6,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          //border: Border.all(color: Colors.black, width: 3),
                        ),
                        child: Center(
                            child: Text(
                          "Suivant",
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        )),
                      )),
                  SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 7,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  onClickAddPhoto() {
    var ad = AlertDialog(
      //backgroundColor: Color(0x99ffbf80),
      title: Text("Choisir la photo de"),
      content: Container(
        height: 150,
        child: Column(
          children: [
            Divider(
              color: Colors.black,
            ),
            Container(
              width: 300,
              color: Color(0x44ffa140),
              child: ListTile(
                leading: Icon(Icons.image),
                title: Text("Gallerie"),
                onTap: () {
                  getImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 300,
              color: Color(0x44ffa140),
              child: ListTile(
                leading: Icon(Icons.add_a_photo),
                title: Text("Caméra"),
                onTap: () {
                  getImage(ImageSource.camera);
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
}
