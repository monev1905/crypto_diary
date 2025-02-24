final class Transaction {
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
