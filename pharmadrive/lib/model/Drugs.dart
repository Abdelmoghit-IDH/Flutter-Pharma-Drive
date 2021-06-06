import 'package:cloud_firestore/cloud_firestore.dart';

class Drug {
  // 1
  String drugName;
  String urlImage;
  // 2
  DocumentReference reference;
  // 3
  Drug({this.drugName, this.urlImage, this.reference});
  // 4
  factory Drug.fromSnapshot(DocumentSnapshot snapshot) {
    Drug newDrug = Drug.fromJson(snapshot.data());
    newDrug.reference = snapshot.reference;
    return newDrug;
  }

  List<Drug> dataListFromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((snapshot) {
      final Map<String, dynamic> dataMap = snapshot.data();

      return Drug(drugName:dataMap['drugName'],urlImage: dataMap['urlImage']);
    }).toList();
  }
  //5
  factory Drug.fromJson(Map<String, dynamic> json) => _drugFromJson(json);
  // 6
  Map<String, dynamic> toJson() => _drugToJson(this);
  @override
  String toString() => "Drug<drug>";
}

//1
Drug _drugFromJson(Map<dynamic, dynamic> json) {
  return Drug(
    drugName: json['drugName'] as String,
    urlImage: json['urlImage'] as String,
  );
}

//2
Map<String, dynamic> _drugToJson(Drug instance) => <String, dynamic>{
      'vaccination': instance.drugName,
      'urlImage': instance.urlImage,
    };

