import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/fitness_cubit.dart';
import '../../bloc/fitness_state.dart';
import '../../core/constants/app_colors.dart';
import '../../shared/widgets/state_widgets.dart';
import '../details/gym_details_page.dart';
import '../programs/all_programs_page.dart';
import 'widgets/category_chips_section.dart';
import 'widgets/featured_plans_section.dart';
import 'widgets/home_header.dart';
import 'widgets/section_header.dart';
import 'widgets/today_challenge_card.dart';
import 'widgets/workout_programs_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _navigateToDetails(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const GymDetailsPage()),
    );
  }

  void _navigateToAllPrograms(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AllProgramsPage()),
    );
  }

  void _showNotificationsSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Notifications',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: kInk,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const Divider(),
              const ListTile(
                leading: CircleAvatar(
                  backgroundColor: Color(0xFFE7FFF1),
                  child: Icon(Icons.fitness_center, color: kGreen, size: 20),
                ),
                title: Text('New Workout Available'),
                subtitle: Text('Power Yoga has been added to your plan.'),
                trailing: Text('10m ago', style: TextStyle(fontSize: 12, color: kGrey)),
              ),
              const ListTile(
                leading: CircleAvatar(
                  backgroundColor: Color(0xFFE7FFF1),
                  child: Icon(Icons.directions_run, color: kGreen, size: 20),
                ),
                title: Text('Daily Challenge Progress'),
                subtitle: Text('Keep going to hit your 20 km goal!'),
                trailing: Text('1h ago', style: TextStyle(fontSize: 12, color: kGrey)),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FitnessCubit>();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.white,
      ),
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<FitnessCubit, FitnessState>(
            builder: (context, state) {
              if (state is FitnessLoading || state is FitnessInitial) {
                return const LoadingStateWidget();
              }

              if (state is FitnessError) {
                return ErrorStateWidget(
                  errorMessage: state.errorMessage,
                  onRetry: () => cubit.loadData(),
                );
              }

              if (state is FitnessEmpty) {
                return EmptyStateWidget(
                  message: state.message,
                  onResetTap: () {
                    cubit.selectFilter('all');
                    cubit.updateSearchQuery('');
                  },
                );
              }

              if (state is FitnessSuccess) {
                final data = state.data;
                final challenge = data.todaysChallenge;
                final filteredPrograms = state.filteredPrograms;

                return SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(24, 29, 0, 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HomeHeader(
                        hasUnreadNotifications: data.header.hasUnreadNotification,
                        onNotificationTap: () => _showNotificationsSheet(context),
                      ),
                      const SizedBox(height: 29),
                      TodayChallengeCard(
                        completed: challenge.completed,
                        total: challenge.total,
                        onTap: () {
                          cubit.incrementChallenge();
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Logged 1 km! Progress: ${challenge.completed}/${challenge.total} km',
                              ),
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 27),
                      SectionHeader(
                        title: 'Featured Plan',
                        onSeeAllTap: () => _navigateToDetails(context),
                      ),
                      const SizedBox(height: 15),
                      FeaturedPlansSection(
                        plans: data.featuredPlans,
                        onPlanTap: (_) => _navigateToDetails(context),
                      ),
                      const SizedBox(height: 27),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Workout Programs',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: kInk,
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(
                                  state.showOnlyFavorites
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: state.showOnlyFavorites
                                      ? const Color(0xFFED475B)
                                      : kGrey,
                                  size: 22,
                                ),
                                tooltip: 'Filter Favorites',
                                onPressed: () => cubit.toggleShowOnlyFavorites(),
                              ),
                              GestureDetector(
                                onTap: () => _navigateToAllPrograms(context),
                                child: const Padding(
                                  padding: EdgeInsets.only(right: 24),
                                  child: Text(
                                    'See All',
                                    style: TextStyle(
                                      color: Color(0xFF00A64A),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      CategoryChipsSection(
                        filters: data.filters,
                        selectedFilterId: state.selectedFilterId,
                        filterIconUrls: data.filterIconUrls,
                        onFilterSelected: (filterId) => cubit.selectFilter(filterId),
                      ),
                      const SizedBox(height: 16),
                      WorkoutProgramsSection(
                        programs: filteredPrograms,
                        onProgramTap: (_) => _navigateToDetails(context),
                        onFavoriteToggle: (id) => cubit.toggleFavorite(id),
                      ),
                    ],
                  ),
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
