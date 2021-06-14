import 'package:cloud_firestore/cloud_firestore.dart';

class Pharmacie {
  String imageUrl;
  String uid;
  String nomPharma;
  double longtitude;
  double latitude;

  Pharmacie(
    String imageUrl,
    String uid,
    String nomPharma,
    double longtitude,
    double latitude,
  ) {
    this.imageUrl = imageUrl;
    this.uid = uid;
    this.nomPharma = nomPharma;
    this.longtitude = longtitude;
    this.latitude = latitude;
  }

  //For firebase....................................................
  Map<String, dynamic> pharmaToMap() {
    return {
      'imageUrl': this.imageUrl,
      'uid': this.uid,
      'nomPharma': this.nomPharma,
      'longtitude': this.longtitude,
      'latitude': this.latitude,
    };
  }

  Future/*<DocumentReference>*/ ajouterPharmacie() async {
    await FirebaseFirestore.instance
        .collection('pharmacie')
        .doc(this.uid)
        .set(this.pharmaToMap());
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

Pharmacie toPharmacie(Map<String, dynamic> userMap) {
  return Pharmacie(
    userMap['imageUrl'],
    userMap['uid'],
    userMap['nomPharma'],
    userMap['longtitude'],
    userMap['latitude'],
  );
}
