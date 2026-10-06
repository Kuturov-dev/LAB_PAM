import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/fitness_models.dart';

class FitnessRepository {
  final String assetPath;
  static const String _favKey = 'fitness_favorite_ids';
  static const String _challengeKey = 'fitness_completed_km';

  FitnessRepository({this.assetPath = 'assets/data/fitness_data.json'});

  Future<FitnessAppData> loadFitnessData() async {
    await Future.delayed(const Duration(milliseconds: 600));

    final jsonString = await rootBundle.loadString(assetPath);
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    var data = FitnessAppData.fromJson(jsonMap);

    try {
      final prefs = await SharedPreferences.getInstance();

      if (prefs.containsKey(_challengeKey)) {
        final savedKm = prefs.getInt(_challengeKey) ?? data.todaysChallenge.completed;
        final progress = (savedKm / data.todaysChallenge.total).clamp(0.0, 1.0);
        data = FitnessAppData(
          header: data.header,
          todaysChallenge: data.todaysChallenge.copyWith(completed: savedKm, progress: progress),
          featuredPlans: data.featuredPlans,
          filters: data.filters,
          filterIconUrls: data.filterIconUrls,
          workoutPrograms: data.workoutPrograms,
          gymDetails: data.gymDetails,
        );
      }
    } catch (_) {
      // Fallback gracefully if SharedPreferences is unavailable
    }

    return data;
  }

  Future<Set<String>> loadFavoriteIds() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final list = prefs.getStringList(_favKey) ?? [];
      return list.toSet();
    } catch (_) {
      return {};
    }
  }

  Future<void> saveFavoriteIds(Set<String> favoriteIds) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(_favKey, favoriteIds.toList());
    } catch (_) {}
  }

  Future<void> saveCompletedKm(int completedKm) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_challengeKey, completedKm);
    } catch (_) {}
  }
}
