import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String email;
  String password;

  UserModel(String email, String password) {
    this.email = email;
    this.password = password;
  }
}

class WholeUserModel {
  String imageUrl;
  String uid;
  String nomComplet;
  String email;
  bool estHomme;
  bool aPharma;

  WholeUserModel(
    String imageUrl,
    String uid,
    String nomComplet,
    String email,
    bool estHomme,
    bool aPharma,
  ) {
    this.imageUrl = imageUrl;
    this.uid = uid;
    this.nomComplet = nomComplet;
    this.email = email;
    this.estHomme = estHomme;
    this.aPharma = aPharma;
  }

  //For firebase....................................................
  Map<String, dynamic> toMap() {
    return {
      'imageUrl': this.imageUrl,
      'uid': this.uid,
      'nomComplet': this.nomComplet,
      'email': this.email,
      'estHomme': this.estHomme,
      'aPharma': this.aPharma,
    };
  }

  Future/*<DocumentReference>*/ ajouterUtilisateur() async {
    await FirebaseFirestore.instance
        .collection('utilisateur')
        .doc(this.uid)
        .set(this.toMap());
    //return doc;
  }

  Future pharmaUser() async {
    await FirebaseFirestore.instance
        .collection('utilisateur')
        .doc(this.uid)
        .update({'aPharma': true});
    //.set(this.toMap());
  }
}

WholeUserModel toWholeUserModel(Map<String, dynamic> userMap) {
  return WholeUserModel(
    userMap['imageUrl'],
    userMap['uid'],
    userMap['nomComplet'],
    userMap['email'],
    userMap['estHomme'],
    userMap['aPharma'],
  );
}
