import 'package:flutter/material.dart';
import 'package:netflix_landing_ui/core/theme/app_colors.dart';
import 'package:netflix_landing_ui/models/category.dart';

class CategoryChip extends StatelessWidget {
  const CategoryChip({
    super.key,
    required this.category,
    required this.isSelected,
    required this.onTap,
  });

  final Category category;
  final bool isSelected;
  final VoidCallback onTap;

  IconData _iconForCategory(String iconName) {
    switch (iconName) {
      case 'explosion':
        return Icons.local_fire_department;
      case 'theater':
        return Icons.theater_comedy;
      case 'mood':
        return Icons.sentiment_very_satisfied;
      case 'rocket':
        return Icons.rocket_launch;
      case 'nightlight':
        return Icons.nights_stay;
      case 'menu_book':
        return Icons.menu_book;
      case 'favorite':
        return Icons.favorite;
      case 'psychology':
        return Icons.psychology;
      default:
        return Icons.category;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      selected: isSelected,
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _iconForCategory(category.iconName),
            size: 16,
            color: isSelected ? AppColors.textPrimary : AppColors.textSecondary,
          ),
          const SizedBox(width: 6),
          Text(category.name),
        ],
      ),
      onSelected: (_) => onTap(),
      selectedColor: AppColors.netflixRed,
      backgroundColor: AppColors.surfaceLight,
      checkmarkColor: AppColors.textPrimary,
      labelStyle: TextStyle(
        color: isSelected ? AppColors.textPrimary : AppColors.textSecondary,
        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
      ),
    );
  }
}
