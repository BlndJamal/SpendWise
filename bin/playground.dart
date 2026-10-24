import 'package:spendwise/utils/fake_expense_repository.dart';
import 'package:spendwise/models/category.dart';
import 'package:spendwise/models/expense.dart';
import 'package:spendwise/utils/expense_x.dart';


// ignore_for_file: avoid_print
void main() {
  final repo = FakeExpenseRepository();

  repo.add(Expense(
      id: 1, title: 'Lunch at campus', amount: 8.5,
      category: Category.food, date: DateTime(2026, 10, 5)));
  repo.add(Expense(
      id: 2, title: 'Taxi home', amount: 4.0,
      category: Category.transport, date: DateTime(2026, 10, 5)));
  repo.add(Expense(
      id: 3, title: 'Dinner', amount: 12.0,
      category: Category.food, date: DateTime(2026, 10, 12)));
  repo.add(Expense(
      id: 4, title: 'Electricity', amount: 35.0,
      category: Category.bills, date: DateTime(2026, 9, 28)));

  final all = repo.getAll();

  print('--- All expenses ---');
  for (final e in all) {
    print(e);
  }

  print('\nTotal: ${all.total.toStringAsFixed(2)}');

  print('\n--- Totals by category ---');
  all.totalsByCategory.forEach((cat, value) {
    print('${cat.label}: ${value.toStringAsFixed(2)}');
  });

  print('\nTop category: ${all.topCategory?.label}');

  print('\n--- October 2026 ---');
  for (final e in all.inMonth(2026, 10)) {
    print(e);
  }

  print('\n--- copyWith, toMap, fromMap ---');
  final changed = all.first.copyWith(title: 'Late lunch', amount: 9.0);
  print(changed);
  final map = changed.toMap();
  print(map);
  print('Round trip equal: ${Expense.fromMap(map) == changed}');
}