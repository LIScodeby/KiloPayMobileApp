// lib/data/models/tariff_model.dart
class TariffModel {
  final String name;
  final int percent;
  final String? description;

  TariffModel({required this.name, required this.percent, this.description});

  factory TariffModel.mockBasic() =>
      TariffModel(name: 'Базовый', percent: 25, description: 'Стартовый тариф');
}
