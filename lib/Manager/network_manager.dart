import 'dart:convert';

import 'package:faturas/payment_options/model/payment_option.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NetworkManager {
  final url =
      Uri.parse('https://dreamy-allen-2e1b47.netlify.app/payment-options.json');

  Future<List<PaymentOption>> getData() async {
    http.Response response = await http.get(url).timeout(Duration(seconds: 15));

    if (response.statusCode == 200) {
      final decodedJson = jsonDecode(response.body)['options']['installments'];
      final paymentData = decodedJson.map<PaymentOption>((json) => PaymentOption.fromJson(json)).toList();
      debugPrint(paymentData.toString());

      return paymentData;
    } else {
      throw Exception('Falha ao carregar dados.');
    }
  }
}
