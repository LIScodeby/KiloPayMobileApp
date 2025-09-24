// lib/ui/withdrawals/withdrawals_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/utils/validators.dart';
import '../../core/widgets/app_text_field.dart';
import '../../core/widgets/primary_button.dart';
import '../../providers/balance_provider.dart';

class WithdrawalsScreen extends StatefulWidget {
  const WithdrawalsScreen({Key? key}) : super(key: key);

  @override
  State<WithdrawalsScreen> createState() => _WithdrawalsScreenState();
}

class _WithdrawalsScreenState extends State<WithdrawalsScreen> {
  final _amountController = TextEditingController();
  String _method = 'card'; // card or phone

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final balanceProvider = context.watch<BalanceProvider>();
    final maxBalance = balanceProvider.balance;

    return Scaffold(
      appBar: AppBar(title: const Text('Вывод средств')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Выберите метод вывода', style: TextStyle(fontWeight: FontWeight.w700)),
            const SizedBox(height: 16),
            Row(
              children: [
                _MethodButton(
                  icon: Icons.credit_card,
                  label: 'Карта',
                  selected: _method == 'card',
                  onTap: () => setState(() => _method = 'card'),
                ),
                const SizedBox(width: 16),
                _MethodButton(
                  icon: Icons.phone_android,
                  label: 'Телефон',
                  selected: _method == 'phone',
                  onTap: () => setState(() => _method = 'phone'),
                ),
              ],
            ),
            const SizedBox(height: 24),
            AppTextField(
              controller: _amountController,
              label: 'Сумма (до ${maxBalance.toStringAsFixed(0)} ₽)',
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              validator: (v) {
                final err = Validators.amount(v);
                if (err != null) return err;
                final val = double.tryParse(v!.replaceAll(',', '.')) ?? 0;
                if (val > maxBalance) return 'Превышает доступный баланс';
                return null;
              },
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      // TODO: заменить на реальный вызов API для проверки лимитов
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Лимиты проверены (мок)')),
                      );
                    },
                    child: const Text('Проверка лимитов'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            PrimaryButton(
              label: 'Отправить заявку',
              onPressed: () {
                final formError = Validators.amount(_amountController.text);
                if (formError != null) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(formError)));
                  return;
                }
                final amount = double.parse(_amountController.text.replaceAll(',', '.'));
                // TODO: вызвать API для создания заявки на вывод
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Заявка на вывод $amount ₽ отправлена (мок)')),
                );
              },
            ),
            const SizedBox(height: 24),
            Center(
              child: TextButton(
                onPressed: () {
                  // TODO: в будущем заменить на навигацию к экрану истории
                },
                child: const Text('История заявок'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MethodButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _MethodButton({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: selected ? AppColors.primary.withOpacity(0.1) : Colors.white,
            border: Border.all(
              color: selected ? AppColors.primary : AppColors.border,
              width: selected ? 2 : 1,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Icon(icon, color: selected ? AppColors.primary : AppColors.textSecondary),
              const SizedBox(height: 8),
              Text(label,
                  style: TextStyle(
                    color: selected ? AppColors.primary : AppColors.textSecondary,
                    fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
