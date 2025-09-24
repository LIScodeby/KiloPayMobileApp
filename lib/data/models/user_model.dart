// lib/data/models/user_model.dart
class UserModel {
  final String id;
  final String name;
  final String? country;
  final String? telegram;
  final String? avatarUrl;
  final String tariffStatus;
  final double deposit;

  UserModel({
    required this.id,
    required this.name,
    this.country,
    this.telegram,
    this.avatarUrl,
    required this.tariffStatus,
    required this.deposit,
  });

  factory UserModel.mock() => UserModel(
        id: '123456',
        name: 'Иван',
        country: 'Россия',
        telegram: '@username',
        avatarUrl: null,
        tariffStatus: 'Премиум',
        deposit: 12600,
      );
}
