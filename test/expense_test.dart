import 'package:flutter_test/flutter_test.dart';
import 'package:spendwise/models/category.dart';
import 'package:spendwise/models/expense.dart';
import 'package:spendwise/utils/expense_x.dart';

void main() {
  final lunch = Expense(
      id: 1, title: 'Lunch', amount: 8.5,
      category: Category.food, date: DateTime(2026, 10, 5));
  final taxi = Expense(
      id: 2, title: 'Taxi', amount: 4.0,
      category: Category.transport, date: DateTime(2026, 10, 6));
  final dinner = Expense(
      id: 3, title: 'Dinner', amount: 12.0,
      category: Category.food, date: DateTime(2026, 9, 20));
  final list = [lunch, taxi, dinner];

  test('copyWith changes only the given field', () {
    final c = lunch.copyWith(title: 'Brunch');
    expect(c.title, 'Brunch');
    expect(c.amount, 8.5);
    expect(c.id, 1);
  });

  test('toMap and fromMap round trip', () {
    expect(Expense.fromMap(lunch.toMap()), lunch);
  });

  test('== is true for same values', () {
    final same = lunch.copyWith();
    expect(same == lunch, true);
    expect(same.hashCode, lunch.hashCode);
  });

  test('== is false for different values', () {
    expect(lunch == taxi, false);
  });

  test('total adds all amounts', () {
    expect(list.total, 24.5);
  });

  test('totalsByCategory groups correctly', () {
    final totals = list.totalsByCategory;
    expect(totals[Category.food], 20.5);
    expect(totals[Category.transport], 4.0);
  });

  test('topCategory returns the biggest category', () {
    expect(list.topCategory, Category.food);
  });

  test('topCategory is null for an empty list', () {
    expect(<Expense>[].topCategory, null);
  });

  test('inMonth filters by year and month', () {
    final october = list.inMonth(2026, 10);
    expect(october.length, 2);
    expect(october.contains(dinner), false);
  });
}