import 'package:flutter/material.dart';
import 'package:flutter_loan_management/customer/main_customer/appbar_customer.dart';
import 'package:flutter_loan_management/customer/main_customer/navigation_bar.dart';
import '../screens/home_screen.dart';
import '../screens/loans_screen.dart';
import '../screens/emi_calculator_screen.dart';
import '../screens/profile_screen.dart';

class MainCustomerScreen extends StatefulWidget {
  final int initialIndex;

  const MainCustomerScreen({super.key, this.initialIndex = 0});

  @override
  State<MainCustomerScreen> createState() => _MainCustomerScreenState();
}

class _MainCustomerScreenState extends State<MainCustomerScreen> {
  late int _currentIndex;

  final List<Widget> _screens = const [
    HomeScreen(),
    LoansScreen(),
    EMICalculatorScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();

    _currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: customerBottomNav(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
      ),
    );
  }
}
