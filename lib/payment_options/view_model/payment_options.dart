import 'package:faturas/payment_options/model/payment_option.dart';
import 'package:faturas/payment_options/model/payment_options_model.dart';
import 'package:flutter/material.dart';

class PaymentOptionsViewModel {
  final PaymentOptionsModel _paymentOptionsModel;

  PaymentOptionsViewModel({required PaymentOptionsModel paymentOptionsModel})
      : _paymentOptionsModel = paymentOptionsModel;

  Future<List<PaymentOption>> getPaymentOptions() {
    return _paymentOptionsModel.getPaymentOptions();
  }

  get invoiceValue {
    return _paymentOptionsModel.invoiceValue;
  }

  PaymentOption? get selectedPaymentOption {
    return _paymentOptionsModel.selectedPaymentOption;
  }

  set selectedPaymentOption(PaymentOption? newPaymentOption) {
    _paymentOptionsModel.selectedPaymentOption = newPaymentOption;
  }

  double get operationTax {
    if (_paymentOptionsModel.selectedPaymentOption == null){
      return 0;
    }

    return (_paymentOptionsModel.selectedPaymentOption!.number *
        _paymentOptionsModel.selectedPaymentOption!.value) -
        _paymentOptionsModel.invoiceValue;
  }

}
