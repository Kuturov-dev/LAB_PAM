import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../models/fitness_models.dart';
import '../../../shared/widgets/svg_icon.dart';

class WorkoutProgramsSection extends StatelessWidget {
  final List<WorkoutProgramItem> programs;
  final ValueChanged<WorkoutProgramItem> onProgramTap;
  final ValueChanged<String> onFavoriteToggle;

  const WorkoutProgramsSection({
    super.key,
    required this.programs,
    required this.onProgramTap,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 184,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(right: 24),
        itemCount: programs.length,
        separatorBuilder: (_, _) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          final program = programs[index];
          return _ProgramCard(
            program: program,
            onTap: () => onProgramTap(program),
            onFavoriteToggle: () => onFavoriteToggle(program.id),
          );
        },
      ),
    );
  }
}

class _ProgramCard extends StatelessWidget {
  final WorkoutProgramItem program;
  final VoidCallback onTap;
  final VoidCallback onFavoriteToggle;

  const _ProgramCard({
    required this.program,
    required this.onTap,
    required this.onFavoriteToggle,
  });

  Widget _buildImage(String url) {
    if (url.startsWith('assets/')) {
      return Image.asset(url, fit: BoxFit.cover);
    }
    return Image.network(
      url,
      fit: BoxFit.cover,
      errorBuilder: (_, _, _) => Image.asset(
        'assets/images/yoga.jpg',
        fit: BoxFit.cover,
      ),
    );
  }

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
            _buildImage(program.imageUrl),
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
            Positioned(
              top: 8,
              left: 8,
              child: GestureDetector(
                onTap: onFavoriteToggle,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    color: Colors.black38,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    program.isFavorite ? Icons.favorite : Icons.favorite_border,
                    size: 16,
                    color: program.isFavorite ? const Color(0xFFED475B) : Colors.white,
                  ),
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
                  child: Row(
                    children: [
                      if (program.proIconUrl != null)
                        AppSvgIcon(
                          url: program.proIconUrl!,
                          size: 12,
                          color: kGreen,
                          fallbackIcon: Icons.workspace_premium_outlined,
                        )
                      else
                        const Icon(Icons.workspace_premium_outlined, size: 12, color: kGreen),
                      const SizedBox(width: 3),
                      const Text('Pro', style: TextStyle(color: kGreen, fontSize: 12)),
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
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Row(
                    children: [
                      AppSvgIcon(
                        url: program.caloriesIconUrl,
                        size: 11,
                        color: Colors.white,
                        fallbackIcon: Icons.local_fire_department_outlined,
                      ),
                      const SizedBox(width: 2),
                      Text('${program.calories} kcal',
                          style: const TextStyle(color: Colors.white, fontSize: 10)),
                      const Spacer(),
                      AppSvgIcon(
                        url: program.durationIconUrl,
                        size: 11,
                        color: Colors.white,
                        fallbackIcon: Icons.schedule,
                      ),
                      const SizedBox(width: 2),
                      Text('${program.durationMinutes}m',
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
