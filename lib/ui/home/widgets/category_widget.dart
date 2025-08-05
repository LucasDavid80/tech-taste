import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:techtaste/ui/_core/app_colors.dart';

class CategoryWidget extends StatelessWidget {
  final String category;
  const CategoryWidget({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push('/category', extra: category);
      },
      child: Container(
        alignment: Alignment.center,
        width: 108,
        height: 108,
        decoration: BoxDecoration(
          color: AppColors.lightBackgroundColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 8.0,
          children: [
            Expanded(
              child: Image.asset(
                'assets/categories/${category.toLowerCase()}.png',
                height: 48,
              ),
            ),
            Expanded(
              child: Text(
                category,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
