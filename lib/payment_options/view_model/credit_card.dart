import 'package:faturas/payment_options/model/credit_card/credit_card.dart';
import 'package:faturas/payment_options/model/credit_card/credit_card_model.dart';

class CreditCardViewModel {
  final CreditCardModel _creditCardModel;

  CreditCardViewModel({required CreditCardModel creditCardModel})
      : _creditCardModel = creditCardModel;

  CreditCard? get creditCard {
    return _creditCardModel.creditCard;
  }

  set creditCard(CreditCard? creditCard) {
    _creditCardModel.creditCard = creditCard;
  }

}
