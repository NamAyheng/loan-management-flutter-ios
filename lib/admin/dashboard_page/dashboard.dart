import 'package:flutter/material.dart';
import 'package:flutter_loan_management/admin/application_page/detail_application.dart';
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

///
/// Grid card widget
///

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

///
/// Application card widget
///

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
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailApplication(
            name: name,
            role: "Customer",
            email: "$name@example.com".toLowerCase(),
            phone: "+12 345 678",
            type: type,
            amount: amount,
            duration: 12,
            rate: 7.9,
            emi: amount / 12 + 5, // example calculation
            status: status,
            purpose: "Loan for personal use", // placeholder
          ),
        ),
      );
    },

    child: Container(
      padding: const EdgeInsets.all(16),
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
                    child: const Icon(Icons.person_2_outlined),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        type,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: getStatusColor(status).withOpacity(0.2),
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
          const SizedBox(height: 10),
          Divider(height: 1, thickness: 1, color: Colors.grey[300]),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Amount",
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  Text(
                    "\$$amount",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    "Date",
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  Text(
                    DateFormat('dd/MM/yyyy').format(date),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

///
/// Main Dashboard widget
///

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final dashboardCards = [
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

    final applicationCards = [
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

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Header
          Align(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                SizedBox(height: 10),
                Text(
                  "Dashboard",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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

          // Grid cards
          GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: 1.1,
            children: dashboardCards.map((card) {
              return gridCard(
                card["label"] as String, // fixed quote
                card["dollar"] as String,
                card["value"] as double,
                card["percent"] as String,
                card["numPercent"] as int,
                Icon(card["icon"] as IconData?, color: ThemeColors.primary1),
              );
            }).toList(),
          ),

          const SizedBox(height: 20),

          // Recent Applications
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Recent Applications",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  "View All",
                  style: TextStyle(fontSize: 12, color: ThemeColors.primary1),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: applicationCards.length,
            itemBuilder: (context, index) {
              final card = applicationCards[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: appCard(
                  card["name"] as String,
                  card["type"] as String,
                  card["status"] as String,
                  card["amount"] as double,
                  card["date"] as DateTime,
                  context,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
