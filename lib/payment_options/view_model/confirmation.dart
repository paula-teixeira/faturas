import 'package:faturas/payment_options/model/credit_card/credit_card.dart';
import 'package:faturas/payment_options/model/credit_card/credit_card_model.dart';
import 'package:faturas/payment_options/model/payment_option/payment_option.dart';
import 'package:faturas/payment_options/model/payment_option/payment_options_model.dart';

class ConfirmationViewModel {
  final PaymentOptionsModel _paymentOptionsModel;
  final CreditCardModel _creditCardModel;

  ConfirmationViewModel(
      {required PaymentOptionsModel paymentOptionsModel,
      required CreditCardModel creditCardModel})
      : _paymentOptionsModel = paymentOptionsModel,
        _creditCardModel = creditCardModel;

  PaymentOption? get selectedPaymentOption {
    return _paymentOptionsModel.selectedPaymentOption;
  }

  CreditCard? get creditCard {
    return _creditCardModel.creditCard;
  }

  get invoiceValue {
    return _paymentOptionsModel.invoiceValue;
  }
}
