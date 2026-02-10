import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../theme/app_theme.dart';
import '../models/sample_data.dart';
import '../models/transaction_model.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  String _selectedPeriod = 'Monthly';
  final List<String> _periods = ['Weekly', 'Monthly', 'Yearly'];
  final currencyFormat = NumberFormat.currency(symbol: '\$', decimalDigits: 2);

  List<Map<String, dynamic>> get _periodData {
    switch (_selectedPeriod) {
      case 'Weekly':
        return [
          {'month': 'Mon', 'income': 900, 'expense': 420},
          {'month': 'Tue', 'income': 750, 'expense': 380},
          {'month': 'Wed', 'income': 1100, 'expense': 550},
          {'month': 'Thu', 'income': 600, 'expense': 310},
          {'month': 'Fri', 'income': 1350, 'expense': 720},
          {'month': 'Sat', 'income': 480, 'expense': 890},
          {'month': 'Sun', 'income': 320, 'expense': 650},
        ];
      case 'Yearly':
        return [
          {'month': '2021', 'income': 52000, 'expense': 38000},
          {'month': '2022', 'income': 58000, 'expense': 42000},
          {'month': '2023', 'income': 65000, 'expense': 45000},
          {'month': '2024', 'income': 72000, 'expense': 48000},
          {'month': '2025', 'income': 38500, 'expense': 25500},
        ];
      default:
        return SampleData.monthlyData;
    }
  }

  double get _maxChartValue {
    switch (_selectedPeriod) {
      case 'Weekly':
        return 1500.0;
      case 'Yearly':
        return 80000.0;
      default:
        return 7000.0;
    }
  }

  double get _totalIncome {
    return _periodData.fold(0.0, (sum, d) => sum + (d['income'] as int));
  }

  double get _totalExpense {
    return _periodData.fold(0.0, (sum, d) => sum + (d['expense'] as int));
  }

  List<Map<String, dynamic>> get _periodCategoryBreakdown {
    switch (_selectedPeriod) {
      case 'Weekly':
        return [
          {'name': 'Food & Dining', 'amount': 680.0, 'percentage': 32, 'color': 0xFFFF5252},
          {'name': 'Transport', 'amount': 320.0, 'percentage': 15, 'color': 0xFF448AFF},
          {'name': 'Shopping', 'amount': 540.0, 'percentage': 25, 'color': 0xFFFF9800},
          {'name': 'Entertainment', 'amount': 280.0, 'percentage': 13, 'color': 0xFF7C4DFF},
          {'name': 'Bills & Utilities', 'amount': 200.0, 'percentage': 10, 'color': 0xFF00BFA5},
          {'name': 'Healthcare', 'amount': 100.0, 'percentage': 5, 'color': 0xFFE91E63},
        ];
      case 'Yearly':
        return [
          {'name': 'Food & Dining', 'amount': 12500.0, 'percentage': 26, 'color': 0xFFFF5252},
          {'name': 'Transport', 'amount': 8200.0, 'percentage': 17, 'color': 0xFF448AFF},
          {'name': 'Shopping', 'amount': 7800.0, 'percentage': 16, 'color': 0xFFFF9800},
          {'name': 'Bills & Utilities', 'amount': 9600.0, 'percentage': 20, 'color': 0xFF00BFA5},
          {'name': 'Entertainment', 'amount': 5400.0, 'percentage': 11, 'color': 0xFF7C4DFF},
          {'name': 'Healthcare', 'amount': 5000.0, 'percentage': 10, 'color': 0xFFE91E63},
        ];
      default:
        return SampleData.categoryBreakdown;
    }
  }

  @override
  Widget build(BuildContext context) {
    final totalIncome = _totalIncome;
    final totalExpense = _totalExpense;
    final savings = totalIncome - totalExpense;
    final savingsRate = totalIncome > 0 ? (savings / totalIncome * 100) : 0.0;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 50, bottom: 24, left: 24, right: 24),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF1B5E20), Color(0xFF2E7D32), Color(0xFF388E3C)],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    'Analytics',
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Period selector
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: _periods.map((period) {
                        final isSelected = _selectedPeriod == period;
                        return Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => _selectedPeriod = period),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: isSelected ? Colors.white : Colors.transparent,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                period,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: isSelected ? AppColors.primary : Colors.white.withValues(alpha: 0.7),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Summary Cards
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: _buildSummaryCard(
                      'Total Income',
                      currencyFormat.format(totalIncome),
                      Icons.arrow_downward,
                      AppColors.income,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildSummaryCard(
                      'Total Expense',
                      currencyFormat.format(totalExpense),
                      Icons.arrow_upward,
                      AppColors.expense,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: _buildSummaryCard(
                      'Net Savings',
                      currencyFormat.format(savings),
                      Icons.savings,
                      AppColors.savings,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildSummaryCard(
                      'Savings Rate',
                      '${savingsRate.toStringAsFixed(1)}%',
                      Icons.percent,
                      AppColors.investment,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Income vs Expense Trend
            _buildSectionTitle('Income vs Expense'),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Card(
                elevation: 0,
                color: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 180,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: _periodData.map((data) {
                            final maxVal = _maxChartValue;
                            final incomeH = (data['income'] as int) / maxVal * 140;
                            final expenseH = (data['expense'] as int) / maxVal * 140;
                            return Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 3),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Container(
                                          width: 14,
                                          height: incomeH,
                                          decoration: BoxDecoration(
                                            color: AppColors.income,
                                            borderRadius: BorderRadius.circular(4),
                                          ),
                                        ),
                                        const SizedBox(width: 3),
                                        Container(
                                          width: 14,
                                          height: expenseH,
                                          decoration: BoxDecoration(
                                            color: AppColors.expense.withValues(alpha: 0.7),
                                            borderRadius: BorderRadius.circular(4),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      data['month'] as String,
                                      style: GoogleFonts.poppins(
                                        fontSize: 11,
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildLegend('Income', AppColors.income),
                          const SizedBox(width: 24),
                          _buildLegend('Expense', AppColors.expense),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Expense Breakdown
            _buildSectionTitle('Expense Breakdown'),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Card(
                elevation: 0,
                color: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      // Donut chart
                      SizedBox(
                        width: 180,
                        height: 180,
                        child: CustomPaint(
                          painter: _DonutChartPainter(
                            categories: _periodCategoryBreakdown,
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Total',
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                                Text(
                                  currencyFormat.format(totalExpense),
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Category list
                      ..._periodCategoryBreakdown.map((cat) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            children: [
                              Container(
                                width: 12,
                                height: 12,
                                decoration: BoxDecoration(
                                  color: Color(cat['color'] as int),
                                  borderRadius: BorderRadius.circular(3),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  cat['name'] as String,
                                  style: GoogleFonts.poppins(
                                    fontSize: 13,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                              ),
                              Text(
                                '${(cat['percentage'] as num).toInt()}%',
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                currencyFormat.format(cat['amount']),
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Savings Trend
            _buildSectionTitle(_selectedPeriod == 'Weekly' ? 'Daily Savings' : _selectedPeriod == 'Yearly' ? 'Yearly Savings' : 'Monthly Savings'),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Card(
                elevation: 0,
                color: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 140,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: _periodData.map((data) {
                            final saving = (data['income'] as int) - (data['expense'] as int);
                            final maxSaving = _selectedPeriod == 'Yearly' ? 30000.0 : _selectedPeriod == 'Weekly' ? 800.0 : 4500.0;
                            final barH = saving > 0 ? saving / maxSaving * 110 : 0.0;
                            final savingDisplay = _selectedPeriod == 'Yearly'
                                ? '\$${(saving / 1000).toStringAsFixed(0)}k'
                                : '\$${(saving / 1000).toStringAsFixed(1)}k';
                            return Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 6),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      savingDisplay,
                                      style: GoogleFonts.poppins(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: saving >= 0 ? AppColors.savings : AppColors.expense,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Container(
                                      width: 28,
                                      height: barH,
                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [Color(0xFF2196F3), Color(0xFF64B5F6)],
                                        ),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      data['month'] as String,
                                      style: GoogleFonts.poppins(
                                        fontSize: 11,
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Top Expenses
            _buildSectionTitle('Top Expenses'),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Card(
                elevation: 0,
                color: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Builder(
                  builder: (context) {
                    final expenses = SampleData.transactions
                        .where((t) => t.type == TransactionType.expense)
                        .toList()
                      ..sort((a, b) => b.amount.compareTo(a.amount));
                    return Column(
                      children: expenses.take(5).map((t) => ListTile(
                        leading: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: t.categoryColor.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(t.categoryIcon, color: t.categoryColor, size: 20),
                        ),
                        title: Text(
                          t.title,
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        subtitle: Text(
                          t.category.name[0].toUpperCase() + t.category.name.substring(1),
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        trailing: Text(
                          '-${currencyFormat.format(t.amount)}',
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.expense,
                          ),
                        ),
                      )).toList(),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(String label, String value, IconData icon, Color color) {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(height: 12),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }

  Widget _buildLegend(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textSecondary),
        ),
      ],
    );
  }
}

class _DonutChartPainter extends CustomPainter {
  final List<Map<String, dynamic>> categories;

  _DonutChartPainter({required this.categories});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    const strokeWidth = 28.0;
    final rect = Rect.fromCircle(center: center, radius: radius - strokeWidth / 2);

    double startAngle = -1.5708; // -pi/2 (start from top)
    for (final cat in categories) {
      final sweepAngle = (cat['percentage'] as num) / 100 * 6.2832; // 2*pi
      final paint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.butt
        ..color = Color(cat['color'] as int);
      canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
