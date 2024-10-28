import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final String userId = FirebaseAuth.instance.currentUser!.uid;

  Future<DocumentSnapshot> _getPharmacistData() async {
    return await FirebaseFirestore.instance
        .collection('pharmacists')
        .doc(userId)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الشاشة الرئيسية'),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: _getPharmacistData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('حدث خطأ أثناء تحميل البيانات.'));
          }

          final pharmacistData = snapshot.data!.data() as Map<String, dynamic>;
          final pharmacyId = pharmacistData['pharmacy_id'];

          return FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance
                .collection('pharmacies')
                .doc(pharmacyId)
                .get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return const Center(child: Text('حدث خطأ أثناء تحميل الصيدلية.'));
              }

              final pharmacyData = snapshot.data!.data() as Map<String, dynamic>;

              return Center(
                child: Text(
                  'مرحبًا بك في صيدلية ${pharmacyData['name']}',
                  style: const TextStyle(fontSize: 24),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
