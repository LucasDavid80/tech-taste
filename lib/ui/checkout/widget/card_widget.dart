import 'package:flutter/material.dart';
import 'package:techtaste/ui/_core/app_colors.dart';

Card getCardWidget(
  String title,
  String? subtitle,
  String? imagePath,
  Function()? onTap,
) {
  return Card(
    child: ListTile(
      contentPadding: const EdgeInsets.all(16.0),
      title: Text(title),
      subtitle: Text(subtitle!),
      leading:
          (imagePath! != '')
              ? Image.asset(imagePath, width: 48)
              : Icon(Icons.location_on),
      trailing: Container(
        decoration: BoxDecoration(
          color: AppColors.buttonColor,
          borderRadius: BorderRadius.circular(1200.0),
        ),
        child: IconButton(
          onPressed: () {
            onTap?.call();
          },
          icon: Icon(Icons.arrow_forward_ios, color: Colors.black),
        ),
      ),
    ),
  );
}
