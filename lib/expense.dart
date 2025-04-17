class Expense {
  final String title;      // Title of the expense
  final String category;   // Category of the expense (e.g., Food, Bills)
  final double amount;     // Amount of money spent
  final DateTime date;     // Date of the expense
  final bool isShared;     // Whether the expense is shared or not

  // Constructor to initialize the properties of Expense
  Expense({
    required this.title,
    required this.category,
    required this.amount,
    required this.date,
    required this.isShared,
  });

  // Method to convert Expense object to JSON format (useful for saving data)
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'category': category,
      'amount': amount,
      'date': date.toIso8601String(),
      'isShared': isShared,
    };
  }

  // Method to create Expense object from JSON (useful for fetching data)
  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      title: map['title'],
      category: map['category'],
      amount: map['amount'],
      date: DateTime.parse(map['date']),
      isShared: map['isShared'],
    );
  }

  // String representation of the Expense object for easier debugging
  @override
  String toString() {
    return 'Expense(title: $title, category: $category, amount: $amount, date: $date, isShared: $isShared)';
  }
}
