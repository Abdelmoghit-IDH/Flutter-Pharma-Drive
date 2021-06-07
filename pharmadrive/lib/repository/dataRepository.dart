import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pharmadrive/model/Drugs.dart';

class DataRepository {
  // 1
  // ignore: deprecated_member_use
  final CollectionReference collection = Firestore.instance.collection('Drugs');
  // 2
  Stream<QuerySnapshot> getStream() {
    return collection.snapshots();
  }
  // 3
  Future<DocumentReference> addDrug(Drug drug) {
    return collection.add(drug.toJson());
  }
  // 4
  updateDrug(Drug drug) async {
    // ignore: deprecated_member_use
    await collection.document(drug.reference.documentID).updateData(drug.toJson());
  }
}
