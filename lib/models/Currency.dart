class Currency {
  final String name;
  final String code;

  Currency({required this.name, required this.code});

  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(
      name: json['name'],
      code: json['code'],
    );
  }
}
