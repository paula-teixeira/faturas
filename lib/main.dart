import 'package:faturas/payment_options/model/payment_options_model.dart';
import 'package:faturas/payment_options/view_model/payment_options.dart';
import 'package:faturas/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<PaymentOptionsModel>(
          create: (_) => PaymentOptionsModel(),
        ),
        ProxyProvider<PaymentOptionsModel, PaymentOptionsViewModel>(
          create: (context) => PaymentOptionsViewModel(
              paymentOptionsModel: context.read<PaymentOptionsModel>()),
          update: (context, paymentOptionsModel, notifier) =>
              PaymentOptionsViewModel(paymentOptionsModel: paymentOptionsModel),
        ),
      ],
      child: Faturas(),
    ),
  );
  Intl.defaultLocale = 'pt_BR';
}

class Faturas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}
