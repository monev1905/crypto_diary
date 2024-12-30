import 'package:flutter/material.dart';
import 'package:crypto_diary/pages/text_input_field.dart';

class DepositPage extends StatefulWidget {
  const DepositPage({super.key});

  @override
  State<DepositPage> createState() => _DepositPageState();
}

class _DepositPageState extends State<DepositPage> {
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

  String? currencyValue;
  List<String> options = ['Bitcoin', 'Etherium', 'Cardano'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          key: _formGlobalKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 150, right: 150),
                child: DropdownButtonFormField<String>(
                  value: currencyValue,
                  hint: const Text('Currency'),
                  onChanged: (String? newValue) {
                    setState(() {
                      currencyValue = newValue;
                    });
                  },
                  items: options.map<DropdownMenuItem<String>>((String value) {
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
                    border: OutlineInputBorder(), // Border for the dropdown
                    labelText: 'Select Option', // Optional label
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              for (final textField in textFields) textField,
              const SizedBox(
                height: 40,
              ),
              FilledButton(
                onPressed: () {
                  //_formGlobalKey.currentState!.reset();
                  for (final textField in textFields) {
                    textField.clearTextField();
                  }
                  setState(() {
                    currencyValue = null;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[800],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                child: const Text("Deposit"),
              )
            ],
          ),
        )
      ],
    );
  }
}
