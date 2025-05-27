import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/fitness_plan.dart';

class DatabaseService {
  final _db = FirebaseFirestore.instance;

  Future<void> savePlanToFirestore(FitnessPlan plan) async {
    await _db.collection('fitness_plans').add(plan.toMap());
  }
}
