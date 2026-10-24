import 'category.dart';

class Expense {
  final int id;
  final String title;
  final double amount;
  final Category category;
  final DateTime date;

  const Expense({
    required this.id,
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
  });

  // Returns a copy with only the given fields changed
  Expense copyWith({
    int? id,
    String? title,
    double? amount,
    Category? category,
    DateTime? date,
  }) {
    return Expense(
      id: id ?? this.id,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      category: category ?? this.category,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'category': category.name,
      'date': date.toIso8601String(),
    };
  }

  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      id: map['id'] as int,
      title: map['title'] as String,
      amount: (map['amount'] as num).toDouble(),
      category: Category.values.byName(map['category'] as String),
      date: DateTime.parse(map['date'] as String),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Expense &&
        other.id == id &&
        other.title == title &&
        other.amount == amount &&
        other.category == category &&
        other.date == date;
  }

  @override
  int get hashCode => Object.hash(id, title, amount, category, date);

  @override
  String toString() =>
      'Expense($id, $title, ${amount.toStringAsFixed(2)}, ${category.label})';
}