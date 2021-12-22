import 'package:faturas/components/components.dart';
import 'package:faturas/screen/payment_options.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sistema de Faturas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Última fatura',
                  style: titleTextStyle,
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'R\$ 3.025,49',
                          style: titleTextStyle,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Vencimento 08/07/2019',
                          style: subtitleTextStyle,
                        ),
                      ],
                    ),
                    Text(
                      'Vencida',
                      style: alertTextStyle,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  color: Colors.black,
                  thickness: 0.2,
                ),
                Text(
                  'Formas de Pagamento',
                  style: titleTextStyle,
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  'Boleto Bancário',
                  style: subtitleTextStyle,
                ),
                OutlinedButton(
                  onPressed: () => _exibirDialogo(context),
                  child: Text('Copiar código de barras do boleto'),
                ),
                OutlinedButton(
                  onPressed: () => _exibirDialogo(context),
                  child: Text('Enviar boleto por e-mail'),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  'Cartão de Crédito',
                  style: subtitleTextStyle,
                ),
                OutlinedButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (builder) => PaymentOptionsScreen(),
                    ),
                  ),
                  child: Text('Pagar com cartão de crédito'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _exibirDialogo(context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Erro'),
        content: Text('Conteúdo não implementado.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}
