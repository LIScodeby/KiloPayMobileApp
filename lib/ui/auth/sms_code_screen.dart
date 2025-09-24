// lib/ui/auth/sms_code_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/widgets/primary_button.dart';
import '../../providers/auth_provider.dart';
import '../../routes/app_routes.dart';

class SmsCodeScreen extends StatefulWidget {
  const SmsCodeScreen({super.key});

  @override
  State<SmsCodeScreen> createState() => _SmsCodeScreenState();
}

class _SmsCodeScreenState extends State<SmsCodeScreen> {
  final _codeC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final map = (ModalRoute.of(context)?.settings.arguments as Map?) ?? {};
    final phone = map['phone'] as String? ?? '';
    final password = map['password'] as String? ?? '';
    final email = map['email'] as String?;
    final auth = context.watch<AuthProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Подтверждение телефона')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Text('Введите код из СМС (6 цифр)'),
            const SizedBox(height: 12),
            TextField(
              controller: _codeC,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(border: OutlineInputBorder(), hintText: '123456'),
              maxLength: 6,
            ),
            const SizedBox(height: 16),
            PrimaryButton(
              label: 'Подтвердить',
              loading: auth.loading,
              onPressed: () async {
                final ok = await auth.verifyCode(phone, _codeC.text); // TODO API
                if (!ok) return;
                final registered = await auth.register(phone, password, email: email); // TODO API
                if (registered && mounted) {
                  Navigator.pushNamedAndRemoveUntil(context, AppRoutes.dashboard, (_) => false);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
