import 'package:flutter/material.dart';
import 'package:flutter_loan_management/theme/colors.dart';

Widget adminBottomNav(
  BuildContext context,
  int currentIndex,
  Function(int) onTap,
) {
  return BottomNavigationBar(
    type: BottomNavigationBarType.fixed,
    currentIndex: currentIndex,
    onTap: onTap,
    selectedItemColor: ThemeColors.primary1,
    unselectedItemColor: Colors.grey,
    items: const [
      BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
      BottomNavigationBarItem(
        icon: Icon(Icons.smartphone_outlined),
        label: 'App',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.payment_outlined),
        label: 'Payments',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.logout_outlined),
        label: 'Logout',
      ),
    ],
  );
}
