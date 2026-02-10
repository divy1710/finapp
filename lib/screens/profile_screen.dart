import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../theme/app_theme.dart';
import '../models/sample_data.dart';
import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _userName = 'Divy K.';
  String _userEmail = 'divy.k@email.com';
  String _currency = 'USD (\$)';
  String _language = 'English';
  bool _darkMode = false;
  bool _pushNotifications = true;
  bool _emailNotifications = false;
  bool _smsNotifications = false;

  void _showEditProfile() {
    final nameController = TextEditingController(text: _userName);
    final emailController = TextEditingController(text: _userEmail);

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Edit Profile', style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 18)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              style: GoogleFonts.poppins(fontSize: 14),
              decoration: InputDecoration(
                labelText: 'Name',
                labelStyle: GoogleFonts.poppins(fontSize: 13, color: AppColors.textSecondary),
                prefixIcon: const Icon(Icons.person_outline, size: 20),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: emailController,
              style: GoogleFonts.poppins(fontSize: 14),
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: GoogleFonts.poppins(fontSize: 13, color: AppColors.textSecondary),
                prefixIcon: const Icon(Icons.email_outlined, size: 20),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: Text('Cancel', style: GoogleFonts.poppins(color: AppColors.textSecondary))),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _userName = nameController.text;
                _userEmail = emailController.text;
              });
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Profile updated!', style: GoogleFonts.poppins(fontSize: 13)),
                backgroundColor: AppColors.primary,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ));
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
            child: Text('Save', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  void _showChangePassword() {
    final currentController = TextEditingController();
    final newController = TextEditingController();
    final confirmController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Change Password', style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 18)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: currentController,
              obscureText: true,
              style: GoogleFonts.poppins(fontSize: 14),
              decoration: InputDecoration(
                labelText: 'Current Password',
                labelStyle: GoogleFonts.poppins(fontSize: 13, color: AppColors.textSecondary),
                prefixIcon: const Icon(Icons.lock_outline, size: 20),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: newController,
              obscureText: true,
              style: GoogleFonts.poppins(fontSize: 14),
              decoration: InputDecoration(
                labelText: 'New Password',
                labelStyle: GoogleFonts.poppins(fontSize: 13, color: AppColors.textSecondary),
                prefixIcon: const Icon(Icons.lock, size: 20),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: confirmController,
              obscureText: true,
              style: GoogleFonts.poppins(fontSize: 14),
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                labelStyle: GoogleFonts.poppins(fontSize: 13, color: AppColors.textSecondary),
                prefixIcon: const Icon(Icons.lock, size: 20),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: Text('Cancel', style: GoogleFonts.poppins(color: AppColors.textSecondary))),
          ElevatedButton(
            onPressed: () {
              if (newController.text != confirmController.text) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Passwords do not match!', style: GoogleFonts.poppins(fontSize: 13)),
                  backgroundColor: AppColors.expense,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ));
                return;
              }
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Password changed successfully!', style: GoogleFonts.poppins(fontSize: 13)),
                backgroundColor: AppColors.primary,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ));
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
            child: Text('Update', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  void _showNotificationSettings() {
    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          title: Text('Notifications', style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 18)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SwitchListTile(
                title: Text('Push Notifications', style: GoogleFonts.poppins(fontSize: 14)),
                subtitle: Text('Receive push alerts', style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textSecondary)),
                value: _pushNotifications,
                activeThumbColor: AppColors.primary,
                onChanged: (v) {
                  setDialogState(() => _pushNotifications = v);
                  setState(() {});
                },
              ),
              SwitchListTile(
                title: Text('Email Notifications', style: GoogleFonts.poppins(fontSize: 14)),
                subtitle: Text('Receive email updates', style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textSecondary)),
                value: _emailNotifications,
                activeThumbColor: AppColors.primary,
                onChanged: (v) {
                  setDialogState(() => _emailNotifications = v);
                  setState(() {});
                },
              ),
              SwitchListTile(
                title: Text('SMS Notifications', style: GoogleFonts.poppins(fontSize: 14)),
                subtitle: Text('Receive SMS alerts', style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textSecondary)),
                value: _smsNotifications,
                activeThumbColor: AppColors.primary,
                onChanged: (v) {
                  setDialogState(() => _smsNotifications = v);
                  setState(() {});
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text('Done', style: GoogleFonts.poppins(color: AppColors.primary, fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      ),
    );
  }

  void _showCurrencyPicker() {
    final currencies = ['USD (\$)', 'EUR (€)', 'GBP (£)', 'INR (₹)', 'JPY (¥)', 'AUD (A\$)'];
    showDialog(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: Text('Select Currency', style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 18)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        children: currencies.map((c) => SimpleDialogOption(
          onPressed: () {
            setState(() => _currency = c);
            Navigator.pop(ctx);
          },
          child: Row(
            children: [
              Icon(_currency == c ? Icons.radio_button_checked : Icons.radio_button_unchecked, color: _currency == c ? AppColors.primary : AppColors.textSecondary, size: 20),
              const SizedBox(width: 12),
              Text(c, style: GoogleFonts.poppins(fontSize: 14, fontWeight: _currency == c ? FontWeight.w600 : FontWeight.normal)),
            ],
          ),
        )).toList(),
      ),
    );
  }

  void _showLanguagePicker() {
    final languages = ['English', 'Spanish', 'French', 'German', 'Hindi', 'Japanese'];
    showDialog(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: Text('Select Language', style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 18)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        children: languages.map((l) => SimpleDialogOption(
          onPressed: () {
            setState(() => _language = l);
            Navigator.pop(ctx);
          },
          child: Row(
            children: [
              Icon(_language == l ? Icons.radio_button_checked : Icons.radio_button_unchecked, color: _language == l ? AppColors.primary : AppColors.textSecondary, size: 20),
              const SizedBox(width: 12),
              Text(l, style: GoogleFonts.poppins(fontSize: 14, fontWeight: _language == l ? FontWeight.w600 : FontWeight.normal)),
            ],
          ),
        )).toList(),
      ),
    );
  }

  void _showDarkModeToggle() {
    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          title: Text('Dark Mode', style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 18)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SwitchListTile(
                title: Text('Enable Dark Mode', style: GoogleFonts.poppins(fontSize: 14)),
                subtitle: Text('Demo only - UI won\'t change', style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textSecondary)),
                value: _darkMode,
                activeThumbColor: AppColors.primary,
                onChanged: (v) {
                  setDialogState(() => _darkMode = v);
                  setState(() {});
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text('Done', style: GoogleFonts.poppins(color: AppColors.primary, fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      ),
    );
  }

  void _showHelpFAQ() {
    final faqs = [
      {'q': 'How do I add a transaction?', 'a': 'Go to Dashboard and tap any Quick Action button (Transfer, Income, Expense, or Savings).'},
      {'q': 'How do I view analytics?', 'a': 'Navigate to the Analytics tab and use the period selector to switch between Weekly, Monthly, and Yearly views.'},
      {'q': 'Can I change the currency?', 'a': 'Yes! Go to Profile > Preferences > Currency to select your preferred currency.'},
      {'q': 'How do I filter transactions?', 'a': 'In the Transactions tab, use the filter chips (All, Income, Expense) to filter your transaction list.'},
      {'q': 'Is my data secure?', 'a': 'Yes, all your financial data is stored securely on your device with encryption.'},
    ];

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Help & FAQ', style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 18)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: faqs.length,
            separatorBuilder: (_, a) => const Divider(height: 20),
            itemBuilder: (_, i) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(faqs[i]['q']!, style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                const SizedBox(height: 4),
                Text(faqs[i]['a']!, style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textSecondary)),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Close', style: GoogleFonts.poppins(color: AppColors.primary, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  void _showAbout() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 70, height: 70,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Icon(Icons.account_balance_wallet, color: AppColors.primary, size: 36),
            ),
            const SizedBox(height: 16),
            Text('Financia', style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.primary)),
            const SizedBox(height: 4),
            Text('Version 1.0.0', style: GoogleFonts.poppins(fontSize: 13, color: AppColors.textSecondary)),
            const SizedBox(height: 16),
            Text(
              'Your personal finance companion. Track income, expenses, savings, and investments all in one place.',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(fontSize: 13, color: AppColors.textSecondary, height: 1.5),
            ),
            const SizedBox(height: 16),
            Text('Made with Flutter', style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textSecondary)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Close', style: GoogleFonts.poppins(color: AppColors.primary, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  void _showLogoutConfirmation() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Log Out', style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 18)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Text('Are you sure you want to log out?', style: GoogleFonts.poppins(fontSize: 14, color: AppColors.textSecondary)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: Text('Cancel', style: GoogleFonts.poppins(color: AppColors.textSecondary))),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                (route) => false,
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.expense, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
            child: Text('Log Out', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(symbol: '\$', decimalDigits: 2);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile header with gradient
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 60, bottom: 30),
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
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withValues(alpha: 0.15),
                      border: Border.all(color: Colors.white.withValues(alpha: 0.4), width: 3),
                    ),
                    child: const Icon(Icons.person, size: 48, color: Colors.white),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _userName,
                    style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w600, color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _userEmail,
                    style: GoogleFonts.poppins(fontSize: 14, color: Colors.white.withValues(alpha: 0.7)),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      children: [
                        Expanded(child: _buildStatItem('Balance', currencyFormat.format(SampleData.totalBalance), Icons.account_balance_wallet)),
                        Container(height: 40, width: 1, color: Colors.white24),
                        Expanded(child: _buildStatItem('Savings', currencyFormat.format(SampleData.totalSavings), Icons.savings)),
                        Container(height: 40, width: 1, color: Colors.white24),
                        Expanded(child: _buildStatItem('Investments', currencyFormat.format(SampleData.totalInvestments), Icons.trending_up)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Account section
            _buildSectionTitle('Account'),
            _buildMenuItem(icon: Icons.person_outline, color: const Color(0xFF4CAF50), title: 'Edit Profile', subtitle: 'Update your personal information', onTap: _showEditProfile),
            _buildMenuItem(icon: Icons.lock_outline, color: const Color(0xFF2196F3), title: 'Change Password', subtitle: 'Update your security credentials', onTap: _showChangePassword),
            _buildMenuItem(icon: Icons.notifications_outlined, color: const Color(0xFFFF9800), title: 'Notifications', subtitle: 'Manage notification preferences', onTap: _showNotificationSettings),

            const SizedBox(height: 8),

            // Preferences section
            _buildSectionTitle('Preferences'),
            _buildMenuItem(icon: Icons.currency_exchange, color: const Color(0xFF009688), title: 'Currency', subtitle: _currency, onTap: _showCurrencyPicker),
            _buildMenuItem(icon: Icons.language, color: const Color(0xFF3F51B5), title: 'Language', subtitle: _language, onTap: _showLanguagePicker),
            _buildMenuItem(icon: Icons.dark_mode_outlined, color: const Color(0xFF607D8B), title: 'Dark Mode', subtitle: _darkMode ? 'On' : 'Off', onTap: _showDarkModeToggle),

            const SizedBox(height: 8),

            // Support section
            _buildSectionTitle('Support'),
            _buildMenuItem(icon: Icons.help_outline, color: const Color(0xFF9C27B0), title: 'Help & FAQ', subtitle: 'Get help with the app', onTap: _showHelpFAQ),
            _buildMenuItem(icon: Icons.info_outline, color: const Color(0xFF795548), title: 'About', subtitle: 'Version 1.0.0', onTap: _showAbout),

            const SizedBox(height: 16),

            // Logout button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton.icon(
                  onPressed: _showLogoutConfirmation,
                  icon: const Icon(Icons.logout, color: AppColors.expense),
                  label: Text(
                    'Log Out',
                    style: GoogleFonts.poppins(color: AppColors.expense, fontWeight: FontWeight.w600, fontSize: 15),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.expense),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.white70, size: 20),
        const SizedBox(height: 6),
        Text(label, style: GoogleFonts.poppins(color: Colors.white60, fontSize: 12)),
        Text(value, style: GoogleFonts.poppins(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600)),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 4),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textSecondary, letterSpacing: 0.5),
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 3),
      child: Card(
        elevation: 0,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        child: ListTile(
          leading: Container(
            width: 42, height: 42,
            decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, color: color, size: 22),
          ),
          title: Text(title, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.textPrimary)),
          subtitle: Text(subtitle, style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textSecondary)),
          trailing: const Icon(Icons.chevron_right, size: 24, color: AppColors.textSecondary),
          onTap: onTap,
        ),
      ),
    );
  }
}
