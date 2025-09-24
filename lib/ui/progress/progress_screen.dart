// lib/ui/progress/progress_screen.dart
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import '../../providers/weight_provider.dart';
import '../../providers/balance_provider.dart';
import '../../core/constants/app_colors.dart';

enum Period { week, month, year }

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  Period _selectedPeriod = Period.week;

  List<T> _filterByPeriod<T>(List<T> list) {
    if (list.isEmpty) return list;
    switch (_selectedPeriod) {
      case Period.week:
        return list.length <= 7 ? list : list.sublist(list.length - 7);
      case Period.month:
        return list.length <= 30 ? list : list.sublist(list.length - 30);
      case Period.year:
        return list.length <= 365 ? list : list.sublist(list.length - 365);
    }
  }

  double _getInterval() {
    switch (_selectedPeriod) {
      case Period.week:
        return 1; // 7 точек, шаг 1
      case Period.month:
        return 1; // 30 точек, шаг 1 (можно сделать 2 или 5 для реже)
      case Period.year:
        return 30; // 365 точек, шаг 30 дней
    }
  }

  Widget _bottomTitleWidgets(double value, TitleMeta meta) {
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 8,
      child: Text(
        value.toInt().toString(),
        style: const TextStyle(fontSize: 12),
      ),
    );
  }

  Widget _leftTitleWidgets(double value, TitleMeta meta) {
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(
        value.toStringAsFixed(1),
        style: const TextStyle(fontSize: 12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final wp = context.watch<WeightProvider>();
    final bp = context.watch<BalanceProvider>();

    final w = _filterByPeriod(wp.history);
    final spots = w.asMap().entries
        .map((e) => FlSpot(e.key.toDouble(), e.value.weight))
        .toList();
    final incomeSpots = w.asMap().entries
        .map((e) => FlSpot(
            e.key.toDouble(),
            (bp.balance / (w.isEmpty ? 1 : w.length)).toDouble()))
        .toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Прогресс и графики')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: LineChart(
                LineChartData(
                  minX: 0,
                  maxX: spots.isNotEmpty ? spots.length - 1 : 0,
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: _leftTitleWidgets,
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 32,
                        interval: _getInterval(),
                        getTitlesWidget: _bottomTitleWidgets,
                      ),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  gridData: FlGridData(show: true),
                  borderData: FlBorderData(show: true),
                  lineBarsData: [
                    LineChartBarData(
                      isCurved: true,
                      color: AppColors.primary,
                      barWidth: 3,
                      spots: spots,
                      dotData: FlDotData(show: false),
                    ),
                    LineChartBarData(
                      isCurved: true,
                      color: AppColors.success,
                      barWidth: 3,
                      spots: incomeSpots,
                      dotData: FlDotData(show: false),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: const [
                _LegendDot(color: AppColors.primary, text: 'Вес'),
                SizedBox(width: 16),
                _LegendDot(color: AppColors.success, text: 'Доход'),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ChoiceChip(
                  label: const Text('Неделя'),
                  selected: _selectedPeriod == Period.week,
                  onSelected: (_) =>
                      setState(() => _selectedPeriod = Period.week),
                ),
                ChoiceChip(
                  label: const Text('Месяц'),
                  selected: _selectedPeriod == Period.month,
                  onSelected: (_) =>
                      setState(() => _selectedPeriod = Period.month),
                ),
                ChoiceChip(
                  label: const Text('Год'),
                  selected: _selectedPeriod == Period.year,
                  onSelected: (_) =>
                      setState(() => _selectedPeriod = Period.year),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'История изменений',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.separated(
                itemCount: w.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (_, i) => ListTile(
                  title: Text('Вес: ${w[i].weight.toStringAsFixed(1)} кг'),
                  subtitle: Text('Статус: ${w[i].status}'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _LegendDot extends StatelessWidget {
  final Color color;
  final String text;
  const _LegendDot({required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(text),
      ],
    );
  }
}
