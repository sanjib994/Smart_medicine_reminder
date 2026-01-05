import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/medicine_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Add Medicine (Caregiver Role)
  Future<void> addMedicine(MedicineModel medicine) {
    return _db.collection('medicines').add(medicine.toMap());
  }

  // Stream of Medicines for the Elder
  Stream<List<MedicineModel>> getMedicines() {
    return _db.collection('medicines').snapshots().map((snapshot) =>
        snapshot.docs
            .map((doc) => MedicineModel.fromMap(doc.data(), doc.id))
            .toList());
  }

  // Mark medicine as taken
  Future<void> updateMedicineStatus(String id, bool status) {
    return _db.collection('medicines').doc(id).update({'isTaken': status});
  }
}