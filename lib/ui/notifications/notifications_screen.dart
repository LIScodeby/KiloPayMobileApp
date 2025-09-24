// lib/ui/notifications/notifications_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/notification_provider.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<NotificationProvider>().load()); // TODO API
  }

  @override
  Widget build(BuildContext context) {
    final n = context.watch<NotificationProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text('Уведомления')),
      body: n.loading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(24),
              children: [
                SwitchListTile(
                  title: const Text('Мотивация'),
                  value: n.preferences['motivation'] ?? false,
                  onChanged: (v) => n.toggle('motivation', v), // TODO API
                ),
                SwitchListTile(
                  title: const Text('Напоминания'),
                  value: n.preferences['reminders'] ?? false,
                  onChanged: (v) => n.toggle('reminders', v), // TODO API
                ),
                SwitchListTile(
                  title: const Text('Начисления'),
                  value: n.preferences['accruals'] ?? false,
                  onChanged: (v) => n.toggle('accruals', v), // TODO API
                ),
              ],
            ),
    );
  }
}
