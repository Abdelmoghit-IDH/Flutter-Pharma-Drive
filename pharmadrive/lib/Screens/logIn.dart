import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:pharmadrive/Providers/dataCenter.dart';
import 'package:pharmadrive/model/user.dart';
import 'package:pharmadrive/services/auth.dart';
import 'package:provider/provider.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key key}) : super(key: key);

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
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
  }

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
                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 15,
                    child: Container(),
                  ),
                  Text(
                    "Pharma'drive",
                    style: TextStyle(
                        fontSize: 50,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    flex: 7,
                    child: Container(),
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
                    padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10), //const EdgeInsets.all(20),
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
                          hintText: "Enter votre mot de passe",
                          labelText: "Mot de passe",
                          //icon: Icon(Icons.vpn_key),
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
                  Text(
                    "mot de passe oublié ?",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  Expanded(
                    flex: 10,
                    child: Container(),
                  ),
                  TextButton(
                      onPressed: () async {
                        //TODO

                        /*toggleSpinner();
                        UserModel thisUser = UserModel(
                            emailController.text.trim(),
                            passwordController.text);
                        var response =
                            await _authController.signInUser(thisUser);
                        if (response['status'] == 200) {
                          clearFields();
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Home()));
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(new SnackBar(
                            content: Text(response['error']),
                            duration: new Duration(seconds: 5),
                          ));
                        }
                        toggleSpinner();*/

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
                              content: Text("Entrer votre mot de passe"),
                              duration: new Duration(seconds: 3),
                            ));
                          } else {
                            toggleSpinner();
                            UserModel userAuth = UserModel(
                                emailController.text.trim(),
                                passwordController.text);
                            var response =
                                await _authController.signInUser(userAuth);
                            if (response['status'] == 200) {
                              WholeUserModel utilisateurConnecte;
                              DocumentReference<Map<String, dynamic>> doc =
                                  FirebaseFirestore.instance
                                      .collection("utilisateur")
                                      .doc(response['userUid']);
                              await doc.get().then((doc) {
                                print("teeeeeeeeeeeeeeeeeeeeeeeeeeeeset");
                                print(doc.data());
                                utilisateurConnecte =
                                    toWholeUserModel(doc.data());
                              });
                              data.utilisateurConnecte = utilisateurConnecte;
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
                      },
                      child: Container(
                        height: 50,
                        width: width * 0.6,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              spreadRadius: 01,
                              blurRadius: 8,
                              offset:
                                  Offset(1, 1), // changes position of shadow
                            ),
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          //border: Border.all(color: Colors.black, width: 3),
                        ),
                        child: Center(
                            child: Text(
                          "Se connecter",
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        )),
                      )),
                  SizedBox(
                    height: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/signUp');
                    },
                    child: Container(
                      child: Text(
                        "S'inscrire",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          //decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
