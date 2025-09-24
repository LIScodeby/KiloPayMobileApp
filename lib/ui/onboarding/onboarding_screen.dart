// lib/ui/onboarding/onboarding_screen.dart
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/widgets/primary_button.dart';
import '../../routes/app_routes.dart';
import 'slide_item.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<SlideItem> slides = [
      const SlideItem(title: 'Внеси депозит', icon: Icons.payments_outlined),
      const SlideItem(title: 'Снижай вес',   icon: Icons.fitness_center_outlined),
      const SlideItem(title: 'Получай деньги',icon: Icons.attach_money_outlined),
    ];

    return Scaffold(
      backgroundColor: AppColors.bgLight,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 24),
              //const Icon(Icons.fitness_center, size: 64, color: AppColors.primary),
              Image.asset(
                'assets/images/logo.png',
                width: 180,
                height: 180,
              ),
              //const SizedBox(height: 8),
              const Text('KiloPay', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800)),
              const SizedBox(height: 24),
              Expanded(
                child: PageView.builder(
                  itemCount: slides.length,
                  itemBuilder: (_, i) {
                    final s = slides[i];
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(s.icon, size: 120, color: AppColors.primary),
                        const SizedBox(height: 18),
                        Text(s.title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
                        const SizedBox(height: 8),
                        const Text(
                          'Внеси депозит → Снижай вес → Получай деньги',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    );
                  },
                ),
              ),
              PrimaryButton(
                label: AppStrings.register,
                onPressed: () => Navigator.pushNamed(context, AppRoutes.register),
              ),
              const SizedBox(height: 12),
              PrimaryButton(
                label: AppStrings.login,
                outlined: true,
                onPressed: () => Navigator.pushNamed(context, AppRoutes.login),
              ),
              const SizedBox(height: 12),
              Text(
                AppStrings.privacyAndTerms,
                style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
