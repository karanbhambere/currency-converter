import 'dart:developer';

import 'package:currency_app/currency_list_screen.dart';
import 'package:flutter/material.dart';

class CurrencyConverterScreen extends StatefulWidget {
  final List<Map<String, dynamic>> currencyDataList;
  const CurrencyConverterScreen({
    super.key,
    required this.currencyDataList,
  });

  @override
  State<CurrencyConverterScreen> createState() =>
      _CurrencyConverterScreenState();
}

class _CurrencyConverterScreenState extends State<CurrencyConverterScreen> {
  List<DropdownMenuItem>? _dropDownMenuItemList;
  String selectedCurrency = 'USD';
  String convertedCurrency = '0.0';
  final TextEditingController _CurrencyTextEditingController =
      TextEditingController();
  @override
  void initState() {
    super.initState();
    _dropDownMenuItemList = widget.currencyDataList
        .map((e) => DropdownMenuItem(
              key: Key(e['currency']),
              value: e['currency'].toString(),
              child: Text(e['currency']),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    log(widget.currencyDataList.toString());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Currency converter',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => CurrencyListScreen(
                        currencyDataList: widget.currencyDataList),
                  ),
                );
              },
              icon: const Icon(
                Icons.attach_money_rounded,
                color: Colors.white,
              ))
        ],
      ),
      backgroundColor: Colors.blue.withOpacity(0.5),
      body: Column(
        children: [
          // const TextField(
          //   cursorColor: Colors.white,
          //   keyboardType: TextInputType.numberWithOptions(decimal: true),
          // ),
          // const SizedBox(

          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                'INR',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 100,
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    controller: _CurrencyTextEditingController,
                    decoration: InputDecoration(
                      enabled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.white)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.white)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Colors.white, width: 2)),
                    ),
                  ),
                ),
              ),
              DropdownButton(
                dropdownColor: Colors.blue,
                underline: Container(),
                iconEnabledColor: Colors.white,
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
                value: selectedCurrency,
                items: _dropDownMenuItemList!,
                onChanged: (value) {
                  setState(() {
                    selectedCurrency = value;
                  });
                },
              ),
              Container(
                height: 40,
                width: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.white, width: 2)),
                child: Center(
                  child: Text(
                    convertedCurrency,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              height: 50,
              width: 200,
              child: ElevatedButton(
                  onPressed: () {
                    converttedCurrency();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.blue),
                  child: const Text('Convert')),
            ),
          )
        ],
      ),
    );
  }

  void converttedCurrency() {
    if (_CurrencyTextEditingController.text.isEmpty) {
      return;
    }
    final selectedCurrencyRate = widget.currencyDataList
        .firstWhere((element) => element['currency'] == selectedCurrency);
    final inputCurrency = num.parse(_CurrencyTextEditingController.text);
    convertedCurrency =
        (inputCurrency * selectedCurrencyRate['rate']).toStringAsFixed(2);
    setState(() {});
  }
}
