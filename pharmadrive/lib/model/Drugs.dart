import 'package:cloud_firestore/cloud_firestore.dart';

class Drug {
  // 1
  String drugName, urlImage, description;
  int price;
  // 2
  DocumentReference reference;
  // 3
  Drug({
    this.drugName,
    this.urlImage,
    this.reference,
    this.description,
    this.price,
  });
  // 4
  factory Drug.fromSnapshot(DocumentSnapshot snapshot) {
    Drug newDrug = Drug.fromJson(snapshot.data());
    newDrug.reference = snapshot.reference;
    return newDrug;
  }

  List<Drug> dataListFromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((snapshot) {
      final Map<String, dynamic> dataMap = snapshot.data();

      return Drug(
        drugName: dataMap['drugName'],
        urlImage: dataMap['urlImage'],
        description: dataMap['description'],
        price: dataMap['price'],
      );
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
    description: json['description'] as String,
    price: json['price'] as int,
  );
}

//2
Map<String, dynamic> _drugToJson(Drug instance) => <String, dynamic>{
      'drugName': instance.drugName,
      'urlImage': instance.urlImage,
      'description':instance.description,
      'price':instance.price,
    };
