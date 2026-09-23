class WorkoutProgram {
  final String title;
  final String imagePath;
  final String calories;
  final String duration;
  final bool isPro;
  final String category;

  const WorkoutProgram({
    required this.title,
    required this.imagePath,
    required this.calories,
    required this.duration,
    this.isPro = false,
    required this.category,
  });

  static const List<WorkoutProgram> samplePrograms = [
    WorkoutProgram(
      title: 'Yoga Flow',
      imagePath: 'assets/images/yoga.jpg',
      calories: '180 kcl',
      duration: '60 min',
      isPro: false,
      category: 'Yoga',
    ),
    WorkoutProgram(
      title: 'Arm\nStrengthening',
      imagePath: 'assets/images/strengthening.jpg',
      calories: '210 kcl',
      duration: '120 min',
      isPro: true,
      category: 'Pilates',
    ),
    WorkoutProgram(
      title: 'Cardio Burn',
      imagePath: 'assets/images/upper_body.jpg',
      calories: '350 kcl',
      duration: '45 min',
      isPro: false,
      category: 'Cardio',
    ),
    WorkoutProgram(
      title: 'Boxing Basics',
      imagePath: 'assets/images/gym.jpg',
      calories: '400 kcl',
      duration: '50 min',
      isPro: true,
      category: 'Boxing',
    ),
    WorkoutProgram(
      title: 'Pilates Core',
      imagePath: 'assets/images/strengthening.jpg',
      calories: '220 kcl',
      duration: '40 min',
      isPro: false,
      category: 'Pilates',
    ),
    WorkoutProgram(
      title: 'Power Yoga',
      imagePath: 'assets/images/yoga.jpg',
      calories: '260 kcl',
      duration: '75 min',
      isPro: true,
      category: 'Yoga',
    ),
  ];
}
