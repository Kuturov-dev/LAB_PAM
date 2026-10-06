import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../models/fitness_models.dart';
import '../../../shared/widgets/svg_icon.dart';

class FeaturedPlansSection extends StatelessWidget {
  final List<FeaturedPlanItem> plans;
  final ValueChanged<FeaturedPlanItem> onPlanTap;

  const FeaturedPlansSection({
    super.key,
    required this.plans,
    required this.onPlanTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 144,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(right: 24),
        itemCount: plans.length,
        separatorBuilder: (_, _) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          final plan = plans[index];
          return _FeaturedCard(
            plan: plan,
            onTap: () => onPlanTap(plan),
          );
        },
      ),
    );
  }
}

class _FeaturedCard extends StatelessWidget {
  final FeaturedPlanItem plan;
  final VoidCallback onTap;

  const _FeaturedCard({
    required this.plan,
    required this.onTap,
  });

  Widget _buildImage(String url) {
    if (url.startsWith('assets/')) {
      return Image.asset(url, fit: BoxFit.cover, alignment: Alignment.center);
    }
    return Image.network(
      url,
      fit: BoxFit.cover,
      alignment: Alignment.center,
      errorBuilder: (_, _, _) => Image.asset(
        'assets/images/upper_body.jpg',
        fit: BoxFit.cover,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 296,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        child: Stack(
          fit: StackFit.expand,
          children: [
            _buildImage(plan.imageUrl),
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xF31A2330), Color(0x001A2330)],
                  stops: [0.10, 1],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    plan.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      AppSvgIcon(
                        url: plan.durationIconUrl,
                        size: 14,
                        color: Colors.white,
                        fallbackIcon: Icons.calendar_today,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        plan.duration,
                        style: const TextStyle(fontSize: 11, color: Colors.white),
                      ),
                      const SizedBox(width: 10),
                      AppSvgIcon(
                        url: plan.frequencyIconUrl,
                        size: 14,
                        color: Colors.white,
                        fallbackIcon: Icons.fitness_center,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        plan.frequency,
                        style: const TextStyle(fontSize: 11, color: Colors.white),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    height: 32,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: kGreen,
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Text(
                      plan.actionLabel,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
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
