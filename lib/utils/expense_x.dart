import '../models/category.dart';
import '../models/expense.dart';

extension ExpenseListX on List<Expense> {
  // Sum of all amounts
  double get total => fold(0.0, (sum, e) => sum + e.amount);

  // Total per category
  Map<Category, double> get totalsByCategory {
    final result = <Category, double>{};
    for (final e in this) {
      result[e.category] = (result[e.category] ?? 0) + e.amount;
    }
    return result;
  }

  // Only expenses from one month
  List<Expense> inMonth(int year, int month) {
    return where((e) => e.date.year == year && e.date.month == month)
        .toList();
  }

  // Category with the highest total (null if the list is empty)
  Category? get topCategory {
    final totals = totalsByCategory;
    if (totals.isEmpty) return null;

    Category? best;
    double bestValue = -1;
    totals.forEach((cat, value) {
      if (value > bestValue) {
        bestValue = value;
        best = cat;
      }
    });
    return best;
  }
}