import 'package:faturas/Manager/network_manager.dart';
import 'package:faturas/payment_options/model/payment_option/payment_option.dart';
import 'package:flutter/cupertino.dart';
import '../../../main.dart';

// List<PaymentOption> defaultPaymentOptions = [
//   PaymentOption(1, 3180, 3180),
//   PaymentOption(2, 1630, 3260),
//   PaymentOption(3, 1086.67, 3260),
//   PaymentOption(4, 815, 3260),
//   PaymentOption(5, 662, 3310),
//   PaymentOption(6, 551.67, 3310),
//   PaymentOption(7, 472.86, 3310),
// ];

class PaymentOptionsModel extends ChangeNotifier {
  double _invoiceValue;
  List<PaymentOption>? _paymentOptions;
  PaymentOption? _selectedPaymentOption;

  PaymentOptionsModel() : _invoiceValue = 3025.49;

  Future<List<PaymentOption>> getPaymentOptions() async {
    if (_paymentOptions == null) {
      _paymentOptions = await getIt<NetworkManager>().getData();
      selectedPaymentOption = _paymentOptions?[0];
    }
    return _paymentOptions!;
  }

  double get invoiceValue {
    return _invoiceValue;
  }

  set selectedPaymentOption(PaymentOption? newPaymentOption) {
    _selectedPaymentOption = newPaymentOption;
    notifyListeners();
  }

  PaymentOption? get selectedPaymentOption {
    return _selectedPaymentOption;
  }

}
