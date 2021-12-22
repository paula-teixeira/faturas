import 'package:faturas/payment_options/model/payment_model.dart';
import 'package:faturas/payment_options/model/payment_options_model.dart';

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
}
