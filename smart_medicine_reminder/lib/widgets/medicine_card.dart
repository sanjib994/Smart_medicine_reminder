import 'package:flutter/material.dart';
import '../models/medicine_model.dart';

class MedicineCard extends StatelessWidget {
  final MedicineModel medicine;
  final VoidCallback onTap;

  const MedicineCard({super.key, required this.medicine, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        leading: const CircleAvatar(child: Icon(Icons.medication)),
        title: Text(medicine.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text("${medicine.dosage} • ${medicine.time}"),
        trailing: Icon(
          medicine.isTaken ? Icons.check_circle : Icons.radio_button_unchecked,
          color: medicine.isTaken ? Colors.green : Colors.grey,
        ),
        onTap: onTap,
      ),
    );
  }
}