import 'package:flutter/material.dart';

import 'package:flutter_loan_management/admin/main_admin/main_admin_screen.dart';
import 'package:flutter_loan_management/admin/notification_page/notification.dart';
import 'package:flutter_loan_management/theme/colors.dart';

PreferredSizeWidget appBarTop(BuildContext context) {
  return AppBar(
    toolbarHeight: 80,
    backgroundColor: Colors.white,
    title: GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainAdminScreen()),
        );
      },
      child: Image.asset(
        'assets/images/Loanify.png',
        height: 25,
        fit: BoxFit.contain,
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
