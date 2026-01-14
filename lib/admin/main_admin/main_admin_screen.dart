import 'package:flutter/material.dart';
import 'package:flutter_loan_management/admin/application_page/application.dart';
import 'package:flutter_loan_management/admin/payment_page/payment.dart';
import 'package:flutter_loan_management/signin-signup/signin.dart';
import '../dashboard_page/dashboard.dart'; // AdminDashboard page
import 'package:flutter_loan_management/admin/main_admin/navigation_bar.dart';
import 'package:flutter_loan_management/admin/main_admin/appbar_top.dart';

class MainAdminScreen extends StatefulWidget {
  const MainAdminScreen({super.key});

  @override
  State<MainAdminScreen> createState() => _MainAdminScreenState();
}

class _MainAdminScreenState extends State<MainAdminScreen> {
  int _currentIndex = 0;

  // Only actual admin pages/screens
  final List<Widget> _screens = const [
    AdminDashboard(),
    AdminApplication(),
    AdminPayment(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarTop(context),
      body: _screens[_currentIndex],

      // Bottom navigation with logout handling
      bottomNavigationBar: adminBottomNav(context, _currentIndex, (index) {
        if (index == 3) {
          // 🚪 Logout: go to SignIn and remove all previous screens
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const SignInAppFul()),
            (route) => false,
          );
          return;
        }

        // Regular tab switching
        setState(() => _currentIndex = index);
      }),
    );
  }
}
