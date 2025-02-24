import 'dart:convert';
import 'dart:io';

import 'package:crypto_diary/views/widgets/page_header_widget.dart';
import 'package:crypto_diary/views/widgets/balance_widget.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class BalancePage extends StatefulWidget {
  const BalancePage({super.key});

  @override
  State<BalancePage> createState() => _BalancePageState();
}

class _BalancePageState extends State<BalancePage> {
  Map<String, dynamic>? transactionsData;

  @override
  void initState() {
    super.initState();
    loadTransactions();
  }

  Future<void> loadTransactions() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final folder = Directory('${directory.path}/crypto_diary_data');

      if (!await folder.exists()) {
        throw Exception('No transactions found. Please add a transaction.');
      }

      final file = File('${folder.path}/crypto_diary_local_data.json');

      if (await file.exists()) {
        final jsonString = await file.readAsString();
        final jsonData = json.decode(jsonString);

        setState(() {
          transactionsData = jsonData; // Store full transaction data
        });
      }
    } catch (e) {
      debugPrint('Error loading transactions: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const PageHeaderWidget(
            title: "Crypto balance",
            subtitle: '',
          ),
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if (transactionsData == null)
                  const Center(
                    child: CircularProgressIndicator(),
                  )
                else
                  BalanceWidget(
                    transactionsData: transactionsData,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
