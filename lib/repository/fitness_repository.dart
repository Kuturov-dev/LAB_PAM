import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/fitness_models.dart';

class FitnessRepository {
  final String assetPath;

  FitnessRepository({this.assetPath = 'assets/data/fitness_data.json'});

  Future<FitnessAppData> loadFitnessData() async {
    // Simulate slight asynchronous delay for realistic Loading state demo
    await Future.delayed(const Duration(milliseconds: 600));

    final jsonString = await rootBundle.loadString(assetPath);
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    return FitnessAppData.fromJson(jsonMap);
  }
}
