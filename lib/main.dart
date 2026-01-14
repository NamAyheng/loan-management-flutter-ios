/* import 'package:flutter/material.dart';
import 'package:flutter_loan_management/admin/main_admin/main_admin_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainAdminScreen(),
    );
  }
} */

import 'package:flutter/material.dart';

// ADMIN
import 'package:flutter_loan_management/admin/main_admin/main_admin_screen.dart';

// CUSTOMER

import 'package:flutter_loan_management/customer/main_customer/main_customer_screen.dart';
import 'package:flutter_loan_management/signin-signup/get_started.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const RootDecider(),
    );
  }
}

class RootDecider extends StatefulWidget {
  const RootDecider({super.key});

  @override
  State<RootDecider> createState() => _RootDeciderState();
}

class _RootDeciderState extends State<RootDecider> {
  bool isAdmin = true;

  /* @override
  Widget build(BuildContext context) {
    return isAdmin ? const MainAdminScreen() : const MainCustomerScreen();
  } */
  @override
  Widget build(BuildContext context) {
    return GetStartedPage();
  }
}
