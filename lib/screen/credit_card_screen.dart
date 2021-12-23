import 'package:faturas/components/components.dart';
import 'package:faturas/payment_options/model/credit_card/credit_card.dart';
import 'package:faturas/payment_options/model/credit_card/credit_card_model.dart';
import 'package:faturas/payment_options/view_model/credit_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'confirmation_screen.dart';

class CreditCardScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ProxyProvider<CreditCardModel, CreditCardViewModel>(
        create: (context) => CreditCardViewModel(
            creditCardModel: context.read<CreditCardModel>()),
        update: (context, creditCardModel, notifier) =>
            CreditCardViewModel(
              creditCardModel: creditCardModel,
            ),
      ),
    ], child: CreditCardWidget());
  }
}


class CreditCardWidget extends StatefulWidget {
  @override
  _CreditCardWidgetState createState() => _CreditCardWidgetState();
}

class _CreditCardWidgetState extends State<CreditCardWidget> {
  final _formKey = new GlobalKey<FormState>();

  final _numberController = TextEditingController();
  final _nameController = TextEditingController();
  final _expirationController = TextEditingController();
  final _cvvController = TextEditingController();

  String? _notEmpty(String? text) {
    if (text == null || text.isEmpty) {
      return 'Deve ser preenchido';
    }
    return null;
  }

  @override
  void dispose() {
    _numberController.dispose();
    _nameController.dispose();
    _expirationController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final creditCardViewModel = context.select(
      (CreditCardViewModel model) => model,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Pagamento da fatura'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text(
              'Número do cartão',
              style: formLabelTextStyle,
            ),
            TextFormField(
              controller: _numberController,
              maxLength: 16,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              validator: _notEmpty,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Nome do titular do cartão',
              style: formLabelTextStyle,
            ),
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
              validator: _notEmpty,
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Column(
                  children: [
                    Text(
                      'Validade',
                      style: formLabelTextStyle,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: TextFormField(
                        controller: _expirationController,
                        maxLength: 4,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        validator: _notEmpty,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Column(
                  children: [
                    Text(
                      'CVV',
                      style: formLabelTextStyle,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: TextFormField(
                        controller: _cvvController,
                        maxLength: 3,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        validator: _notEmpty,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'Essa transação é 100% segura e com certificados '
                  'de segurança que garantem a integridade dos seus dados.',
                  style: descriptionTextStyle,
                ),
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
                  Text('2 de 3'),
                  Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        creditCardViewModel.creditCard = CreditCard(
                            _numberController.text,
                            _nameController.text,
                            _expirationController.text,
                            _cvvController.text);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ConfirmationScreen(),
                          ),
                        );
                      }
                    },
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
