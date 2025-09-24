// lib/ui/auth/reset_password_screen.dart
import 'package:flutter/material.dart';
import '../../core/widgets/primary_button.dart';
import '../../core/utils/validators.dart';
import '../../core/widgets/app_text_field.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Восстановление пароля')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(children: [
            AppTextField(controller: _emailC, label: 'Email', validator: Validators.email),
            const SizedBox(height: 16),
            PrimaryButton(
              label: 'Отправить ссылку',
              onPressed: () async {
                if (_formKey.currentState?.validate() != true) return;
                // TODO: отправка ссылки на email через API
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Ссылка отправлена (мок)')));
              },
            ),
          ]),
        ),
      ),
    );
  }
}
