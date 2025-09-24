// lib/ui/dashboard/dashboard_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/constants/app_strings.dart';
import '../../core/utils/date_utils.dart';
import '../../providers/balance_provider.dart';
import '../../providers/weight_provider.dart';
import '../common/bottom_nav_bar.dart';
import '../../routes/app_routes.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      await context.read<BalanceProvider>().load();
      await context.read<WeightProvider>().load();
    });
  }

  @override
  Widget build(BuildContext context) {
    final balance = context.watch<BalanceProvider>();
    final weight = context.watch<WeightProvider>();
    final last = weight.history.isNotEmpty ? weight.history.last : null;

    final size = MediaQuery.of(context).size;
    final isWide = size.width > 400;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 1, top: 8, right: 20, bottom: 8),
            child: Row(
              children: [
                // 📌 Место для логотипа
                // Заменить на Image.asset('assets/logo.png', height: 40)
               
                Container(
                  height: 80,
                  width: 80,
                  decoration: const BoxDecoration(
                    shape: BoxShape.rectangle,
                    //color: AppColors.primary,
                  ),
                  child: Image.asset(
                'assets/images/logo.png',
                width: 80,
                height: 80,),
                ),
                //),
                //const SizedBox(width: 3),
                Text(AppStrings.appName, style: AppTextStyles.h1),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.notifications_none, color: AppColors.textPrimary),
                  onPressed: () => Navigator.pushNamed(context, AppRoutes.notifications),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: KiloBottomNavBar(
        currentIndex: 0,
        onTap: (i) {
          if (i == 1) Navigator.pushNamed(context, AppRoutes.progress);
          if (i == 2) Navigator.pushNamed(context, AppRoutes.profile);
        },
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Привет, Алексей 👋', style: AppTextStyles.h1),
            const SizedBox(height: 20),

            // Карточки веса и баланса
            if (isWide)
              Row(
                children: [
                  Expanded(
                    child: _InfoCard(
                      title: 'Текущий вес',
                      value: last != null ? '${last.weight.toStringAsFixed(1)} кг' : '—',
                      subtitle: last != null
                          ? AppDateUtils.formatMonthDay(last.date)
                          : 'нет данных',
                      icon: Icons.monitor_weight_outlined,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _InfoCard(
                      title: 'Баланс',
                      value: '${balance.balance.toStringAsFixed(0)} ₽',
                      subtitle: '+12% за месяц',
                      icon: Icons.account_balance_wallet_outlined,
                    ),
                  ),
                ],
              )
            else
              Column(
                children: [
                  _InfoCard(
                    title: 'Текущий вес',
                    value: last != null ? '${last.weight.toStringAsFixed(1)} кг' : '—',
                    subtitle: last != null
                        ? AppDateUtils.formatMonthDay(last.date)
                        : 'нет данных',
                    icon: Icons.monitor_weight_outlined,
                  ),
                  const SizedBox(height: 12),
                  _InfoCard(
                    title: 'Баланс',
                    value: '${balance.balance.toStringAsFixed(0)} ₽',
                    subtitle: '+12% за месяц',
                    icon: Icons.account_balance_wallet_outlined,
                  ),
                ],
              ),

            const SizedBox(height: 20),

            // Кнопка фиксации веса
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () => Navigator.pushNamed(context, AppRoutes.weight),
                icon: const Icon(Icons.add, color: Colors.white),
                label: const Text('Зафиксировать вес', style: TextStyle(color: Colors.white)),
              ),
            ),

            const SizedBox(height: 12),

            // Кнопки пополнения и вывода
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      side: const BorderSide(color: AppColors.primary),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () => Navigator.pushNamed(context, AppRoutes.balance),
                    child: const Text('Пополнить депозит'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      side: const BorderSide(color: AppColors.primary),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () => Navigator.pushNamed(context, AppRoutes.withdrawals),
                    child: const Text('Вывести средства'),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            //Text('Ближайшие челенджи', style: AppTextStyles.h2),
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, AppRoutes.challenges),
              child: Text('Ближайшие челенджи', style: AppTextStyles.h2),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, AppRoutes.challenges), // пустое действие
              child:
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.bgLight,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'Похудей за месяц!',
                style: AppTextStyles.body,
              ),
            ),),

            const SizedBox(height: 24),

            Text('Мотивация', style: AppTextStyles.h2),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.bgLight,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'Не сдавайся, продолжай в том же духе!',
                style: AppTextStyles.body,
              ),
            ),

          ],
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final IconData icon;

  const _InfoCard({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min, // не растягиваем
        children: [
          Icon(icon, color: AppColors.primary, size: 28),
          const SizedBox(height: 8),
          Text(title, style: AppTextStyles.caption),
          const SizedBox(height: 4),
          Text(value, style: AppTextStyles.h2),
          const SizedBox(height: 4),
          Text(subtitle, style: AppTextStyles.caption),
        ],
      ),
    );
  }
}
