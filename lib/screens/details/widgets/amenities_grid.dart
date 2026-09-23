import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../models/gym_details.dart';

class AmenitiesGrid extends StatelessWidget {
  final List<AmenityItem> amenities;

  const AmenitiesGrid({
    super.key,
    required this.amenities,
  });

  @override
  Widget build(BuildContext context) {
    final rows = <Widget>[];
    for (var i = 0; i < amenities.length; i += 2) {
      final first = amenities[i];
      final second = (i + 1 < amenities.length) ? amenities[i + 1] : null;

      rows.add(
        Row(
          children: [
            Expanded(child: _AmenityTile(item: first)),
            const SizedBox(width: 16),
            Expanded(
              child: second != null
                  ? _AmenityTile(item: second)
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      );

      if (i + 2 < amenities.length) {
        rows.add(const SizedBox(height: 16));
      }
    }

    return Column(children: rows);
  }
}

class _AmenityTile extends StatelessWidget {
  final AmenityItem item;

  const _AmenityTile({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFD),
        border: Border.all(color: kLine),
        borderRadius: BorderRadius.circular(9),
      ),
      child: Row(
        children: [
          Icon(item.icon, color: kGrey, size: 19),
          const SizedBox(width: 10),
          Flexible(
            child: Text(
              item.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 13, color: kGrey),
            ),
          ),
        ],
      ),
    );
  }
}
