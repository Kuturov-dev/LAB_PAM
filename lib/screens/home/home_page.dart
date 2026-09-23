import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/constants/app_colors.dart';
import '../../models/workout_plan.dart';
import '../../models/workout_program.dart';
import '../details/gym_details_page.dart';
import '../programs/all_programs_page.dart';
import 'widgets/category_chips_section.dart';
import 'widgets/featured_plans_section.dart';
import 'widgets/home_header.dart';
import 'widgets/section_header.dart';
import 'widgets/today_challenge_card.dart';
import 'widgets/workout_programs_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _completedKm = 15;
  final int _totalGoalKm = 20;
  bool _hasUnreadNotifications = true;

  final List<String> _categories = const [
    'All Type',
    'Pilates',
    'Cardio',
    'Boxing',
    'Yoga',
  ];
  String _selectedCategory = 'All Type';

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

  void _incrementChallengeProgress() {
    if (_completedKm < _totalGoalKm) {
      setState(() {
        _completedKm++;
      });
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Logged 1 km! Progress: $_completedKm/$_totalGoalKm km'),
          duration: const Duration(seconds: 2),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("🎉 Today's Challenge is already completed! Great job!"),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _showNotificationsSheet() {
    setState(() {
      _hasUnreadNotifications = false;
    });

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
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
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Color(0xFFE7FFF1),
                  child: Icon(Icons.directions_run, color: kGreen, size: 20),
                ),
                title: const Text('Daily Challenge Progress'),
                subtitle: Text('$_completedKm/$_totalGoalKm km completed today. Keep going!'),
                trailing: const Text('1h ago', style: TextStyle(fontSize: 12, color: kGrey)),
              ),
            ],
          ),
        );
      },
    );
  }

  List<WorkoutProgram> get _filteredPrograms {
    if (_selectedCategory == 'All Type') {
      return WorkoutProgram.samplePrograms;
    }
    final filtered = WorkoutProgram.samplePrograms
        .where((p) => p.category.toLowerCase() == _selectedCategory.toLowerCase())
        .toList();
    return filtered.isNotEmpty ? filtered : WorkoutProgram.samplePrograms;
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.white,
      ),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 29, 0, 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HomeHeader(
                  hasUnreadNotifications: _hasUnreadNotifications,
                  onNotificationTap: _showNotificationsSheet,
                ),
                const SizedBox(height: 29),
                TodayChallengeCard(
                  completed: _completedKm,
                  total: _totalGoalKm,
                  onTap: _incrementChallengeProgress,
                ),
                const SizedBox(height: 27),
                SectionHeader(
                  title: 'Featured Plan',
                  onSeeAllTap: () => _navigateToDetails(context),
                ),
                const SizedBox(height: 15),
                FeaturedPlansSection(
                  plans: WorkoutPlan.samplePlans,
                  onPlanTap: (_) => _navigateToDetails(context),
                ),
                const SizedBox(height: 27),
                SectionHeader(
                  title: 'Workout Programs',
                  onSeeAllTap: () => _navigateToAllPrograms(context),
                ),
                const SizedBox(height: 16),
                CategoryChipsSection(
                  categories: _categories,
                  selectedCategory: _selectedCategory,
                  onCategorySelected: (category) {
                    setState(() {
                      _selectedCategory = category;
                    });
                  },
                ),
                const SizedBox(height: 16),
                WorkoutProgramsSection(
                  programs: _filteredPrograms,
                  onProgramTap: (_) => _navigateToDetails(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
