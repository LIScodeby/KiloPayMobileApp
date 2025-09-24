// lib/routes/app_routes.dart
import 'package:flutter/material.dart';

// Импортируем все экраны
import '../ui/onboarding/onboarding_screen.dart';
import '../ui/auth/login_screen.dart';
import '../ui/auth/register_screen.dart';
import '../ui/auth/sms_code_screen.dart';
import '../ui/auth/reset_password_screen.dart';
import '../ui/dashboard/dashboard_screen.dart';
import '../ui/profile/profile_screen.dart';
import '../ui/balance/balance_screen.dart';
import '../ui/weight/weight_screen.dart';
import '../ui/progress/progress_screen.dart';
import '../ui/notifications/notifications_screen.dart';
import '../ui/referrals/referrals_screen.dart';
import '../ui/challenges/challenges_screen.dart';
import '../ui/withdrawals/withdrawals_screen.dart';


class AppRoutes {
  // Константы с именами маршрутов
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String smsCode = '/sms-code';
  static const String resetPassword = '/reset-password';
  static const String dashboard = '/dashboard';
  static const String profile = '/profile';
  static const String balance = '/balance';
  static const String weight = '/weight';
  static const String progress = '/progress';
  static const String notifications = '/notifications';
  static const String referrals = '/referrals';
  static const String challenges = '/challenges';
  static const String withdrawals = '/withdrawals';

  // Карта маршрутов
  static Map<String, WidgetBuilder> routes = {
    onboarding: (_) => const OnboardingScreen(),
    login: (_) => const LoginScreen(),
    register: (_) => const RegisterScreen(),
    smsCode: (_) => const SmsCodeScreen(),
    resetPassword: (_) => const ResetPasswordScreen(),
    dashboard: (_) => const DashboardScreen(),
    profile: (_) => const ProfileScreen(),
    balance: (_) => const BalanceScreen(),
    weight: (_) => const WeightScreen(),
    progress: (_) => const ProgressScreen(),
    notifications: (_) => const NotificationsScreen(),
    referrals: (_) => const ReferralsScreen(),
    challenges: (_) => const ChallengesScreen(),
    withdrawals: (_) => const WithdrawalsScreen(),
  };
}
