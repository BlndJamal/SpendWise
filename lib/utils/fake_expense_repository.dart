import '../models/expense.dart';

class FakeExpenseRepository {
  final List<Expense> _items = [];

  void add(Expense expense) {
    _items.add(expense);
  }

  List<Expense> getAll() => List.unmodifiable(_items);

  void remove(int id) {
    _items.removeWhere((e) => e.id == id);
  }
}