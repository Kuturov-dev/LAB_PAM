import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../models/workout_program.dart';

class WorkoutProgramsSection extends StatelessWidget {
  final List<WorkoutProgram> programs;
  final ValueChanged<WorkoutProgram> onProgramTap;

  const WorkoutProgramsSection({
    super.key,
    required this.programs,
    required this.onProgramTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 184,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(right: 24),
        itemCount: programs.length,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          final program = programs[index];
          return _ProgramCard(
            program: program,
            onTap: () => onProgramTap(program),
          );
        },
      ),
    );
  }
}

class _ProgramCard extends StatelessWidget {
  final WorkoutProgram program;
  final VoidCallback onTap;

  const _ProgramCard({
    required this.program,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 156,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(program.imagePath, fit: BoxFit.cover),
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Color(0xD9000000)],
                  stops: [0.38, 1],
                ),
              ),
            ),
            if (program.isPro)
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE7FFF1),
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.workspace_premium_outlined, size: 12, color: kGreen),
                      SizedBox(width: 3),
                      Text('Pro', style: TextStyle(color: kGreen, fontSize: 12)),
                    ],
                  ),
                ),
              ),
            Positioned(
              bottom: 12,
              left: 13,
              right: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    program.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      height: 1.35,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Row(
                    children: [
                      const Icon(Icons.local_fire_department_outlined,
                          size: 11, color: Colors.white),
                      const SizedBox(width: 2),
                      Text(program.calories,
                          style: const TextStyle(color: Colors.white, fontSize: 10)),
                      const Spacer(),
                      const Icon(Icons.schedule, size: 11, color: Colors.white),
                      const SizedBox(width: 2),
                      Text(program.duration,
                          style: const TextStyle(color: Colors.white, fontSize: 10)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
