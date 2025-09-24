/* // lib/ui/weight/weight_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/utils/date_utils.dart';
import '../../core/widgets/primary_button.dart';
import '../../providers/weight_provider.dart';

class WeightScreen extends StatefulWidget {
  const WeightScreen({super.key});

  @override
  State<WeightScreen> createState() => _WeightScreenState();
}

class _WeightScreenState extends State<WeightScreen> {
  final _weightC = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<WeightProvider>().load()); // TODO API
  }

  @override
  Widget build(BuildContext context) {
    final wp = context.watch<WeightProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Фиксация веса')),
      body: wp.loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: AppColors.bgLight, borderRadius: BorderRadius.circular(16)),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Row(
                      children: [
                        const Icon(Icons.calendar_today_outlined, size: 18),
                        const SizedBox(width: 8),
                        const Text('Календарь фиксаций'),
                        const Spacer(),
                        Text('Код: ${wp.sessionCode}', style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8, runSpacing: 8,
                      children: List.generate(18, (i) {
                        final day = i + 1;
                        final marked = wp.history.any((h) => h.date.day == day);
                        return CircleAvatar(
                          radius: 16,
                          backgroundColor: marked ? AppColors.primary : AppColors.border,
                          child: Text('$day', style: TextStyle(color: marked ? Colors.white : AppColors.textPrimary)),
                        );
                      }),
                    ),
                  ]),
                ),
                const SizedBox(height: 16),
                PrimaryButton(label: 'Добавить фиксацию', onPressed: () {}),
                const SizedBox(height: 12),
                TextField(
                  controller: _weightC,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(labelText: 'Вес, кг', border: OutlineInputBorder()),
                ),
                const SizedBox(height: 12),
                PrimaryButton(
                  label: 'Отправить на модерацию',
                  onPressed: () async {
                    final value = double.tryParse(_weightC.text.replaceAll(',', '.'));
                    if (value == null) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Введите корректный вес')));
                      return;
                    }
                    final ok = await wp.submit(value); // TODO API
                    if (ok && mounted) {
                      _weightC.clear();
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Отправлено на модерацию')));
                    }
                  },
                ),
                const SizedBox(height: 16),
                const Text('История веса', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                const SizedBox(height: 8),
                ...wp.history.map((h) => ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(
                        h.status == 'Подтвержден' ? Icons.check_circle : h.status == 'rejected' ? Icons.cancel : Icons.hourglass_top,
                        color: h.status == 'Подтвержден'
                            ? AppColors.success
                            : h.status == 'rejected'
                                ? AppColors.error
                                : AppColors.warning,
                      ),
                      title: Text('${AppDateUtils.formatShort(h.date)}: ${h.weight.toStringAsFixed(1)} кг'),
                      subtitle: Text('Статус: ${h.status}'),
                    )),
              ]),
            ),
    );
  }
}
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:collection/collection.dart'; // для firstWhereOrNull
import '../../core/constants/app_colors.dart';
import '../../core/utils/date_utils.dart';
import '../../core/widgets/primary_button.dart';
import '../../providers/weight_provider.dart';

class WeightScreen extends StatefulWidget {
  const WeightScreen({super.key});

  @override
  State<WeightScreen> createState() => _WeightScreenState();
}

class _WeightScreenState extends State<WeightScreen> {
  final _weightC = TextEditingController();
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<WeightProvider>().load()); // TODO API
  }

  @override
  Widget build(BuildContext context) {
    final wp = context.watch<WeightProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Фиксация веса')),
      body: wp.loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.bgLight,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.calendar_today_outlined, size: 18),
                            const SizedBox(width: 8),
                            const Text('Календарь фиксаций'),
                            const Spacer(),
                            /* Text(
                              'Код: ${wp.sessionCode}',
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.textSecondary,
                              ),
                            ), */
                          ],
                        ),
                        const SizedBox(height: 12),
                        TableCalendar(
                          locale: 'ru_RU',
                          firstDay: DateTime.utc(2025, 1, 1),
                          lastDay: DateTime.utc(2030, 12, 31),
                          focusedDay: _focusedDay,
                          selectedDayPredicate: (day) =>
                              isSameDay(_selectedDay, day),
                          onDaySelected: (selectedDay, focusedDay) {
                            setState(() {
                              _selectedDay = selectedDay;
                              _focusedDay = focusedDay;
                              _weightC.clear(); // очищаем поле при выборе нового дня
                            });
                          },
                          calendarBuilders: CalendarBuilders(
                            defaultBuilder: (context, day, focusedDay) {
                              final hasRecord = wp.history.any(
                                  (h) => isSameDay(h.date, day));
                              if (hasRecord) {
                                return _buildDayCell(
                                    day, AppColors.primary, Colors.white);
                              }
                              if (isSameDay(_selectedDay, day)) {
                                return _buildDayCell(
                                    day, AppColors.warning, Colors.white);
                              }
                              return null;
                            },
                            todayBuilder: (context, day, focusedDay) {
                              return _buildDayCell(
                                  day, AppColors.border, AppColors.textPrimary);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  if (_selectedDay != null)
                    _buildDayContent(context, wp, _selectedDay!),

                  const SizedBox(height: 16),
                  const Text(
                    'История веса',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 8),
                  ...wp.history.map((h) => ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Icon(
                          h.status == 'Подтвержден'
                              ? Icons.check_circle
                              : h.status == 'rejected'
                                  ? Icons.cancel
                                  : Icons.hourglass_top,
                          color: h.status == 'Подтвержден'
                              ? AppColors.success
                              : h.status == 'rejected'
                                  ? AppColors.error
                                  : AppColors.warning,
                        ),
                        title: Text(
                            '${AppDateUtils.formatShort(h.date)}: ${h.weight.toStringAsFixed(1)} кг'),
                        subtitle: Text('Статус: ${h.status}'),
                      )),
                ],
              ),
            ),
    );
  }

  Widget _buildDayCell(DateTime day, Color bg, Color textColor) {
    return Container(
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: bg,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        '${day.day}',
        style: TextStyle(color: textColor),
      ),
    );
  }

  Widget _buildDayContent(BuildContext context, WeightProvider wp, DateTime day) {
    final record = wp.history.firstWhereOrNull(
      (h) => isSameDay(h.date, day),
    );

    if (record != null) {
      // День с фиксацией
      return Text(
        'В этот день (${AppDateUtils.formatShort(record.date)}) '
        'вы зафиксировали вес: ${record.weight.toStringAsFixed(1)} кг\n'
        'Статус: ${record.status}',
        style: const TextStyle(fontSize: 16),
      );
    } else {
      // День без фиксации
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _weightC,
            keyboardType:
                const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(
              labelText: 'Вес, кг',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          PrimaryButton(
            label: 'Зафиксировать',
            onPressed: () async {
              final value =
                  double.tryParse(_weightC.text.replaceAll(',', '.'));
              if (value == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Введите корректный вес')),
                );
                return;
              }
              final ok = await wp.submit(value); // TODO API
              if (ok && mounted) {
                _weightC.clear();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Отправлено на модерацию')),
                );
              }
            },
          ),
        ],
      );
    }
  }
}
