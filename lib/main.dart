import 'package:faturas/Manager/network_manager.dart';
import 'package:faturas/payment_options/model/payment_options_model.dart';
import 'package:faturas/payment_options/view_model/payment_options.dart';
import 'package:faturas/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

GetIt getIt = GetIt.instance;

void main() {
  getIt.registerSingleton<NetworkManager>(NetworkManager(), signalsReady: true);

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
