import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:convert';

import 'package:crypto_diary/views/widgets/text_input_field_widget.dart';
import 'package:crypto_diary/views/widgets/page_header_widget.dart';
import 'package:crypto_diary/views/widgets/transaction_button_widget.dart';

import 'package:crypto_diary/data/classes/transaction_class.dart';

class TransactionFormPage extends StatefulWidget {
  final String transactionType;

  const TransactionFormPage({
    super.key,
    required this.transactionType,
  });

  @override
  State<TransactionFormPage> createState() => _TransactionFormPageState();
}

class _TransactionFormPageState extends State<TransactionFormPage> {
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

  saveDepositTransactionToFile(File file, Transaction transaction) async {
    Map<String, dynamic> data = {};
    if (await file.exists()) {
      final fileContent = await file.readAsString();
      data = json.decode(fileContent);
    }

    data.putIfAbsent("deposit_transactions", () => []);
    (data["deposit_transactions"] as List).add(transaction);

    await file.writeAsString(json.encode(data));
  }

  saveWithdrawTransactionToFile(File file, Transaction transaction) async {
    Map<String, dynamic> data = {};
    if (await file.exists()) {
      final fileContent = await file.readAsString();
      data = json.decode(fileContent);
    }

    data.putIfAbsent("withdraw_transactions", () => []);
    (data["withdraw_transactions"] as List).add(transaction);

    await file.writeAsString(json.encode(data));
  }

  void recalculateTotalBalance(File file) async {
    Map<String, dynamic> data = {};

    if (file.existsSync()) {
      final fileContent = file.readAsStringSync();
      data = json.decode(fileContent);
    }

    final List<dynamic> depositTransactions =
        data["deposit_transactions"] ?? [];
    final List<dynamic> withdrawTransactions =
        data["withdraw_transactions"] ?? [];

    // Map to store the balance of each coin
    Map<String, double> totalBalance = {};

    // Process deposits
    for (var transaction in depositTransactions) {
      String coinName = transaction["coinName"];
      double amount = (transaction["amount"] ?? 0).toDouble();

      totalBalance[coinName] = (totalBalance[coinName] ?? 0) + amount;
    }

    // Process withdrawals
    for (var transaction in withdrawTransactions) {
      String coinName = transaction["coinName"];
      double amount = (transaction["amount"] ?? 0).toDouble();

      totalBalance[coinName] = (totalBalance[coinName] ?? 0) - amount;
    }

    data.putIfAbsent("total_balance", () => <String, double>{});
    data["total_balance"] = totalBalance;

    await file.writeAsString(json.encode(data));
  }

  Future<void> saveTransactionToFile(
    String transactionType,
    Transaction transaction,
  ) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final folder = Directory('${directory.path}/crypto_diary_data');

      if (!await folder.exists()) {
        await folder.create(recursive: true);
      }

      final file = File('${folder.path}/crypto_diary_local_data.json');

      if (transactionType == "Deposit") {
        await saveDepositTransactionToFile(file, transaction);
      } else {
        await saveWithdrawTransactionToFile(file, transaction);
      }

      // Recalculate the total amount (balance) of the user
      recalculateTotalBalance(file);
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

  void handleTransaction(transactionType) async {
    if (!validateForm()) {
      log('Please fill in all the fields!');
      return;
    }

    final transaction = buildTransaction();

    await saveTransactionToFile(transactionType, transaction);

    // Clear the form fields
    clearFormFields();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          PageHeaderWidget(
            title: widget.transactionType,
            subtitle: '${widget.transactionType} your crypto assets',
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
                    buttonText: widget.transactionType,
                    onPressed: () => handleTransaction(widget.transactionType),
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
