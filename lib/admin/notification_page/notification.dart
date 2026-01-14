import 'package:flutter/material.dart';
import 'package:flutter_loan_management/admin/main_admin/appbar_top.dart';
import 'package:flutter_loan_management/theme/colors.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationState();
}

class _NotificationState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarTop(context),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: ThemeColors.bgcolor,
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: Text("Notification"),
      ),
    );
  }
}
