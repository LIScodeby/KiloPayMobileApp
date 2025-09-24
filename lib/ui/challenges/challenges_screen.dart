// lib/ui/challenges/challenges_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/challenge_provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/utils/date_utils.dart';

class ChallengesScreen extends StatefulWidget {
  const ChallengesScreen({super.key});

  @override
  State<ChallengesScreen> createState() => _ChallengesScreenState();
}

class _ChallengesScreenState extends State<ChallengesScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<ChallengeProvider>().load()); // TODO: заменить на API-вызов
  }

  @override
  Widget build(BuildContext context) {
    final ch = context.watch<ChallengeProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Челенджи')),
      body: ch.loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(24),
              itemCount: ch.list.length + 1,
              itemBuilder: (context, i) {
                // Последний элемент — ссылка на историю
                if (i == ch.list.length) {
                  return Center(
                    child: TextButton(
                      onPressed: () {
                        // TODO: навигация на историю завершённых челенджей
                      },
                      child: const Text('История завершенных челенджей'),
                    ),
                  );
                }

                final c = ch.list[i];
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: AppColors.border),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        c.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.calendar_today_outlined, size: 16, color: AppColors.textSecondary),
                          const SizedBox(width: 6),
                          Text(
                            '${AppDateUtils.formatShort(c.start)} – ${AppDateUtils.formatShort(c.end)}',
                            style: const TextStyle(color: AppColors.textSecondary),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.monetization_on_outlined, size: 16, color: AppColors.primary),
                          const SizedBox(width: 6),
                          Text(
                            '${c.prize} ₽',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        height: 44,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: c.joined ? AppColors.border : AppColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          onPressed: c.joined
                              ? null
                              : () {
                                  context.read<ChallengeProvider>().join(c.id);
                                },
                          child: Text(
                            c.joined ? 'Уже в челендже' : 'Присоединиться',
                            style: TextStyle(
                              color: c.joined ? AppColors.textSecondary : Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
