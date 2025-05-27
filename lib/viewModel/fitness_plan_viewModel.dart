import 'package:flutter/material.dart';
import '../models/fitness_plan.dart';
import '../services/database_service.dart';

class FitnessPlanViewModel extends ChangeNotifier {
  final List<FitnessPlan> _plans = [
    FitnessPlan(
      title: 'Cardio Beginner',
      description: 'Basic cardio training for beginners.',
      type: 'cardio',
      imageUrl: 'lib/res/image/heart.jpg',
    ),
    FitnessPlan(
      title: 'Strength Intermediate',
      description: 'Weight training for intermediate level.',
      type: 'strength',
      imageUrl: 'lib/res/image/strength.jpg',
    ),
    FitnessPlan(
      title: 'Yoga Relaxation',
      description: 'Stretching and breathing routines.',
      type: 'yoga',
      imageUrl: 'lib/res/image/Reflection.jpg',
    ),
  ];


  List<FitnessPlan> get plans => _plans;
  bool _loading = false;
  bool get isLoading => _loading;

  Future<void> savePlan(FitnessPlan plan) async {
    _loading = true;
    notifyListeners();

    try {
      await DatabaseService().savePlanToFirestore(plan);
    } catch (e) {
      rethrow;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
