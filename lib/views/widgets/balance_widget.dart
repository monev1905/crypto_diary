import 'package:flutter/material.dart';

class BalanceWidget extends StatelessWidget {
  final Map<String, dynamic>? transactionsData;

  const BalanceWidget({
    super.key,
    this.transactionsData,
  });

  Map<String, dynamic> get totalBalance =>
      transactionsData?["total_balance"] ?? {};

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...totalBalance.entries.map((entry) {
          return ListTile(
            title: Text(entry.key),
            trailing: Text(entry.value.toString()),
          );
        }).toList(),
      ],
    );
  }
}
