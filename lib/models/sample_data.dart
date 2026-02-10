import 'transaction_model.dart';

class SampleData {
  static double get totalBalance => 24580.50;
  static double get totalIncome => 38500.00;
  static double get totalExpenses => 13919.50;
  static double get totalSavings => 8200.00;
  static double get totalInvestments => 5500.00;

  static List<Map<String, dynamic>> get monthlyData => [
    {'month': 'Jul', 'income': 6200, 'expense': 2800},
    {'month': 'Aug', 'income': 5800, 'expense': 3200},
    {'month': 'Sep', 'income': 6500, 'expense': 2400},
    {'month': 'Oct', 'income': 7000, 'expense': 2900},
    {'month': 'Nov', 'income': 6800, 'expense': 3100},
    {'month': 'Dec', 'income': 6200, 'expense': 2520},
  ];

  static List<Map<String, dynamic>> get categoryBreakdown => [
    {'name': 'Food & Dining', 'amount': 3200.0, 'percentage': 23.0, 'color': 0xFFE91E63},
    {'name': 'Transport', 'amount': 1800.0, 'percentage': 13.0, 'color': 0xFF3F51B5},
    {'name': 'Shopping', 'amount': 2500.0, 'percentage': 18.0, 'color': 0xFF9C27B0},
    {'name': 'Bills & Utilities', 'amount': 2800.0, 'percentage': 20.0, 'color': 0xFF795548},
    {'name': 'Entertainment', 'amount': 1200.0, 'percentage': 9.0, 'color': 0xFFFF5722},
    {'name': 'Healthcare', 'amount': 900.0, 'percentage': 6.0, 'color': 0xFFF44336},
    {'name': 'Others', 'amount': 1519.5, 'percentage': 11.0, 'color': 0xFF9E9E9E},
  ];

  static List<TransactionModel> get transactions => [
    TransactionModel(
      id: '1',
      title: 'Salary Deposit',
      amount: 6200.00,
      date: DateTime(2025, 2, 1),
      type: TransactionType.income,
      category: TransactionCategory.salary,
      description: 'Monthly salary from TechCorp',
    ),
    TransactionModel(
      id: '2',
      title: 'Grocery Shopping',
      amount: 185.50,
      date: DateTime(2025, 2, 2),
      type: TransactionType.expense,
      category: TransactionCategory.food,
      description: 'Weekly grocery shopping',
    ),
    TransactionModel(
      id: '3',
      title: 'Netflix Subscription',
      amount: 15.99,
      date: DateTime(2025, 2, 3),
      type: TransactionType.expense,
      category: TransactionCategory.entertainment,
    ),
    TransactionModel(
      id: '4',
      title: 'Freelance Payment',
      amount: 1200.00,
      date: DateTime(2025, 2, 4),
      type: TransactionType.income,
      category: TransactionCategory.freelance,
      description: 'UI design project',
    ),
    TransactionModel(
      id: '5',
      title: 'Electricity Bill',
      amount: 120.00,
      date: DateTime(2025, 2, 5),
      type: TransactionType.expense,
      category: TransactionCategory.bills,
    ),
    TransactionModel(
      id: '6',
      title: 'Uber Ride',
      amount: 24.50,
      date: DateTime(2025, 2, 5),
      type: TransactionType.expense,
      category: TransactionCategory.transport,
    ),
    TransactionModel(
      id: '7',
      title: 'Savings Transfer',
      amount: 500.00,
      date: DateTime(2025, 2, 6),
      type: TransactionType.expense,
      category: TransactionCategory.savings,
      description: 'Monthly savings deposit',
    ),
    TransactionModel(
      id: '8',
      title: 'Investment Return',
      amount: 320.00,
      date: DateTime(2025, 2, 7),
      type: TransactionType.income,
      category: TransactionCategory.investment,
      description: 'Stock dividends',
    ),
    TransactionModel(
      id: '9',
      title: 'Restaurant Dinner',
      amount: 85.00,
      date: DateTime(2025, 2, 8),
      type: TransactionType.expense,
      category: TransactionCategory.food,
    ),
    TransactionModel(
      id: '10',
      title: 'Online Course',
      amount: 49.99,
      date: DateTime(2025, 2, 8),
      type: TransactionType.expense,
      category: TransactionCategory.education,
      description: 'Flutter advanced course',
    ),
    TransactionModel(
      id: '11',
      title: 'Pharmacy',
      amount: 35.00,
      date: DateTime(2025, 2, 9),
      type: TransactionType.expense,
      category: TransactionCategory.healthcare,
    ),
    TransactionModel(
      id: '12',
      title: 'Clothing Store',
      amount: 220.00,
      date: DateTime(2025, 2, 9),
      type: TransactionType.expense,
      category: TransactionCategory.shopping,
    ),
  ];
}
