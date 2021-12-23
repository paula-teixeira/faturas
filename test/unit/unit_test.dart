import 'package:flutter_test/flutter_test.dart';
import 'package:faturas/main.dart';

void main() {
  testWidgets('Should find home screen', (tester) async {
    await tester.pumpWidget(Faturas());

    expect(find.text('Última fatura'), findsOneWidget);
    expect(find.text('R\$ 3.025,49'), findsOneWidget);
    expect(find.text('Vencimento 08/07/2019'), findsOneWidget);
    expect(find.text('Vencida'), findsOneWidget);
    expect(find.text('Formas de Pagamento'), findsOneWidget);
    expect(find.text('Boleto Bancário'), findsOneWidget);
    expect(find.text('Cartão de Crédito'), findsOneWidget);
  });
}
