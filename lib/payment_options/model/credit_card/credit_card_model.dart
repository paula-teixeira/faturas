import 'package:faturas/payment_options/model/credit_card/credit_card.dart';
import 'package:flutter/cupertino.dart';

class CreditCardModel extends ChangeNotifier {
  CreditCard? _creditCard;

  CreditCard? get creditCard {
    return _creditCard;
  }

  set creditCard(CreditCard? creditCard) {
    _creditCard = creditCard;
    notifyListeners();
  }

}