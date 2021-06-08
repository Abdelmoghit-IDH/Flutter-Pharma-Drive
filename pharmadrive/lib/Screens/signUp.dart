import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:pharmadrive/Providers/dataCenter.dart';
import 'package:pharmadrive/model/user.dart';
import 'package:pharmadrive/services/auth.dart';
import 'package:path/path.dart' as Path;
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

enum Sexe { Homme, Femme }

class _SignUpState extends State<SignUp> {
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
  bool _showPassword = false;

  AuthController _authController = AuthController();

  bool isWaiting = false;

  toggleSpinner() {
    setState(() {
      isWaiting = !isWaiting;
    });
  }

  clearFields() {
    emailController.text = '';
    passwordController.text = '';
    nameController.text = '';
    _sexeChoisi = null;
  }

  Sexe _sexeChoisi;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    //double height = MediaQuery.of(context).size.height;
    DataCenter data = Provider.of<DataCenter>(context);

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
                            hintText: "Enter votre nom complet",
                            labelText: "Nom et prénom",
                            prefixIcon: Icon(Icons.person)),
                      ),
                    ),
                  ),
                  Padding(
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
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    //EdgeInsets.symmetric(horizontal: 20, vertical: 20), //const EdgeInsets.all(20),
                    child: Theme(
                      data: ThemeData(
                        primaryColor: Color(0xff333b3d),
                      ),
                      child: TextField(
                        enableSuggestions: false,
                        autocorrect: false,
                        obscureText: !this._showPassword,
                        controller: passwordController,
                        //textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(
                          fillColor: Color(0xffffbf80),
                          filled: true,
                          border: OutlineInputBorder(),
                          hintText: "Choisir un mot de passe",
                          labelText: "Mot de passe",
                          prefixIcon: Icon(Icons.vpn_key),
                          suffixIcon: IconButton(
                            icon: Icon(
                              Icons.remove_red_eye,
                              color: this._showPassword
                                  ? Color(0xff333b3d)
                                  : Colors.grey,
                            ),
                            onPressed: () {
                              setState(() =>
                                  this._showPassword = !this._showPassword);
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          title: const Text('Homme'),
                          leading: Radio<Sexe>(
                            activeColor: Colors.black,
                            value: Sexe.Homme,
                            groupValue: _sexeChoisi,
                            onChanged: (Sexe value) {
                              setState(() {
                                _sexeChoisi = value;
                                print(_sexeChoisi.index);
                              });
                            },
                          ),
                        ),
                        ListTile(
                          title: const Text('Femme'),
                          leading: Radio<Sexe>(
                            activeColor: Colors.black,
                            value: Sexe.Femme,
                            groupValue: _sexeChoisi,
                            onChanged: (Sexe value) {
                              setState(() {
                                _sexeChoisi = value;
                                print(_sexeChoisi.index);
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 15,
                    child: Container(),
                  ),
                  TextButton(
                      onPressed: () async {
                        if (nameController.text.compareTo("") == 0) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(new SnackBar(
                            content: Text("Entrer votre nom complet"),
                            duration: new Duration(seconds: 3),
                          ));
                        } else {
                          if (emailController.text.compareTo("") == 0) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(new SnackBar(
                              content: Text("Entrer votre email"),
                              duration: new Duration(seconds: 3),
                            ));
                          } else {
                            if (passwordController.text.compareTo("") == 0) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(new SnackBar(
                                content: Text("Entrer un mot de passe"),
                                duration: new Duration(seconds: 3),
                              ));
                            } else {
                              if (_sexeChoisi == null) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(new SnackBar(
                                  content: Text("Choisir votre sexe"),
                                  duration: new Duration(seconds: 5),
                                ));
                              } else {
                                toggleSpinner();
                                UserModel userAuth = UserModel(
                                    emailController.text.trim(),
                                    passwordController.text);
                                var response =
                                    await _authController.signUpUser(userAuth);
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
                                }
                                toggleSpinner();
                              }
                            }
                          }
                        }
                        //TODO
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
                          "S'inscrire",
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
