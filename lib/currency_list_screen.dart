import 'package:flutter/material.dart';

class CurrencyListScreen extends StatelessWidget {
  const CurrencyListScreen({super.key, required this.currencyDataList});
  final List<Map<String, dynamic>> currencyDataList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.blue,
        title: const Text(
          'Currency List',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView.builder(
          itemCount: currencyDataList.length,
          itemBuilder: (context, index) {
            final item = currencyDataList[index];
            return ListTile(
              leading: const Icon(
                Icons.attach_money,
                color: Colors.white,
              ),
              title: Text(
                '${item['currency']}',
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
              subtitle: Text("${item['currency']} ${item['rate']}"),
            );
          }),
    );
  }
}
