// lib/ui/common/app_bar.dart
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class KiloAppBar extends AppBar {
  KiloAppBar({super.key, String? titleText})
      : super(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text(titleText ?? 'KiloPay', style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w700)),
          iconTheme: const IconThemeData(color: AppColors.textPrimary),
        );
}
