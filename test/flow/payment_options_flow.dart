import 'package:faturas/payment_options/view/payment_options_tile.dart';
import 'package:faturas/screen/payment_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  group('When Payment Options Screen is opened', () {
    testWidgets('Should open payment option screen', (tester) async {
      await tester.pumpWidget(MaterialApp(home: PaymentOptionsScreen(),),);

      await tester.pumpAndSettle();

      expect(find.text('Escolha o número de parcelas:'), findsOneWidget);
    });
    
    testWidgets('Should select correct operation tax', (tester) async {
      await tester.pumpWidget(MaterialApp(home: PaymentOptionsScreen(),));

      await tester.pumpAndSettle();

      final selectedPaymentOption = find.byWidgetPredicate((widget) {
        if (widget is PaymentOptionsTile) {
          return widget.paymentOption.number == 2;
        } else {
          return false;
        }
      });
      expect(selectedPaymentOption, findsOneWidget);

      await tester.tap(selectedPaymentOption);
      await tester.pumpAndSettle();

      final operationTax = find.byKey(Key('operationTax'));
      expect(operationTax, findsOneWidget);
      expect(operationTax.toString().contains("234.51"), true);
    });
  });
}
