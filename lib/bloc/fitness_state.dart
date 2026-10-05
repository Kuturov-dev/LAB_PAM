import 'package:flutter/foundation.dart';
import '../models/fitness_models.dart';

enum SortOption { none, durationAsc, durationDesc, caloriesAsc, caloriesDesc }

abstract class FitnessState {
  const FitnessState();
}

class FitnessInitial extends FitnessState {}

class FitnessLoading extends FitnessState {}

class FitnessSuccess extends FitnessState {
  final FitnessAppData data;
  final String selectedFilterId;
  final String searchQuery;
  final SortOption sortOption;
  final Set<String> favoriteIds;
  final bool showOnlyFavorites;

  const FitnessSuccess({
    required this.data,
    this.selectedFilterId = 'all',
    this.searchQuery = '',
    this.sortOption = SortOption.none,
    this.favoriteIds = const {},
    this.showOnlyFavorites = false,
  });

  List<WorkoutProgramItem> get filteredPrograms {
    var list = data.workoutPrograms.map((p) {
      return p.copyWith(isFavorite: favoriteIds.contains(p.id));
    }).toList();

    // 1. Filter by category
    if (selectedFilterId != 'all') {
      list = list.where((p) {
        if (selectedFilterId == 'pilates') {
          return p.title.toLowerCase().contains('arm') ||
              p.title.toLowerCase().contains('pilates');
        }
        if (selectedFilterId == 'cardio') {
          return p.title.toLowerCase().contains('cardio');
        }
        if (selectedFilterId == 'yoga') {
          return p.title.toLowerCase().contains('yoga');
        }
        if (selectedFilterId == 'boxing') {
          return p.title.toLowerCase().contains('boxing');
        }
        return true;
      }).toList();
    }

    // 2. Filter by search query
    if (searchQuery.isNotEmpty) {
      list = list
          .where((p) => p.title.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    }

    // 3. Filter by favorites if enabled
    if (showOnlyFavorites) {
      list = list.where((p) => favoriteIds.contains(p.id)).toList();
    }

    // 4. Sort
    switch (sortOption) {
      case SortOption.durationAsc:
        list.sort((a, b) => a.durationMinutes.compareTo(b.durationMinutes));
        break;
      case SortOption.durationDesc:
        list.sort((a, b) => b.durationMinutes.compareTo(a.durationMinutes));
        break;
      case SortOption.caloriesAsc:
        list.sort((a, b) => a.calories.compareTo(b.calories));
        break;
      case SortOption.caloriesDesc:
        list.sort((a, b) => b.calories.compareTo(a.calories));
        break;
      case SortOption.none:
        break;
    }

    return list;
  }

  FitnessSuccess copyWith({
    FitnessAppData? data,
    String? selectedFilterId,
    String? searchQuery,
    SortOption? sortOption,
    Set<String>? favoriteIds,
    bool? showOnlyFavorites,
  }) {
    return FitnessSuccess(
      data: data ?? this.data,
      selectedFilterId: selectedFilterId ?? this.selectedFilterId,
      searchQuery: searchQuery ?? this.searchQuery,
      sortOption: sortOption ?? this.sortOption,
      favoriteIds: favoriteIds ?? this.favoriteIds,
      showOnlyFavorites: showOnlyFavorites ?? this.showOnlyFavorites,
    );
  }
}

class FitnessEmpty extends FitnessState {
  final String message;

  const FitnessEmpty({this.message = 'No workout programs found.'});
}

class FitnessError extends FitnessState {
  final String errorMessage;

  const FitnessError(this.errorMessage);
}
