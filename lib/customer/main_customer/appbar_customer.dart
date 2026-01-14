import 'package:flutter/material.dart';

import 'package:flutter_loan_management/admin/notification_page/notification.dart';
import 'package:flutter_loan_management/customer/main_customer/main_customer_screen.dart';
import 'package:flutter_loan_management/customer/screens/notifications_screen.dart';
import 'package:flutter_loan_management/theme/colors.dart';

PreferredSizeWidget appBarCustomer(BuildContext context) {
  return AppBar(
    toolbarHeight: 80,
    backgroundColor: Colors.white,
    title: GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainCustomerScreen()),
        );
      },
      child: Image.asset(
        'assets/images/Loanify.png',
        height: 25,
        fit: BoxFit.contain,
      ),
    ),
    actions: [
      GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const NotificationsScreen(),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          margin: EdgeInsets.only(right: 20),
          decoration: BoxDecoration(
            color: const Color(0xFF10B981).withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Stack(
            children: [
              const Icon(
                Icons.notifications_outlined,
                color: Color(0xFF10B981),
                size: 22,
              ),
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      /* IconButton(
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
      ), */
    ],
  );
}
