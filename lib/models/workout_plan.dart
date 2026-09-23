class WorkoutPlan {
  final String title;
  final String imagePath;
  final String duration;
  final String frequency;

  const WorkoutPlan({
    required this.title,
    required this.imagePath,
    required this.duration,
    required this.frequency,
  });

  static const List<WorkoutPlan> samplePlans = [
    WorkoutPlan(
      title: 'Massive Upper Body',
      imagePath: 'assets/images/upper_body.jpg',
      duration: '5 week',
      frequency: '4×/week',
    ),
    WorkoutPlan(
      title: 'Muscle Building',
      imagePath: 'assets/images/upper_body.jpg',
      duration: '6 week',
      frequency: '3×/week',
    ),
  ];
}
