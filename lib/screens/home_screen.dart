import 'package:flutter/material.dart';
import 'package:currency_calculator/common/utils.dart' as utils;
import 'package:currency_calculator/widgets/custom_text_field.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final realController = TextEditingController();
  final dolarController = TextEditingController();
  final euroController = TextEditingController();

  double dolarValue = 0;
  double euroValue = 0;

  void _realCurrency(String text) {
    if (text.isEmpty) {
      _clearAllFields();
      return;
    }
    double real = double.parse(text);
    dolarController.text = (real / dolarValue).toStringAsFixed(2);
    euroController.text = (real / euroValue).toStringAsFixed(2);
  }

  void _dolarCurrency(String text) {
    if (text.isEmpty) {
      _clearAllFields();
      return;
    }
    double dolar = double.parse(text);
    realController.text = (dolar * dolarValue).toStringAsFixed(2);
    euroController.text = (dolar * dolarValue / euroValue).toStringAsFixed(2);
  }

  void _euroCurrency(String text) {
    if (text.isEmpty) {
      _clearAllFields();
      return;
    }
    double euro = double.parse(text);
    realController.text = (euro * euroValue).toStringAsFixed(2);
    dolarController.text = (euro * euroValue / dolarValue).toStringAsFixed(2);
  }

  void _clearAllFields() {
    realController.text = "";
    dolarController.text = "";
    euroController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[600],
      appBar: AppBar(
        title: const Text('Conversor'),
        centerTitle: true,
        backgroundColor: Colors.blue[900],
      ),
      body: FutureBuilder<Map>(
        future: utils.getApiData(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.active:
            case ConnectionState.waiting:
              return const Center(
                  child: Text(
                "Carregando dados...",
                style: TextStyle(color: Colors.white, fontSize: 25.0),
                textAlign: TextAlign.center,
              ));
            default:
              if (snapshot.hasError) {
                return const Center(
                    child: Text(
                  "Erro ao carregar dados...",
                  style: TextStyle(color: Colors.white, fontSize: 25.0),
                  textAlign: TextAlign.center,
                ));
              } else {
                dolarValue = snapshot.data!["results"]["currencies"]["USD"]["buy"];
                euroValue = snapshot.data!["results"]["currencies"]["EUR"]["buy"];

                return SingleChildScrollView(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      const Icon(Icons.monetization_on, size: 150.0, color: Colors.white),
                      customTextFormField(realController, "Reais", "R\$", _realCurrency),
                      const Divider(),
                      customTextFormField(dolarController, "Dólar", "US\$", _dolarCurrency),
                      const Divider(),
                      customTextFormField(euroController, "Euro", "EUR", _euroCurrency),
                    ],
                  ),
                );
              }
          }
        },
      ),
    );
  }
}
