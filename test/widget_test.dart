// test/widget_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kilopay/main.dart';

void main() {
  group('KiloPayApp widget tests', () {
    testWidgets('Onboarding screen shows app title and buttons',
        (WidgetTester tester) async {
      // Запускаем приложение
      await tester.pumpWidget(const KiloPayApp());
      await tester.pumpAndSettle();

      // Должен быть заголовок
      expect(find.text('KiloPay'), findsOneWidget);

      // Кнопки Регистрация и Вход
      expect(find.text('Регистрация'), findsOneWidget);
      expect(find.text('Вход'), findsOneWidget);

      // Первый слайд онбординга
      expect(find.text('Внеси депозит'), findsOneWidget);
    });

    testWidgets('Тап по "Регистрация" переходит на RegisterScreen',
        (WidgetTester tester) async {
      await tester.pumpWidget(const KiloPayApp());
      await tester.pumpAndSettle();

      // Нажать на кнопку "Регистрация"
      await tester.tap(find.text('Регистрация'));
      await tester.pumpAndSettle();

      // Должен появиться AppBar с заголовком "Регистрация"
      expect(find.widgetWithText(AppBar, 'Регистрация'), findsOneWidget);

      // Поле телефона на экране регистрации
      expect(find.byType(TextFormField), findsWidgets);
      expect(find.text('Телефон'), findsOneWidget);
    });

    testWidgets('Тап по "Вход" переходит на LoginScreen',
        (WidgetTester tester) async {
      await tester.pumpWidget(const KiloPayApp());
      await tester.pumpAndSettle();

      // Нажать на кнопку "Вход"
      await tester.tap(find.text('Вход').last);
      await tester.pumpAndSettle();

      // Проверяем, что в AppBar появился заголовок "Вход"
      expect(find.widgetWithText(AppBar, 'Вход'), findsOneWidget);

      // На экране логина должны быть поля "Телефон" и "Пароль"
      expect(find.text('Телефон'), findsOneWidget);
      expect(find.text('Пароль'), findsOneWidget);
    });

    testWidgets('Навигация в Dashboard после логина (мок)',
        (WidgetTester tester) async {
      await tester.pumpWidget(const KiloPayApp());
      await tester.pumpAndSettle();

      // Переходим в LoginScreen
      await tester.tap(find.text('Вход').last);
      await tester.pumpAndSettle();

      // Заполняем поля логина
      await tester.enterText(find.byType(TextFormField).at(0), '+7 999 123-45-67');
      await tester.enterText(find.byType(TextFormField).at(1), 'password');
      await tester.tap(find.text('Войти'));
      await tester.pumpAndSettle();

      // Т.к. в AuthProvider мок возвращает успешный логин,
      // мы должны увидеть DashboardScreen
      expect(find.text('Привет,'), findsOneWidget);
      expect(find.text('Зафиксировать вес'), findsOneWidget);
      expect(find.text('Пополнить депозит'), findsOneWidget);
      expect(find.text('Вывести средства'), findsOneWidget);
    });
  });
}
