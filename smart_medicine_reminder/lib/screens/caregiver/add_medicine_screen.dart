import 'package:flutter/material.dart';
import '../../models/medicine_model.dart';
import '../../services/firestore_service.dart';

class AddMedicineScreen extends StatefulWidget {
  const AddMedicineScreen({super.key});

  @override
  State<AddMedicineScreen> createState() => _AddMedicineScreenState();
}

class _AddMedicineScreenState extends State<AddMedicineScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _dosage = '';
  TimeOfDay _selectedTime = TimeOfDay.now();

  void _saveMedicine() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final newMed = MedicineModel(
        id: '', // Firestore generates this
        name: _name,
        dosage: _dosage,
        time: _selectedTime.format(context),
        days: [
          'Monday',
          'Tuesday',
          'Wednesday',
          'Thursday',
          'Friday',
          'Saturday',
          'Sunday'
        ],
      );

      await FirestoreService().addMedicine(newMed);
      if (mounted) Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Add New Medicine",
              style: TextStyle(fontWeight: FontWeight.bold))),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Medicine Name",
                    labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  validator: (val) => val!.isEmpty ? "Enter name" : null,
                  onSaved: (val) => _name = val!,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Dosage (e.g. 1 pill)",
                    labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onSaved: (val) => _dosage = val!,
                ),
                ListTile(
                  title: Text(
                    "Time: ${_selectedTime.format(context)}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  trailing: const Icon(Icons.access_time),
                  onTap: () async {
                    final picked = await showTimePicker(
                        context: context, initialTime: _selectedTime);
                    if (picked != null) setState(() => _selectedTime = picked);
                  },
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: _saveMedicine,
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50)),
                  child: const Text(
                    "Save Schedule",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
