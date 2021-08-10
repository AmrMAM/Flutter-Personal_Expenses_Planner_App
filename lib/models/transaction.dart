class Transaction {
  final String id;
  final String name;
  final double amount;
  final DateTime date;

  Transaction({
    required this.amount,
    required this.id,
    required this.date,
    required this.name,
  });
  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
        amount: json['c'], id: json['a'], date: json['d'], name: json['b']);
  }
  Map<String, dynamic> toJson() => {
        'a': id,
        'b': name,
        'c': amount,
        'd': date,
      };
}
