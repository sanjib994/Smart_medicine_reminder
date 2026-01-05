import 'package:flutter/material.dart';
import '../models/medicine_model.dart';
import '../services/firestore_service.dart';

class MedicineProvider with ChangeNotifier {
  final FirestoreService _service = FirestoreService();
  List<MedicineModel> _medicines = [];

  List<MedicineModel> get medicines => _medicines;

  void fetchMedicines() {
    _service.getMedicines().listen((newList) {
      _medicines = newList;
      notifyListeners(); // This tells the UI to refresh
    });
  }
}