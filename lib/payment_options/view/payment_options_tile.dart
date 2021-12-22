import 'package:faturas/payment_options/model/payment_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

NumberFormat formatter = NumberFormat.simpleCurrency();

class PaymentOptionsTile extends StatelessWidget {
  final PaymentOption paymentOption;
  final PaymentOption selectedPaymentOption;
  final Function onChanged;


  PaymentOptionsTile(this.paymentOption, this.selectedPaymentOption, this.onChanged);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: RadioListTile(
        title: Row(
          children: [
            Text('${paymentOption.number} x ${formatter.format(paymentOption.value)}'),
            Spacer(),
            Text('${formatter.format(paymentOption.total)}'),
          ],
        ),
        value: paymentOption,
        groupValue: selectedPaymentOption,
        onChanged: (PaymentOption? value) {
          onChanged(value!);
        },
        ),
      );
  }
}
