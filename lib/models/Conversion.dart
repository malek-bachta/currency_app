class Conversion {
  final String inputAmount;
  final String from;
  final String to;
  final String result;
  final DateTime dateTime;

  Conversion({
    required this.inputAmount,
    required this.from,
    required this.to,
    required this.result,
    required this.dateTime,
  });

  Map<String, dynamic> toJson() {
    return {
      'from': from,
      'to': to,
      'inputAmount': inputAmount,
      'result': result,
      'dateTime': dateTime.toIso8601String(),
    };
  }

  static Conversion fromJson(Map<String, dynamic> json) {
    return Conversion(
      from: json['from'],
      to: json['to'],
      inputAmount: json['inputAmount'],
      result: json['result'],
      dateTime: DateTime.parse(json['dateTime']),
    );
  }
}
