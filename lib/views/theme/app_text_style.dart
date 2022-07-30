import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyle {
  AppTextStyle._();

  static TextStyle styleSubTitle = const TextStyle(
      color: Colors.grey, fontWeight: FontWeight.w500, fontSize: 12);

  static TextStyle styleAppBar = const TextStyle(
      color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600);

  static TextStyle styleBodySmall =
      const TextStyle(color: AppColors.white, fontSize: 16);

  static TextStyle styleBodyBig =
      const TextStyle(color: AppColors.white, fontSize: 18);
}
