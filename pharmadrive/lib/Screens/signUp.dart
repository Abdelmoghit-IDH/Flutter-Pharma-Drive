import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:pharmadrive/Global/SizeConfig.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

enum Sexe { Homme, Femme }

class _SignUpState extends State<SignUp> {
  File _pickedImage1;
  final picker = ImagePicker();
  Future getImage(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _pickedImage1 = File(pickedFile.path);
      } else {
        print("walo walo");
      }
    });
  }

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _showPassword = false;
  bool textFieldIsActive = false;
  Sexe _site;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: Color(0xffffa140),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.96,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ListTile(
                leading: Icon(
                  Icons.arrow_back,
                  size: SizeConfig.blockSizeHorizontal * 8,
                  color: Color(0xff2b383a),
                ),
                title: Center(
                  child: Text(
                    "Editer le profil",
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
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(SizeConfig.blockSizeVertical * 30),
                  border: Border.all(color: Colors.black38, width: 3),
                ),
                child: CircleAvatar(
                  backgroundImage:
                      _pickedImage1 != null ? FileImage(_pickedImage1) : null,
                  radius: width * 0.5 / 2,
                  backgroundColor: Color(0x55ffffff),
                  child: _pickedImage1 == null
                      ? IconButton(
                          icon: Icon(
                            Icons.add_a_photo_outlined,
                            size: SizeConfig.blockSizeHorizontal * 10,
                            color: Colors.black38,
                          ),
                          onPressed: onClickAddPhoto)
                      : null,
                ),
              ),
              Container(
                height: SizeConfig.blockSizeVertical * 35,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        right: SizeConfig.blockSizeHorizontal * 6,
                        left: SizeConfig.blockSizeHorizontal * 6,
                      ),
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
                              icon: Icon(Icons.person)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        right: SizeConfig.blockSizeHorizontal * 6,
                        left: SizeConfig.blockSizeHorizontal * 6,
                      ),
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
                              icon: Icon(Icons.person)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        right: SizeConfig.blockSizeHorizontal * 6,
                        left: SizeConfig.blockSizeHorizontal * 6,
                      ),
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
                              icon: Icon(Icons.person)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Container(
                  width: SizeConfig.blockSizeHorizontal * 80,
                  height: SizeConfig.blockSizeVertical * 8,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    //border: Border.all(color: Colors.black, width: 3),
                  ),
                  child: Center(
                      child: Text(
                    "Confirmer la modification",
                    style: TextStyle(
                        fontSize: SizeConfig.blockSizeHorizontal * 6,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  )),
                ),
              ),
            ],
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



/**
 

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
                        _pickedImage1 != null ? FileImage(_pickedImage1) : null,
                    radius: width * 0.5 / 2,
                    backgroundColor: Color(0x55ffffff),
                    child: _pickedImage1 == null
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
                          icon: Icon(Icons.person)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Theme(
                    data: ThemeData(
                      primaryColor: Color(0xff333b3d),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          textFieldIsActive = true;
                        });
                      },
                      child: TextField(
                        enabled: false,
                        controller: emailController,
                        //textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(
                            fillColor: Color(0xffffbf80),
                            filled: true,
                            border: OutlineInputBorder(),
                            hintText: "Enter votre email",
                            labelText: "abdelmoghit.idhsaine@gmail.com",
                            icon: Icon(Icons.email)),
                      ),
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
                        icon: Icon(Icons.vpn_key),
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.remove_red_eye,
                            color: this._showPassword
                                ? Color(0xff333b3d)
                                : Colors.grey,
                          ),
                          onPressed: () {
                            setState(
                                () => this._showPassword = !this._showPassword);
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
                          groupValue: _site,
                          onChanged: (Sexe value) {
                            setState(() {
                              _site = value;
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: const Text('Femme'),
                        leading: Radio<Sexe>(
                          activeColor: Colors.black,
                          value: Sexe.Femme,
                          groupValue: _site,
                          onChanged: (Sexe value) {
                            setState(() {
                              _site = value;
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
                    onPressed: () {},
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






 */