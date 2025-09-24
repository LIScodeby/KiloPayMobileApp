// lib/ui/auth/register_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/utils/validators.dart';
import '../../core/widgets/app_text_field.dart';
import '../../core/widgets/primary_button.dart';
import '../../providers/auth_provider.dart';
import '../../routes/app_routes.dart';
import '../../core/utils/formatters.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneC = TextEditingController(text: '+7 ');
  final _passC = TextEditingController();
  final _confirmC = TextEditingController();
  final _emailC = TextEditingController();
  bool agree = false;

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Регистрация')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(children: [
            AppTextField(
              controller: _phoneC,
              label: 'Телефон',
              keyboardType: TextInputType.phone,
              validator: Validators.phone,
              inputFormatters: [MaskedPhoneFormatter()],
            ),
            const SizedBox(height: 12),
            AppTextField(
              controller: _passC,
              label: 'Пароль',
              obscure: true,
              validator: Validators.password,
            ),
            const SizedBox(height: 12),
            AppTextField(
              controller: _confirmC,
              label: 'Подтверждение пароля',
              obscure: true,
              validator: (v) => Validators.confirmPassword(v, _passC.text),
            ),
            const SizedBox(height: 12),
            AppTextField(
              controller: _emailC,
              label: 'Email (необязательно)',
              validator: Validators.email,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 12),
            Row(children: [
              Checkbox(value: agree, onChanged: (v) => setState(() => agree = v ?? false)),
              const Flexible(child: Text('Я соглашаюсь с правилами')),
            ]),
            const SizedBox(height: 12),
            PrimaryButton(
              label: 'Отправить код',
              loading: auth.loading,
              onPressed: () async {
                if (!agree) return;
                if (_formKey.currentState?.validate() != true) return;
                final ok = await auth.sendCode(_phoneC.text); // TODO API
                if (ok && mounted) {
                  Navigator.pushNamed(context, AppRoutes.smsCode, arguments: {
                    'phone': _phoneC.text,
                    'password': _passC.text,
                    'email': _emailC.text,
                  });
                }
              },
            ),
            const SizedBox(height: 16),
            const Text('Политика конфиденциальности и условия использования', style: TextStyle(fontSize: 12)),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () => Navigator.pushReplacementNamed(context, AppRoutes.login),
              child: const Text('Уже есть аккаунт? Войти'),
            ),
          ]),
        ),
      ),
    );
  }
}
