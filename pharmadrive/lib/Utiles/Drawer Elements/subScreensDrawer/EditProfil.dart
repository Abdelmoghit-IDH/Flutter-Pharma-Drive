import 'package:flutter/material.dart';
import 'package:pharmadrive/Providers/dataCenter.dart';
import 'package:pharmadrive/Screens/createPharma.dart';
import 'package:pharmadrive/Screens/monStock.dart';
import 'package:pharmadrive/model/user.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:pharmadrive/Global/SizeConfig.dart';
import 'package:provider/provider.dart';

class EditProfil extends StatefulWidget {
  const EditProfil({Key key}) : super(key: key);

  @override
  _EditProfilState createState() => _EditProfilState();
}

enum Sexe { Homme, Femme }

class _EditProfilState extends State<EditProfil> {
  WholeUserModel userFirebase;

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
  bool textFieldIsActive = false;

  @override
  Widget build(BuildContext context) {
    DataCenter data = Provider.of<DataCenter>(context);
    userFirebase = data.utilisateurConnecte;
    SizeConfig().init(context);
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xffffa140),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.96,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                    "Votre profil",
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
                    backgroundImage: _pickedImage == null
                        ? (userFirebase.imageUrl != null
                            ? NetworkImage(userFirebase.imageUrl)
                            : null)
                        : FileImage(_pickedImage),
                    radius: width * 0.5 / 2,
                    backgroundColor: Color(0x55ffffff),
                    child:
                        (_pickedImage == null && userFirebase.imageUrl == null
                            ? Container(
                                width: SizeConfig.blockSizeHorizontal * 50,
                                height: SizeConfig.blockSizeHorizontal * 50,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          "https://static.thenounproject.com/png/630740-200.png"),
                                      fit: BoxFit.fill),
                                ),
                              )
                            : null),
                  ),
                ),
                Container(
                  width: SizeConfig.blockSizeHorizontal * 13,
                  height: SizeConfig.blockSizeHorizontal * 13,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.2),
                        spreadRadius: 4,
                        blurRadius: 8,
                        offset:
                            Offset(0, 3), // Todo: changes position of shadow
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
                height: 400,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      row("Nom complet", userFirebase.nomComplet),
                      row("Email", userFirebase.email),
                      row("sexe",
                          userFirebase.estHomme == true ? "Homme" : "Femme"),
                      row("Mot de passe", "******"),
                    ],
                  ),
                ),
              ),
              TextButton(
                  onPressed: () async {
                    if (userFirebase.aPharma) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MonStock()),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CreatePharma()),
                      );
                    }
                  },
                  child: Container(
                    height: 50,
                    width: width * 0.8,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      //border: Border.all(color: Colors.black, width: 3),
                    ),
                    child: Center(
                        child: Text(
                      userFirebase.aPharma
                          ? "Gerer mon stock"
                          : "Ajouter une pharmacie",
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
    );
  }

  row(String label, String contenu) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Container(
        //margin: EdgeInsets.all(10.0),
        width: double.infinity,
        //height: 50,
        color: Color(0x33ffbf80),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        label,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontFamily: "Rota",
                          fontSize: SizeConfig.blockSizeHorizontal * 4,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        contenu,
                        style: TextStyle(
                          fontFamily: "Rota",
                          fontSize: SizeConfig.blockSizeHorizontal * 4,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                ),
                IconButton(icon: Icon(Icons.mode_outlined), onPressed: () {})
              ],
            ),
            Divider(
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }

  onClickAddPhoto() {
    var ad = AlertDialog(
      title: Text(
        "Choisir une photo",
        style: TextStyle(
            fontSize: SizeConfig.blockSizeHorizontal * 6,
            fontFamily: 'Rota',
            color: Color(0xff333b3d)),
      ),
      content: Container(
        height: SizeConfig.blockSizeVertical * 20,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Divider(
              color: Colors.black,
            ),
            Container(
              width: SizeConfig.blockSizeHorizontal * 90,
              color: Color(0x44ffa140),
              child: ListTile(
                leading: Icon(
                  Icons.image,
                  size: SizeConfig.blockSizeHorizontal * 6.5,
                ),
                title: Text(
                  "Gallerie",
                  style: TextStyle(
                    fontFamily: 'Rota',
                    color: Color(0xff333b3d),
                    fontSize: SizeConfig.blockSizeHorizontal * 5,
                  ),
                ),
                onTap: () {
                  getImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical,
            ),
            Container(
              color: Color(0x44ffa140),
              child: ListTile(
                leading: Icon(
                  Icons.add_a_photo,
                  size: SizeConfig.blockSizeHorizontal * 6.5,
                ),
                title: Text(
                  "Caméra",
                  style: TextStyle(
                    fontFamily: 'Rota',
                    color: Color(0xff333b3d),
                    fontSize: SizeConfig.blockSizeHorizontal * 5,
                  ),
                ),
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

class CustumTestField extends StatelessWidget {
  CustumTestField({
    @required this.icon,
    Key key,
    @required this.nameController,
    @required this.hindText,
    @required this.labelText,
  }) : super(key: key);

  //* Declaration
  final IconData icon;
  final String hindText, labelText;
  final TextEditingController nameController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        right: SizeConfig.blockSizeHorizontal * 7.5,
        left: SizeConfig.blockSizeHorizontal * 7.5,
      ),
      child: Theme(
        data: ThemeData(
          primaryColor: Color(0xff333b3d),
        ),
        child: TextField(
          controller: nameController,
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(
            hintText: hindText,
            labelText: labelText,
            prefixIcon: Icon(icon),
            hintStyle: TextStyle(color: Colors.grey),
            filled: true,
            fillColor: Color(0xffffbf80),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
          ),
        ),
      ),
    );
  }
}
