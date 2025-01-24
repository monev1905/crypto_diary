import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:convert';

import 'package:crypto_diary/views/widgets/text_input_field_widget.dart';
import 'package:crypto_diary/views/widgets/page_header_widget.dart';
import 'package:crypto_diary/views/widgets/transaction_button_widget.dart';

class DepositPage extends StatefulWidget {
  const DepositPage({super.key});

  @override
  State<DepositPage> createState() => _DepositPageState();
}

class Transaction {
  final String coinName;
  final String? symbol;
  final double amount;
  final double price;
  final DateTime date;

  Transaction({
    required this.coinName,
    this.symbol,
    required this.amount,
    required this.price,
    required this.date,
  });

  Map<String, dynamic> toJson() {
    return {
      'coinName': coinName,
      'symbol': symbol,
      'amount': amount,
      'price': price,
      'date': date.toIso8601String(),
    };
  }
}

class _DepositPageState extends State<DepositPage> {
  final _formGlobalKey = GlobalKey<FormState>();
  String? currencyValue;
  List<String> options = [
    'Bitcoin',
    'Etherium',
    'Cardano'
  ]; // TODO: Dummy data for now

  List<TextInputFieldWidget> textFields = [
    TextInputFieldWidget(
      label: "Quantity",
      textController: TextEditingController(),
    ),
    TextInputFieldWidget(
      label: "Price",
      textController: TextEditingController(),
    ),
    TextInputFieldWidget(
      label: "Date",
      textController: TextEditingController(),
    ),
  ];

  bool validateForm() {
    return currencyValue != null &&
        textFields.every((field) => field.textController.text.isNotEmpty);
  }

  Transaction buildTransaction() {
    return Transaction(
      coinName: currencyValue!,
      symbol: null,
      amount: double.parse(textFields[0].textController.text),
      price: double.parse(textFields[1].textController.text),
      date: DateTime.parse(textFields[2].textController.text),
    );
  }

  Future<void> saveTransactionToFile(Transaction transaction) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final folder = Directory('${directory.path}/crypto_diary_data');

      // Ensure the folder exists
      if (!await folder.exists()) {
        await folder.create(recursive: true);
      }

      final file = File('${folder.path}/crypto_diary_local_data.json');

      Map<String, dynamic> data = {};
      if (await file.exists()) {
        final fileContent = await file.readAsString();
        data = json.decode(fileContent);
      }

      data.putIfAbsent("deposit_transactions", () => []);
      (data["deposit_transactions"] as List).add(transaction);

      await file.writeAsString(json.encode(data));
    } catch (e) {
      log(e.toString());
    }
  }

  void clearFormFields() {
    for (final textField in textFields) {
      textField.textController.clear();
    }
    setState(() {
      currencyValue = null;
    });
  }

  void handleDeposit() async {
    if (!validateForm()) {
      log('Please fill in all the fields!');
      return;
    }

    final transaction = buildTransaction();

    await saveTransactionToFile(transaction);

    log('Transaction saved successfully!');
    clearFormFields();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const PageHeaderWidget(
            title: 'Deposit',
            subtitle: 'Deposit your crypto assets',
          ),
          const SizedBox(
            height: 40,
          ),
          Form(
            key: _formGlobalKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  DropdownButtonFormField<String>(
                    value: currencyValue,
                    hint: const Text('Currency'),
                    onChanged: (String? newValue) {
                      setState(() {
                        currencyValue = newValue;
                      });
                    },
                    items:
                        options.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(
                            fontSize: 16,
                            //color: Colors.white,
                          ),
                        ),
                      );
                    }).toList(),
                    decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      border: OutlineInputBorder(), // Border for the dropdown
                      labelText: 'Select Option', // Optional label
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  for (final textField in textFields) textField,
                  const SizedBox(
                    height: 40,
                  ),
                  TransactionActionButton(
                    buttonText: 'Deposit',
                    onPressed: handleDeposit,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
