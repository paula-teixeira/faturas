import 'package:faturas/Manager/network_manager.dart';
import 'package:faturas/payment_options/model/credit_card/credit_card_model.dart';
import 'package:faturas/payment_options/model/payment_option/payment_options_model.dart';
import 'package:faturas/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

GetIt getIt = GetIt.instance;

void main() {
  getIt.registerSingleton<NetworkManager>(NetworkManager(), signalsReady: true);

  runApp(
    Faturas(),
  );
  Intl.defaultLocale = 'pt_BR';
}

class Faturas extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PaymentOptionsModel>(
          create: (_) => PaymentOptionsModel(),
        ),
        ChangeNotifierProvider<CreditCardModel>(
          create: (_) => CreditCardModel(),
        ),
      ],
      child: MaterialApp(
        home: HomeScreen(),
        ),
    );
  }
}
