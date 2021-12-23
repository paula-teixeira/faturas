import 'package:faturas/payment_options/model/payment_model.dart';
import 'package:faturas/payment_options/model/payment_options_model.dart';
import 'package:flutter/material.dart';

class PaymentOptionsViewModel {
  final PaymentOptionsModel _paymentOptionsModel;

  PaymentOptionsViewModel({required PaymentOptionsModel paymentOptionsModel})
      : _paymentOptionsModel = paymentOptionsModel;

  List<PaymentOption> get paymentOptions {
    return _paymentOptionsModel.paymentOptions;
  }

  get invoiceValue {
    return _paymentOptionsModel.invoiceValue;
  }

  PaymentOption get selectedPaymentOption{
    return _paymentOptionsModel.selectedPaymentOption;
  }

  set selectedPaymentOption(PaymentOption newPaymentOption) {
    _paymentOptionsModel.selectedPaymentOption = newPaymentOption;
  }

  double get operationTax {
    return (_paymentOptionsModel.selectedPaymentOption.number *
        _paymentOptionsModel.selectedPaymentOption.value) -
        _paymentOptionsModel.invoiceValue;
  }

}
