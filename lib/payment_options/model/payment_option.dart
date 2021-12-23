import 'package:flutter/cupertino.dart';

class PaymentOption {
  final int number;
  final double value;
  final double total;

  PaymentOption(
      this.number, this.value, this.total);

  PaymentOption.fromJson(Map<String, dynamic> json)
      : number = json['number'],
        value = json['value'].toDouble(),
        total = json['total'].toDouble();

  @override
  String toString() {
    return 'PaymentOption{number: $number, value: $value, total: $total}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PaymentOption &&
          number == other.number &&
          value == other.value &&
          total == other.total;


  @override
  int get hashCode => hashValues(number, value, total);
}
