import 'dart:convert';
import 'dart:developer';

import 'package:currency_app/contant.dart';
import 'package:currency_app/currency_converter_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<SplashScreen> {
  get response => null;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      getCurrencyRates();
    });
  }

  List<Map<String, dynamic>> currencyData = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/currency_logo.png'),
            const Padding(padding: EdgeInsets.all(20.0)),
            const Text(
              'Currency Converter',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
            const CircularProgressIndicator(
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }

  Future getCurrencyRates() async {
    try {
      const currencyUrl =
          'https://api.freecurrencyapi.com/v1/latest?apikey=$currencyAPI&base_currency=INR';
      final currencyUri = Uri.parse(currencyUrl);
      await http.get(currencyUri).then((response) {
        if (response.statusCode == 200) {
          final currencyData = json.decode(response.body);
          List<Map<String, dynamic>> currencyDataList = [];
          (currencyData['data'] as Map).forEach((key, value) {
            currencyDataList.add({
              'currency': key,
              'rate': value,
            });
          });
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (_) => CurrencyConverterScreen(
                      currencyDataList: currencyDataList)),
              (route) => false);
        }
      });
    } catch (e) {
      log(e.toString());
    }
  }
}
