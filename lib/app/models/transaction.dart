class TransactionModel {
  final double amount;
  final DateTime? date;

  TransactionModel({required this.amount, required this.date});

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'date': date?.toIso8601String(),
    };
  }

  static TransactionModel fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      amount: json['amount'],
      date: json['date'] != null
          ? DateTime.parse(json['date'])
          : null, // Handle null date
    );
  }
}
