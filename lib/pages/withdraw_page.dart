import 'package:flutter/material.dart';

import 'package:crypto_diary/pages/text_input_field.dart';
import 'package:crypto_diary/pages/page_header.dart';
import 'package:crypto_diary/pages/transaction_button.dart';

class WithdrawPage extends StatefulWidget {
  const WithdrawPage({super.key});

  @override
  State<WithdrawPage> createState() => _WithdrawPageState();
}

class _WithdrawPageState extends State<WithdrawPage> {
  final _formGlobalKey = GlobalKey<FormState>();

  List<TextInputField> textFields = [
    TextInputField(
      label: "Quantity",
      textController: TextEditingController(),
    ),
    TextInputField(
      label: "Price",
      textController: TextEditingController(),
    ),
    TextInputField(
      label: "Date",
      textController: TextEditingController(),
    ),
  ];
  List<String> options = ['Bitcoin', 'Etherium', 'Cardano'];
  String? currencyValue;

  void handleWithdraw() async {
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Align(
          alignment: Alignment.topCenter,
          child: PageHeader(
            title: 'Withdraw',
            subtitle: 'Withdraw your crypto assets',
          ),
        ),
        const Spacer(),
        Align(
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              Form(
                key: _formGlobalKey,
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
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
                        items: options
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black, // Customize text color
                              ),
                            ),
                          );
                        }).toList(),
                        decoration: const InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          border:
                              OutlineInputBorder(), // Border for the dropdown
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
                        buttonText: 'Withdraw',
                        onPressed: handleWithdraw,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        const Spacer(flex: 2),
      ],
    );
  }
}
