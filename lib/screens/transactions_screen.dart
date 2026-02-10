import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../theme/app_theme.dart';
import '../models/sample_data.dart';
import '../models/transaction_model.dart';
import '../widgets/transaction_tile.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  String _selectedFilter = 'All';
  final List<String> _filters = ['All', 'Income', 'Expense'];
  final currencyFormat = NumberFormat.currency(symbol: '\$', decimalDigits: 2);

  List<TransactionModel> get _filteredTransactions {
    if (_selectedFilter == 'Income') {
      return SampleData.transactions
          .where((t) => t.type == TransactionType.income)
          .toList();
    } else if (_selectedFilter == 'Expense') {
      return SampleData.transactions
          .where((t) => t.type == TransactionType.expense)
          .toList();
    }
    return SampleData.transactions;
  }

  void _showTransactionDetail(TransactionModel t) {
    final isIncome = t.type == TransactionType.income;
    final dateFormat = DateFormat('EEEE, MMMM dd, yyyy');

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(width: 40, height: 4, decoration: BoxDecoration(color: AppColors.divider, borderRadius: BorderRadius.circular(2))),
            const SizedBox(height: 20),
            Container(
              width: 60, height: 60,
              decoration: BoxDecoration(
                color: t.categoryColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(t.categoryIcon, color: t.categoryColor, size: 30),
            ),
            const SizedBox(height: 16),
            Text(t.title, style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
            const SizedBox(height: 8),
            Text(
              '${isIncome ? '+' : '-'}${currencyFormat.format(t.amount)}',
              style: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.bold, color: isIncome ? AppColors.income : AppColors.expense),
            ),
            const SizedBox(height: 20),
            _buildDetailRow('Category', t.category.name[0].toUpperCase() + t.category.name.substring(1)),
            _buildDetailRow('Type', isIncome ? 'Income' : 'Expense'),
            _buildDetailRow('Date', dateFormat.format(t.date)),
            _buildDetailRow('Description', t.description ?? 'No description'),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: GoogleFonts.poppins(fontSize: 13, color: AppColors.textSecondary)),
          Flexible(
            child: Text(value, style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.textPrimary), textAlign: TextAlign.end),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final totalIncome = SampleData.transactions
        .where((t) => t.type == TransactionType.income)
        .fold(0.0, (sum, t) => sum + t.amount);
    final totalExpense = SampleData.transactions
        .where((t) => t.type == TransactionType.expense)
        .fold(0.0, (sum, t) => sum + t.amount);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Transactions'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Summary header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1B5E20), Color(0xFF2E7D32)],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: _buildSummaryItem(
                    'Income',
                    currencyFormat.format(totalIncome),
                    Icons.arrow_downward,
                    AppColors.income,
                  ),
                ),
                Container(
                  height: 40,
                  width: 1,
                  color: Colors.white24,
                ),
                Expanded(
                  child: _buildSummaryItem(
                    'Expense',
                    currencyFormat.format(totalExpense),
                    Icons.arrow_upward,
                    AppColors.expense,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Filter chips
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: _filters.map((filter) {
                final isSelected = _selectedFilter == filter;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(
                      filter,
                      style: GoogleFonts.poppins(
                        color: isSelected ? Colors.white : AppColors.textPrimary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() => _selectedFilter = filter);
                    },
                    selectedColor: AppColors.primary,
                    backgroundColor: Colors.white,
                    checkmarkColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        color: isSelected ? AppColors.primary : AppColors.divider,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 8),

          // Transaction list
          Expanded(
            child: Card(
              margin: const EdgeInsets.all(16),
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: _filteredTransactions.length,
                itemBuilder: (context, index) {
                  final t = _filteredTransactions[index];
                  return TransactionTile(
                    transaction: t,
                    onTap: () => _showTransactionDetail(t),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(
      String label, String amount, IconData icon, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(height: 4),
        Text(
          label,
          style: GoogleFonts.poppins(
            color: Colors.white70,
            fontSize: 13,
          ),
        ),
        Text(
          amount,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
