import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:convert';

import 'package:crypto_diary/pages/text_input_field.dart';
import 'package:crypto_diary/pages/page_header.dart';

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
        const Align(
          alignment: Alignment.topCenter,
          child: PageHeader(
            title: 'Deposit',
            subtitle: 'Deposit your crypto assets',
          ),
        ),
        const Spacer(),
        Align(
          alignment: Alignment.center,
          child: Form(
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
                    items:
                        options.map<DropdownMenuItem<String>>((String value) {
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
                  onPressed: () async {
                    // Step 1: Extract the data from the text fields
                    final selectedCurrency = currencyValue;
                    final quantity = textFields[0].textController.text;
                    final price = textFields[1].textController.text;
                    final date = textFields[2].textController.text;

                    if (selectedCurrency != null &&
                        quantity.isNotEmpty &&
                        price.isNotEmpty &&
                        date.isNotEmpty) {
                      // Proceed to save the data

                      final transactionData = {
                        'currency': selectedCurrency,
                        'quantity': quantity,
                        'price': price,
                        'date': date,
                      };

                      print('Transaction Data: $transactionData');

                      final directory =
                          await getApplicationDocumentsDirectory();
                      print('Directory: ${directory.path}');
                      final folder =
                          Directory('${directory.path}/crypto_diary_data');

                      // Ensure the folder exists
                      if (!await folder.exists()) {
                        await folder.create(recursive: true);
                      }

                      final file =
                          File('${folder.path}/crypto_diary_local_data.json');

                      // Step 4: Write or Update the File
                      if (await file.exists()) {
                        // Read the existing data
                        final fileContent = await file.readAsString();
                        List<dynamic> existingData = json.decode(fileContent);

                        // Add the new transaction to the existing data
                        existingData.add(transactionData);

                        // Write the updated data back to the file
                        await file.writeAsString(json.encode(existingData));
                      } else {
                        // If the file doesn't exist, create it and add the new data
                        List<dynamic> newData = [transactionData];
                        await file.writeAsString(json.encode(newData));
                      }

                      print('Transaction saved successfully!');

                      // Clear the text fields
                      //_formGlobalKey.currentState!.reset();
                      for (final textField in textFields) {
                        textField.clearTextField();
                      }
                      setState(() {
                        currencyValue = null;
                      });
                    } else {
                      // Show an error message or handle the case
                      print('Please fill in all the fields!');
                    }
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
          ),
        ),
        const Spacer(
          flex: 2,
        ),
      ],
    );
  }
}
