import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class TodayChallengeCard extends StatelessWidget {
  final int completed;
  final int total;
  final VoidCallback? onTap;

  const TodayChallengeCard({
    super.key,
    this.completed = 15,
    this.total = 20,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final progress = (total > 0) ? (completed / total).clamp(0.0, 1.0) : 0.0;
    final isDone = completed >= total;

    return Padding(
      padding: const EdgeInsets.only(right: 24),
      child: Material(
        color: const Color(0xFF131316),
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            height: 84,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            "Today's Challenge",
                            style: TextStyle(color: Color(0xFFABB1C0), fontSize: 14),
                          ),
                          if (isDone) ...[
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: kGreen,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Text(
                                'Completed!',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 5),
                      Text(
                        isDone ? 'Running Completed 🎉' : 'Running (Tap to log km)',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                  width: 50,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox.expand(
                        child: CircularProgressIndicator(
                          value: progress,
                          strokeWidth: 4,
                          backgroundColor: const Color(0xFF34343C),
                          valueColor: const AlwaysStoppedAnimation<Color>(kGreen),
                        ),
                      ),
                      Text(
                        '$completed/$total',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
