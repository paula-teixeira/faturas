import 'package:faturas/payment_options/model/payment_option/payment_option.dart';
import 'package:faturas/payment_options/model/payment_option/payment_options_model.dart';
import 'package:faturas/payment_options/view/payment_options_tile.dart';
import 'package:faturas/payment_options/view_model/payment_options.dart';
import 'package:faturas/screen/credit_card_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

NumberFormat formatter = NumberFormat.simpleCurrency();

class PaymentOptionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProxyProvider<PaymentOptionsModel, PaymentOptionsViewModel>(
      create: (context) => PaymentOptionsViewModel(
          paymentOptionsModel: context.read<PaymentOptionsModel>()),
      update: (context, paymentOptionsModel, notifier) =>
          PaymentOptionsViewModel(
            paymentOptionsModel: paymentOptionsModel,
          ),
      child: PaymentOptionsWidget(),
    );
  }
}

class PaymentOptionsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final paymentOptions = context
        .select((PaymentOptionsViewModel paymentOptions) => paymentOptions);

    return Scaffold(
      appBar: AppBar(
        title: Text('Pagamento da fatura'),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text(
              'Escolha o número de parcelas:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: FutureBuilder<List<PaymentOption>>(
                future: context.select(
                  (PaymentOptionsViewModel model) => model.getPaymentOptions(),
                ),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final paymentOptions = snapshot.data!;
                    return ListView.builder(
                      itemCount: paymentOptions.length,
                      itemBuilder: (context, index) {
                        final paymentOption = paymentOptions[index];
                        return PaymentOptionsTile(paymentOption);
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 100),
                        child: CircularProgressIndicator(),
                      ),
                    ],
                  );
                },
              ),
            ),
            Divider(),
            Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Fatura de junho',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          '${formatter.format(paymentOptions.invoiceValue)}',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Taxa de operação',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          '${formatter.format(paymentOptions.operationTax)}',
                          key: Key('operationTax'),
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                children: [
                  OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Voltar'),
                  ),
                  Spacer(),
                  Text('1 de 3'),
                  Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreditCardScreen(),
                        ),
                      );
                    },
                    child: Text('Continuar'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
