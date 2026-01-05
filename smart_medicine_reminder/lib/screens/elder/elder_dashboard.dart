import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/medicine_provider.dart';
import '../../widgets/medicine_card.dart';
import '../../services/firestore_service.dart';

class ElderDashboard extends StatefulWidget {
  const ElderDashboard({super.key});

  @override
  State<ElderDashboard> createState() => _ElderDashboardState();
}

class _ElderDashboardState extends State<ElderDashboard> {
  @override
  void initState() {
    super.initState();
    // Start listening to the medicine list immediately
    Provider.of<MedicineProvider>(context, listen: false).fetchMedicines();
  }

  @override
  Widget build(BuildContext context) {
    final medProvider = Provider.of<MedicineProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("My Medicines Today")),
      body: medProvider.medicines.isEmpty
          ? const Center(child: Text("No medicines scheduled."))
          : ListView.builder(
              itemCount: medProvider.medicines.length,
              itemBuilder: (context, index) {
                final med = medProvider.medicines[index];
                return MedicineCard(
                  medicine: med,
                  onTap: () {
                    // Toggle medicine status when Elder clicks it
                    FirestoreService().updateMedicineStatus(med.id, !med.isTaken);
                  },
                );
              },
            ),
    );
  }
}