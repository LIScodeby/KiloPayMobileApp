/* // lib/ui/profile/profile_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../providers/profile_provider.dart';
import '../../providers/auth_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<ProfileProvider>().load()); // TODO API
  }

  @override
  Widget build(BuildContext context) {
    final p = context.watch<ProfileProvider>();
    final user = p.profile;

    return Scaffold(
      appBar: AppBar(title: const Text('Профиль')),
      body: p.loading
          ? const Center(child: CircularProgressIndicator())
          : user == null
              ? const Center(child: Text('Нет данных'))
              : Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Column(children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: AppColors.bgLight,
                            child: Text(user.name.isNotEmpty ? user.name.characters.first : 'U'),
                          ),
                          const SizedBox(height: 8),
                          Text('ID: ${user.id}'),
                          const SizedBox(height: 8),
                          OutlinedButton(onPressed: () {}, child: const Text('Редактировать')),
                        ]),
                      ),
                      const SizedBox(height: 16),
                      _Row(label: 'Тариф', value: user.tariffStatus),
                      _Row(label: 'Депозит', value: '${user.deposit.toStringAsFixed(0)} ₽'),
                      const Divider(height: 24),
                      _Row(label: 'Имя', value: user.name),
                      _Row(label: 'Страна', value: user.country ?? '—'),
                      _Row(label: 'Telegram', value: user.telegram ?? '—'),
                      const Spacer(),
                      Row(children: [
                        Expanded(child: OutlinedButton(onPressed: () {}, child: const Text('Сменить пароль'))),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              context.read<AuthProvider>().logout();
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
                            child: const Text('Выйти'),
                          ),
                        ),
                      ])
                    ],
                  ),
                ),
    );
  }
}

class _Row extends StatelessWidget {
  final String label;
  final String value;
  const _Row({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(label, style: const TextStyle(color: AppColors.textSecondary)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
      ]),
    );
  }
}
 */

// lib/ui/profile/profile_screen.dart
import 'package:flutter/material.dart';
import 'package:kilopay/routes/app_routes.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../providers/profile_provider.dart';
import '../../providers/auth_provider.dart';
import '../../core/widgets/primary_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<ProfileProvider>().load()); // TODO API
  }

  @override
  Widget build(BuildContext context) {
    final p = context.watch<ProfileProvider>();
    final user = p.profile;

    return Scaffold(
      appBar: AppBar(title: const Text('Профиль')),
      body: p.loading
          ? const Center(child: CircularProgressIndicator())
          : user == null
              ? const Center(child: Text('Нет данных'))
              : Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundColor: AppColors.bgLight,
                              child: Text(
                                user.name.isNotEmpty
                                    ? user.name.characters.first
                                    : 'U',
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text('ID: ${user.id}'),
                            const SizedBox(height: 8),
                            OutlinedButton(
                              onPressed: () {},
                              child: const Text('Редактировать'),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      _Row(label: 'Тариф', value: user.tariffStatus),
                      _Row(
                        label: 'Депозит',
                        value: '${user.deposit.toStringAsFixed(0)} ₽',
                      ),
                      const Divider(height: 24),
                      _Row(label: 'Имя', value: user.name),
                      _Row(label: 'Страна', value: user.country ?? '—'),
                      _Row(label: 'Telegram', value: user.telegram ?? '—'),

                      // 🔹 Новая линия и кнопка
                      const Divider(height: 24),
                      PrimaryButton(
                        label: 'Реферальный код',
                        onPressed: () => Navigator.pushNamed(context, AppRoutes.referrals),
                      ),

                      const Spacer(),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {},
                              child: const Text('Сменить пароль'),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                context.read<AuthProvider>().logout();
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.error,
                              ),
                              child: const Text('Выйти'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
    );
  }
}

class _Row extends StatelessWidget {
  final String label;
  final String value;
  const _Row({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: AppColors.textSecondary)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
