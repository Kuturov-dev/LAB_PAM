import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../models/fitness_models.dart';
import '../../../shared/widgets/svg_icon.dart';

class CategoryChipsSection extends StatelessWidget {
  final List<FilterItem> filters;
  final String selectedFilterId;
  final Map<String, String> filterIconUrls;
  final ValueChanged<String> onFilterSelected;

  const CategoryChipsSection({
    super.key,
    required this.filters,
    required this.selectedFilterId,
    required this.filterIconUrls,
    required this.onFilterSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 34,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        itemBuilder: (context, index) {
          final filter = filters[index];
          final isSelected = filter.id == selectedFilterId;
          final iconUrl = filterIconUrls[filter.id] ?? '';

          return GestureDetector(
            onTap: () => onFilterSelected(filter.id),
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 14),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected ? kGreen : Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: isSelected ? null : Border.all(color: kLine),
              ),
              child: Row(
                children: [
                  if (iconUrl.isNotEmpty) ...[
                    AppSvgIcon(
                      url: iconUrl,
                      size: 16,
                      color: isSelected ? Colors.white : kGrey,
                    ),
                    const SizedBox(width: 6),
                  ],
                  Text(
                    filter.name,
                    style: TextStyle(
                      color: isSelected ? Colors.white : kGrey,
                      fontSize: 14,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
