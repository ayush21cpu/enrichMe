import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AssignPlanViewModel extends ChangeNotifier {
  String? selectedUserId;
  String? selectedPlanId;

  bool isLoadingUsers = false;
  bool isLoadingPlans = false;
  bool isAssigning = false;

  List<QueryDocumentSnapshot<Map<String, dynamic>>> users = [];
  List<QueryDocumentSnapshot<Map<String, dynamic>>> plans = [];

  String? errorMessage;

  final FirebaseFirestore firestore;

  AssignPlanViewModel({FirebaseFirestore? firestoreInstance})
      : firestore = firestoreInstance ?? FirebaseFirestore.instance {
    fetchUsers();
    fetchPlans();
  }

  Future<void> fetchUsers() async {
    isLoadingUsers = true;
    errorMessage = null;
    notifyListeners();

    try {
      final snapshot = await firestore.collection('users').get();
      users = snapshot.docs;
    } catch (e) {
      errorMessage = 'Failed to load users';
    } finally {
      isLoadingUsers = false;
      notifyListeners();
    }
  }

  Future<void> fetchPlans() async {
    isLoadingPlans = true;
    errorMessage = null;
    notifyListeners();

    try {
      final snapshot = await firestore.collection('fitness_plans').get();
      plans = snapshot.docs;
    } catch (e) {
      errorMessage = 'Failed to load plans';
    } finally {
      isLoadingPlans = false;
      notifyListeners();
    }
  }

  void selectUser(String? id) {
    selectedUserId = id;
    notifyListeners();
  }

  void selectPlan(String? id) {
    selectedPlanId = id;
    notifyListeners();
  }

  Future<bool> assignPlan() async {
    if (selectedUserId == null || selectedPlanId == null) {
      errorMessage = 'Please select user and plan';
      notifyListeners();
      return false;
    }

    isAssigning = true;
    errorMessage = null;
    notifyListeners();

    try {
      await firestore.collection('assigned_plans').add({
        'userId': selectedUserId,
        'planId': selectedPlanId,
      });
      // Reset selections after success
      selectedUserId = null;
      selectedPlanId = null;
      notifyListeners();
      return true;
    } catch (e) {
      errorMessage = 'Failed to assign plan';
      notifyListeners();
      return false;
    } finally {
      isAssigning = false;
      notifyListeners();
    }
  }
}
