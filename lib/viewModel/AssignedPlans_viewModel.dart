import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AssignedPlansViewModel extends ChangeNotifier {
  List<Map<String, dynamic>> _plans = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Map<String, dynamic>> get plans => _plans;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchAssignedPlans() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) {
        _plans = [];
        _errorMessage = "User not logged in";
        _isLoading = false;
        notifyListeners();
        return;
      }

      final assignedSnapshot = await FirebaseFirestore.instance
          .collection('assigned_plans')
          .where('userId', isEqualTo: userId)
          .get();

      List<Map<String, dynamic>> tempPlans = [];

      for (var assignedDoc in assignedSnapshot.docs) {
        final planId = assignedDoc['planId'];

        final planDoc = await FirebaseFirestore.instance
            .collection('fitness_plans')
            .doc(planId)
            .get();

        if (planDoc.exists) {
          tempPlans.add({
            'title': planDoc['title'],
            'description': planDoc['description'],
            'type': planDoc['type'],
          });
        }
      }

      _plans = tempPlans;
    } catch (e) {
      _errorMessage = "Failed to load plans: $e";
    }

    _isLoading = false;
    notifyListeners();
  }
}
