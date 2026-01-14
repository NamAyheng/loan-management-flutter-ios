/* import 'package:flutter/material.dart';
/* import 'package:flutter_loan_management/admin/combine_screen/appbar_top.dart';
import 'package:flutter_loan_management/admin/combine_screen/navigation_bar.dart'; */
import 'package:flutter_loan_management/admin/detail_application.dart';
import 'package:flutter_loan_management/theme/colors.dart';
import 'package:intl/intl.dart';

Color getStatusColor(String status) {
  switch (status.toLowerCase()) {
    case "pending":
      return Colors.orange;
    case "approved":
      return Colors.green;
    case "rejected":
      return Colors.red;
    default:
      return Colors.grey;
  }
}

/// Grid card widget
Widget gridCard(
  String label,
  String dollar,
  double value,
  String percent,
  int numPercent,
  Icon icon,
) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: ThemeColors.primary1.withOpacity(0.2),
              ),
              child: Center(child: icon),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "$dollar$value",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "+$numPercent$percent",
                  style: TextStyle(fontSize: 12, color: ThemeColors.primary1),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}

Widget appCard(
  String name,
  String type,
  String status,
  double amount,
  DateTime date,
  BuildContext context,
) {
  return GestureDetector(
    onTap: () {
      print('nav');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (contenxt) => DetailApplication()),
      );
    },
    child: Container(
      padding: EdgeInsets.all(16),
      width: double.infinity,

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: ThemeColors.primary1,
                    foregroundColor: Colors.white,
                    child: Icon(Icons.person_2_outlined),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        type,
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: getStatusColor(
                    status,
                  ).withOpacity(0.2), // color based on status from input
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: getStatusColor(status),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 10),
          Divider(height: 1, thickness: 1, color: Colors.grey[300]),
          SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Amount",
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  Text(
                    "\$$amount",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Date",
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  Text(
                    DateFormat('dd/MM/yyyy').format(date),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ), // datetime only display year month day
                ],
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  //
  // Dashboard card

  final List<Map<String, dynamic>> dashboardCards = [
    {
      "label": "Total Loans",
      "dollar": "\$",
      "value": 25.5,
      "percent": "%",
      "numPercent": 12,
      "icon": Icons.credit_card_outlined,
    },
    {
      "label": "Pending",
      "dollar": "",
      "value": 8,
      "percent": "%",
      "numPercent": 3,
      "icon": Icons.lock_clock,
    },
    {
      "label": "Customers",
      "dollar": "",
      "value": 156,
      "percent": "%",
      "numPercent": 9,
      "icon": Icons.person_2_outlined,
    },
    {
      "label": "This Month",
      "dollar": "\$",
      "value": 4.8,
      "percent": "%",
      "numPercent": 15,
      "icon": Icons.arrow_outward_outlined,
    },
  ];

  // Application card

  final List<Map<String, dynamic>> applicationCards = [
    {
      "name": "Johnson",
      "type": "Personal Loan",
      "status": "Pending",
      "amount": 1000.0,
      "date": DateTime(2021, 2, 12),
    },
    {
      "name": "Brick Nop",
      "type": "Education Loan",
      "status": "Approved",
      "amount": 5500.0,
      "date": DateTime(2021, 2, 13),
    },
    {
      "name": "name",
      "type": "Business Loan",
      "status": "Rejected",
      "amount": 20000.0,
      "date": DateTime(2021, 2, 14),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* appBar: appBarTop(context), */
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: ThemeColors.bgcolor,
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    SizedBox(height: 20),
                    Text(
                      "Dashboard",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Overview of loan management.",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Grid of cards
              GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: 1.1,
                children: dashboardCards.map((card) {
                  return gridCard(
                    card["label"],
                    card["dollar"],
                    card["value"],
                    card["percent"],
                    card["numPercent"],
                    Icon(card["icon"], color: ThemeColors.primary1),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Recent Applications",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "View All",
                      style: TextStyle(
                        fontSize: 12,
                        color: ThemeColors.primary1,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Column(
                children: applicationCards.map((card) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: appCard(
                      card["name"],
                      card["type"],
                      card["status"],
                      card["amount"],
                      card["date"],
                      context,
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
} */
