import 'package:flutter/material.dart';
import 'package:flutter_loan_management/theme/colors.dart';

Widget customerBottomNav({
  required int currentIndex,
  required Function(int) onTap,
}) {
  return BottomNavigationBar(
    type: BottomNavigationBarType.fixed,
    backgroundColor: Colors.white,
    selectedItemColor: ThemeColors.primary1,
    unselectedItemColor: Colors.grey,
    elevation: 8,
    currentIndex: currentIndex,
    onTap: onTap,
    items: const [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      BottomNavigationBarItem(icon: Icon(Icons.description), label: 'Loans'),
      BottomNavigationBarItem(icon: Icon(Icons.calculate), label: 'EMI'),
      BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
    ],
  );
}
