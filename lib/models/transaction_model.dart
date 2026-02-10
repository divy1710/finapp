import 'package:flutter/material.dart';

enum TransactionType { income, expense }

enum TransactionCategory {
  salary,
  freelance,
  investment,
  food,
  transport,
  shopping,
  entertainment,
  bills,
  healthcare,
  education,
  savings,
  transfer,
  other,
}

class TransactionModel {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final TransactionType type;
  final TransactionCategory category;
  final String? description;

  TransactionModel({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.type,
    required this.category,
    this.description,
  });

  IconData get categoryIcon {
    switch (category) {
      case TransactionCategory.salary:
        return Icons.work;
      case TransactionCategory.freelance:
        return Icons.laptop;
      case TransactionCategory.investment:
        return Icons.trending_up;
      case TransactionCategory.food:
        return Icons.restaurant;
      case TransactionCategory.transport:
        return Icons.directions_car;
      case TransactionCategory.shopping:
        return Icons.shopping_bag;
      case TransactionCategory.entertainment:
        return Icons.movie;
      case TransactionCategory.bills:
        return Icons.receipt_long;
      case TransactionCategory.healthcare:
        return Icons.local_hospital;
      case TransactionCategory.education:
        return Icons.school;
      case TransactionCategory.savings:
        return Icons.savings;
      case TransactionCategory.transfer:
        return Icons.swap_horiz;
      case TransactionCategory.other:
        return Icons.more_horiz;
    }
  }

  Color get categoryColor {
    switch (category) {
      case TransactionCategory.salary:
        return const Color(0xFF4CAF50);
      case TransactionCategory.freelance:
        return const Color(0xFF009688);
      case TransactionCategory.investment:
        return const Color(0xFFFF9800);
      case TransactionCategory.food:
        return const Color(0xFFE91E63);
      case TransactionCategory.transport:
        return const Color(0xFF3F51B5);
      case TransactionCategory.shopping:
        return const Color(0xFF9C27B0);
      case TransactionCategory.entertainment:
        return const Color(0xFFFF5722);
      case TransactionCategory.bills:
        return const Color(0xFF795548);
      case TransactionCategory.healthcare:
        return const Color(0xFFF44336);
      case TransactionCategory.education:
        return const Color(0xFF2196F3);
      case TransactionCategory.savings:
        return const Color(0xFF00BCD4);
      case TransactionCategory.transfer:
        return const Color(0xFF607D8B);
      case TransactionCategory.other:
        return const Color(0xFF9E9E9E);
    }
  }
}
