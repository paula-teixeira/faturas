import 'package:faturas/Manager/network_manager.dart';
import 'package:faturas/payment_options/model/payment_option/payment_option.dart';
import 'package:faturas/payment_options/model/payment_option/payment_options_model.dart';
import 'package:faturas/payment_options/view/payment_options_tile.dart';
import 'package:faturas/payment_options/view_model/payment_options.dart';
import 'package:faturas/screen/payment_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'payment_options_flow.mocks.dart';

List<PaymentOption> defaultPaymentOptions = [
  PaymentOption(1, 3180, 3180),
  PaymentOption(2, 1630, 3260),
  PaymentOption(3, 1086.67, 3260),
  PaymentOption(4, 815, 3260),
  PaymentOption(5, 662, 3310),
  PaymentOption(6, 551.67, 3310),
  PaymentOption(7, 472.86, 3310),
];

@GenerateMocks([NetworkManager])
main() {
  group('When Payment Options Screen is opened', () {
    setUpAll(() {
      final networkManager = MockNetworkManager();

      when(networkManager.getData())
          .thenAnswer((_) async => defaultPaymentOptions);

      GetIt.instance.registerSingleton<NetworkManager>(networkManager);
    });

    testWidgets('Should open payment option screen', (tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<PaymentOptionsModel>(
              create: (_) => PaymentOptionsModel(),
            ),
            ProxyProvider<PaymentOptionsModel, PaymentOptionsViewModel>(
              create: (context) => PaymentOptionsViewModel(
                  paymentOptionsModel: context.read<PaymentOptionsModel>()),
              update: (context, paymentOptionsModel, notifier) =>
                  PaymentOptionsViewModel(
                      paymentOptionsModel: paymentOptionsModel),
            ),
          ],
          child: MaterialApp(
            home: PaymentOptionsWidget(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Escolha o número de parcelas:'), findsOneWidget);
    });

    testWidgets('Should select correct operation tax', (tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<PaymentOptionsModel>(
              create: (_) => PaymentOptionsModel(),
            ),
            ProxyProvider<PaymentOptionsModel, PaymentOptionsViewModel>(
              create: (context) => PaymentOptionsViewModel(
                  paymentOptionsModel: context.read<PaymentOptionsModel>()),
              update: (context, paymentOptionsModel, notifier) =>
                  PaymentOptionsViewModel(
                      paymentOptionsModel: paymentOptionsModel),
            ),
          ],
          child: MaterialApp(
            home: PaymentOptionsWidget(),
          ),
        ),
      );
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
