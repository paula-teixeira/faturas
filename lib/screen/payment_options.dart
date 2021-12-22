import 'package:faturas/payment_options/model/payment_model.dart';
import 'package:faturas/payment_options/model/payment_options_model.dart';
import 'package:faturas/payment_options/view/payment_options_tile.dart';
import 'package:faturas/payment_options/view_model/payment_options.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

NumberFormat formatter = NumberFormat.simpleCurrency();

class PaymentOptionsScreen extends StatefulWidget {
  PaymentOptionsViewModel paymentOptionsViewModel =
      PaymentOptionsViewModel(paymentOptionsModel: PaymentOptionsModel());

  late PaymentOption selectedPaymentOption;

  @override
  _PaymentOptionsScreenState createState() => _PaymentOptionsScreenState();
}

class _PaymentOptionsScreenState extends State<PaymentOptionsScreen> {
  @override
  void initState() {
    super.initState();
    widget.selectedPaymentOption =
        widget.paymentOptionsViewModel.paymentOptions[0];
  }

  @override
  Widget build(BuildContext context) {
    var operationTax = (widget.selectedPaymentOption.number *
            widget.selectedPaymentOption.value) -
        widget.paymentOptionsViewModel.invoiceValue;
    
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
              child: ListView.builder(
                itemCount: widget.paymentOptionsViewModel.paymentOptions.length,
                itemBuilder: (context, index) {
                  final paymentOption =
                      widget.paymentOptionsViewModel.paymentOptions[index];
                  return PaymentOptionsTile(
                      paymentOption, widget.selectedPaymentOption, (value) {
                    setState(() {
                      widget.selectedPaymentOption = value;
                    });
                  });
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
                          '${formatter.format(widget.paymentOptionsViewModel.invoiceValue)}',
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
                          '${formatter.format(operationTax)}',
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
                    onPressed: () {},
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
