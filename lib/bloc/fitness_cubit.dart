import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/fitness_models.dart';
import '../repository/fitness_repository.dart';
import 'fitness_state.dart';

class FitnessCubit extends Cubit<FitnessState> {
  final FitnessRepository repository;

  FitnessCubit(this.repository) : super(FitnessInitial());

  Future<void> loadData() async {
    emit(FitnessLoading());
    try {
      final data = await repository.loadFitnessData();
      emit(FitnessSuccess(data: data));
    } catch (e) {
      emit(FitnessError('Failed to load fitness data: ${e.toString()}'));
    }
  }

  void selectFilter(String filterId) {
    if (state is FitnessSuccess) {
      final current = state as FitnessSuccess;
      final newState = current.copyWith(selectedFilterId: filterId);
      if (newState.filteredPrograms.isEmpty) {
        emit(const FitnessEmpty(message: 'No programs found for this category.'));
      } else {
        emit(newState);
      }
    } else if (state is FitnessEmpty) {
      loadData().then((_) {
        selectFilter(filterId);
      });
    }
  }

  void updateSearchQuery(String query) {
    if (state is FitnessSuccess || state is FitnessEmpty) {
      FitnessSuccess? current;
      if (state is FitnessSuccess) {
        current = state as FitnessSuccess;
      }
      if (current != null) {
        final newState = current.copyWith(searchQuery: query);
        if (newState.filteredPrograms.isEmpty) {
          emit(const FitnessEmpty(message: 'No workout programs match your search.'));
        } else {
          emit(newState);
        }
      }
    }
  }

  void setSortOption(SortOption option) {
    if (state is FitnessSuccess) {
      final current = state as FitnessSuccess;
      emit(current.copyWith(sortOption: option));
    }
  }

  void toggleFavorite(String programId) {
    if (state is FitnessSuccess) {
      final current = state as FitnessSuccess;
      final newFavorites = Set<String>.from(current.favoriteIds);
      if (newFavorites.contains(programId)) {
        newFavorites.remove(programId);
      } else {
        newFavorites.add(programId);
      }
      emit(current.copyWith(favoriteIds: newFavorites));
    }
  }

  void toggleShowOnlyFavorites() {
    if (state is FitnessSuccess) {
      final current = state as FitnessSuccess;
      final newState = current.copyWith(showOnlyFavorites: !current.showOnlyFavorites);
      if (newState.filteredPrograms.isEmpty && newState.showOnlyFavorites) {
        emit(const FitnessEmpty(message: 'No favorite workouts added yet.'));
      } else {
        emit(newState);
      }
    }
  }

  void updateChallengeProgress(int newCompleted) {
    if (state is FitnessSuccess) {
      final current = state as FitnessSuccess;
      final challenge = current.data.todaysChallenge;
      final clampedCompleted = newCompleted.clamp(0, challenge.total);
      final newProgress = (clampedCompleted / challenge.total).clamp(0.0, 1.0);

      final updatedChallenge = challenge.copyWith(
        completed: clampedCompleted,
        progress: newProgress,
      );

      final updatedData = FitnessAppData(
        header: current.data.header,
        todaysChallenge: updatedChallenge,
        featuredPlans: current.data.featuredPlans,
        filters: current.data.filters,
        filterIconUrls: current.data.filterIconUrls,
        workoutPrograms: current.data.workoutPrograms,
        gymDetails: current.data.gymDetails,
      );

      emit(current.copyWith(data: updatedData));
    }
  }

  void addWorkoutProgram(WorkoutProgramItem newProgram) {
    if (state is FitnessSuccess) {
      final current = state as FitnessSuccess;
      final updatedList = List<WorkoutProgramItem>.from(current.data.workoutPrograms)
        ..add(newProgram);

      final updatedData = FitnessAppData(
        header: current.data.header,
        todaysChallenge: current.data.todaysChallenge,
        featuredPlans: current.data.featuredPlans,
        filters: current.data.filters,
        filterIconUrls: current.data.filterIconUrls,
        workoutPrograms: updatedList,
        gymDetails: current.data.gymDetails,
      );

      emit(current.copyWith(data: updatedData));
    } else if (state is FitnessEmpty) {
      // Re-initialize success state with newly added item
      loadData().then((_) {
        addWorkoutProgram(newProgram);
      });
    }
  }
}
