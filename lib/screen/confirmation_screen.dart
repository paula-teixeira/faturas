import 'package:faturas/components/components.dart';
import 'package:faturas/payment_options/model/credit_card/credit_card_model.dart';
import 'package:faturas/payment_options/model/payment_option/payment_options_model.dart';
import 'package:faturas/payment_options/view_model/confirmation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

NumberFormat formatter = NumberFormat.simpleCurrency();

Future<String> processPayment(String cvv) async =>
    await Future.delayed(Duration(seconds: 2), () {
      if (cvv != '111') {
        return 'error';
      }
      return 'ok';
    });

showProcessingDialog(BuildContext context, String cvv) {
  Widget okButton = TextButton(
    onPressed: () {
      Navigator.pop(context);
    },
    child: Text('OK'),
  );

  Widget reviewButton = TextButton(
    onPressed: () {
      Navigator.pop(context);
    },
    child: Text('Revisar dados'),
  );

  AlertDialog processingDialog = AlertDialog(
    title: Column(
      children: [
        CircularProgressIndicator(),
        Text('Confirmando seu pagamento'),
      ],
    ),
    content: Text(
        'Estamos confirmando a transação com seu banco e isso pode levar alguns segundos.'),
  );

  AlertDialog okDialog = AlertDialog(
    title: Text('Cobrança efetuada'),
    content: Text('Seu pagamento foi efetuado'),
    actions: [okButton],
  );

  AlertDialog errorDialog = AlertDialog(
    title: Text('Falha na cobrança'),
    content: Text('Algo deu errado no processamento do seu cartão.'
        'Verifique se seus dados estão corretos.'),
    actions: [reviewButton],
  );

  showDialog(
      context: context,
      builder: (context) {
        return FutureBuilder<String>(
          future: processPayment(cvv),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data == 'ok') {
                return okDialog;
              } else {
                return errorDialog;
              }
            }
            return processingDialog;
          },
        );
      });
}

class ConfirmationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ProxyProvider2<PaymentOptionsModel, CreditCardModel,
          ConfirmationViewModel>(
        create: (context) => ConfirmationViewModel(
          paymentOptionsModel: context.read<PaymentOptionsModel>(),
          creditCardModel: context.read<CreditCardModel>(),
        ),
        update: (context, paymentOptionsModel, creditCardModel, notifier) =>
            ConfirmationViewModel(
                paymentOptionsModel: paymentOptionsModel,
                creditCardModel: creditCardModel),
      ),
    ], child: ConfirmationWidget());
  }
}

class ConfirmationWidget extends StatefulWidget {

  @override
  _ConfirmationWidgetState createState() => _ConfirmationWidgetState();
}

class _ConfirmationWidgetState extends State<ConfirmationWidget> {
  @override
  Widget build(BuildContext context) {

    final confirmation = context.select((ConfirmationViewModel confirmation) => confirmation);

    final operationTaxLabel = formatter.format(confirmation.selectedPaymentOption!.total - confirmation.invoiceValue);

    final totalLabel = formatter.format(confirmation.selectedPaymentOption!.total);

    final paymentLabel = '${confirmation.selectedPaymentOption!.number} x ${formatter.format(confirmation.selectedPaymentOption!.value)}';

    final invoiceLabel = formatter.format(confirmation.invoiceValue);

    return Scaffold(
      appBar: AppBar(
        title: Text('Pagamento da fatura'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text(
              'Revise os valores',
              style: formLabelTextStyle,
            ),
            Card(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Text(
                          'Fatura de junho',
                          style: subtitleTextStyle,
                        ),
                        Spacer(),
                        Text(
                          invoiceLabel,
                          style: subtitleTextStyle,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Text(
                          'Taxa de operação',
                          style: subtitleTextStyle,
                        ),
                        Spacer(),
                        Text(
                          operationTaxLabel,
                          style: subtitleTextStyle,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Text(
                          'Total',
                          style: subtitleTextStyle,
                        ),
                        Spacer(),
                        Text(
                          totalLabel,
                          style: subtitleTextStyle,
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Text(
                          'Você vai pagar',
                          style: titleTextStyle,
                        ),
                        Spacer(),
                        Text(
                          paymentLabel,
                          style: titleTextStyle,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                    'Este pagamento é referente somente ao mês de junho. '
                    'Não vamos salvar os dados do seu cartão para '
                    'pagamentos recorrentes.',
                    style: descriptionTextStyle),
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
                  Text('3 de 3'),
                  Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      showProcessingDialog(context, confirmation.creditCard!.cvv);
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
