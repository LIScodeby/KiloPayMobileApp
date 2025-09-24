/* // lib/ui/balance/balance_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/utils/date_utils.dart';
import '../../core/utils/validators.dart';
import '../../providers/balance_provider.dart';

class BalanceScreen extends StatefulWidget {
  const BalanceScreen({super.key});

  @override
  State<BalanceScreen> createState() => _BalanceScreenState();
}

class _BalanceScreenState extends State<BalanceScreen> {
  final _sumC = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<BalanceProvider>().load()); // TODO API
  }

  @override
  Widget build(BuildContext context) {
    final b = context.watch<BalanceProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Баланс и тарифы')),
      body: b.loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                _BalanceCard(balance: b.balance),
                const SizedBox(height: 16),
                const Text('История транзакций', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                const SizedBox(height: 8),
                ...b.transactions.map((t) => ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text('${t.type}: ${t.amount > 0 ? '+' : ''}${t.amount.toStringAsFixed(0)} ₽'),
                      subtitle: Text(AppDateUtils.formatFull(t.date)),
                    )),
                const SizedBox(height: 16),
                TextField(
                  controller: _sumC,
                  decoration: const InputDecoration(labelText: 'Сумма пополнения', border: OutlineInputBorder()),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 8),
                Row(children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        final err = Validators.amount(_sumC.text);
                        if (err != null) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(err)));
                          return;
                        }
                        await b.topUp(double.parse(_sumC.text.replaceAll(',', '.'))); // TODO API
                      },
                      child: const Text('Пополнить'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      child: const Text('Перейти на следующий'),
                    ),
                  ),
                ]),
                const SizedBox(height: 24),
                _TariffInfo(name: b.tariff?.name ?? '—', percent: b.tariff?.percent ?? 0),
              ]),
            ),
    );
  }
}

class _BalanceCard extends StatelessWidget {
  final double balance;
  const _BalanceCard({required this.balance});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration:
          BoxDecoration(color: Colors.white, border: Border.all(color: AppColors.border), borderRadius: BorderRadius.circular(16)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('Текущий баланс', style: TextStyle(color: AppColors.textSecondary)),
        const SizedBox(height: 6),
        Text('${balance.toStringAsFixed(0)} ₽', style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w800)),
      ]),
    );
  }
}

class _TariffInfo extends StatelessWidget {
  final String name;
  final int percent;

  const _TariffInfo({required this.name, required this.percent});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration:
          BoxDecoration(color: AppColors.bgLight, borderRadius: BorderRadius.circular(16)),
      child: Row(children: [
        const Icon(Icons.monetization_on_outlined, color: AppColors.primary),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Тариф: $name', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
          const SizedBox(height: 4),
          const Text('Автоматический расчет процентов'),
        ])),
        SizedBox(
          width: 56,
          height: 56,
          child: Stack(alignment: Alignment.center, children: [
            CircularProgressIndicator(value: percent / 100, color: AppColors.primary, backgroundColor: Colors.white),
            Text('$percent%'),
          ]),
        ),
      ]),
    );
  }
}
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/utils/date_utils.dart';
import '../../core/utils/validators.dart';
import '../../providers/balance_provider.dart';
import '../../core/widgets/primary_button.dart';

class BalanceScreen extends StatefulWidget {
  const BalanceScreen({super.key});

  @override
  State<BalanceScreen> createState() => _BalanceScreenState();
}

class _BalanceScreenState extends State<BalanceScreen> {
  final _sumC = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<BalanceProvider>().load()); // TODO API
  }

  @override
  Widget build(BuildContext context) {
    final b = context.watch<BalanceProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Баланс и тарифы')),
      body: b.loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _BalanceCard(balance: b.balance),
                  const SizedBox(height: 16),
                  const Text(
                    'История транзакций',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 8),
                  ...b.transactions.map(
                    (t) => ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        '${t.type}: ${t.amount > 0 ? '+' : ''}${t.amount.toStringAsFixed(0)} ₽',
                      ),
                      subtitle: Text(AppDateUtils.formatFull(t.date)),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _sumC,
                    decoration: const InputDecoration(
                      labelText: 'Сумма пополнения',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: PrimaryButton(
                          label: 'Пополнить',
                          onPressed: () async {
                            final err = Validators.amount(_sumC.text);
                            if (err != null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(err)),
                              );
                              return;
                            }
                            await b.topUp(
                              double.parse(
                                _sumC.text.replaceAll(',', '.'),
                              ),
                            ); // TODO API
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: PrimaryButton(
                          label: 'Перейти на следующий',
                          outlined: true,
                          onPressed: () {
                            // Логика осталась прежней
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  _TariffInfo(
                    name: b.tariff?.name ?? '—',
                    percent: b.tariff?.percent ?? 0,
                  ),
                ],
              ),
            ),
    );
  }
}

class _BalanceCard extends StatelessWidget {
  final double balance;
  const _BalanceCard({required this.balance});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Текущий баланс',
            style: TextStyle(color: AppColors.textSecondary),
          ),
          const SizedBox(height: 6),
          Text(
            '${balance.toStringAsFixed(0)} ₽',
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w800),
          ),
        ],
      ),
    );
  }
}

class _TariffInfo extends StatelessWidget {
  final String name;
  final int percent;

  const _TariffInfo({required this.name, required this.percent});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.bgLight,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Icon(Icons.monetization_on_outlined, color: AppColors.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Тариф: $name',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                const Text('Автоматический расчет процентов'),
              ],
            ),
          ),
          SizedBox(
            width: 56,
            height: 56,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  value: percent / 100,
                  color: AppColors.primary,
                  backgroundColor: Colors.white,
                ),
                Text('$percent%'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
