import 'package:flutter/material.dart';
import 'package:flutter_loan_management/admin/notification_page/notification.dart';
import 'package:flutter_loan_management/theme/colors.dart';

PreferredSizeWidget appBarDetail(BuildContext context) {
  return AppBar(
    toolbarHeight: 80,
    backgroundColor: Colors.white,
    title: Center(
      child: Column(
        children: [
          Text(
            "Review Application",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          Text(
            "Application #1",
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          ),
        ],
      ),
    ),
    actions: [
      IconButton(
        padding: EdgeInsets.only(right: 20),
        icon: const Icon(
          Icons.notifications_active_outlined,
          color: ThemeColors.primary1,
        ),
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Notifications()),
          );
        },
      ),
    ],
  );
}
