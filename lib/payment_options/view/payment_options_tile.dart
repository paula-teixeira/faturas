import 'package:faturas/payment_options/model/payment_model.dart';
import 'package:faturas/payment_options/view_model/payment_options.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

NumberFormat formatter = NumberFormat.simpleCurrency();

class PaymentOptionsTile extends StatelessWidget {
  final PaymentOption paymentOption;


  PaymentOptionsTile(this.paymentOption);

  @override
  Widget build(BuildContext context) {
    final payment = context.select((PaymentOptionsViewModel payment) => payment);
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
        groupValue: payment.selectedPaymentOption,
        onChanged: (PaymentOption? value) {
          if (value == null){ return; }
          payment.selectedPaymentOption = value;
        },
        ),
      );
  }
}
