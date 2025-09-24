// lib/ui/referrals/referrals_screen.dart
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class ReferralsScreen extends StatelessWidget {
  const ReferralsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final code = 'KP–7F9X2'; // TODO: получить из API
    final invited = [
      {'name': 'Андрей', 'amount': 500, 'date': DateTime(2025, 8, 15)},
    ]; // TODO API

    return Scaffold(
      appBar: AppBar(title: const Text('Бонусы и подарки')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Реферальный код', style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(16),
            decoration:
                BoxDecoration(color: AppColors.bgLight, borderRadius: BorderRadius.circular(12)),
            child: Row(children: [
              Text(code, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
              const Spacer(),
              OutlinedButton(onPressed: () {/* TODO share */}, child: const Text('Поделиться')),
            ]),
          ),
          const SizedBox(height: 16),
          const Text('Приглашенные', style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          ...invited.map((e) => ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(e['name'] as String),
                trailing: Text('+${e['amount']} ₽'),
                subtitle: const Text('15.08.2025'),
              )),
          const SizedBox(height: 16),
          OutlinedButton(onPressed: () {/* TODO open contests */}, child: const Text('Текущие конкурсы — Подробнее')),
        ]),
      ),
    );
  }
}
