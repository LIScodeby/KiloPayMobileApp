// lib/ui/auth/login_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_strings.dart';
import '../../core/utils/validators.dart';
import '../../core/widgets/app_text_field.dart';
import '../../core/widgets/primary_button.dart';
import '../../providers/auth_provider.dart';
import '../../routes/app_routes.dart';
import '../../core/utils/formatters.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneC = TextEditingController(text: '+7 ');
  final _passC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Вход')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(children: [
            const SizedBox(height: 16),
            AppTextField(
              controller: _phoneC,
              label: 'Телефон',
              validator: Validators.phone,
              keyboardType: TextInputType.phone,
              inputFormatters: [MaskedPhoneFormatter()],
            ),
            const SizedBox(height: 12),
            AppTextField(
              controller: _passC,
              label: 'Пароль',
              obscure: true,
              validator: Validators.password,
            ),
            const SizedBox(height: 20),
            PrimaryButton(
              label: AppStrings.enter,
              loading: auth.loading,
              onPressed: () async {
                if (_formKey.currentState?.validate() != true) return;
                final ok = await auth.login(_phoneC.text, _passC.text); // TODO: заменить мок на API
                if (ok && mounted) {
                  Navigator.pushNamedAndRemoveUntil(context, AppRoutes.dashboard, (_) => false);
                }
              },
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () => Navigator.pushNamed(context, AppRoutes.resetPassword),
              child: const Text(AppStrings.forgotPassword),
            ),
          ]),
        ),
      ),
    );
  }
}
