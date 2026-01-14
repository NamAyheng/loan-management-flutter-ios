import 'package:flutter/material.dart';
import 'package:flutter_loan_management/admin/application_page/detail_application.dart';
import 'package:flutter_loan_management/theme/colors.dart';
import 'package:intl/intl.dart';

Color getStatusColor(String status) {
  switch (status.toLowerCase()) {
    case "verified":
      return Colors.green;
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

Widget _infoColumn(String title, String value, CrossAxisAlignment alignment) {
  return Column(
    crossAxisAlignment: alignment,
    children: [
      Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
    ],
  );
}

Widget appCard(
  String name,
  String type,
  String email,
  String status,
  double amount,
  double duration,
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
            email: email,
            phone: "+12 345 678",
            type: type,
            amount: amount,
            duration: duration,
            rate: 7.9,
            emi: amount / 12 + 5,
            status: status,
            purpose: "Loan for personal use",
          ),
        ),
      );
    },
    child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: ThemeColors.primary1,
                    child: const Icon(
                      Icons.person_2_outlined,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        type,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        email,
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
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
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _infoColumn("Amount", "\$$amount", CrossAxisAlignment.start),
              _infoColumn(
                "Duration",
                "$duration months",
                CrossAxisAlignment.center,
              ),
              _infoColumn(
                "Date",
                DateFormat('dd/MM/yyyy').format(date),
                CrossAxisAlignment.end,
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

class AdminApplication extends StatefulWidget {
  const AdminApplication({super.key});

  @override
  State<AdminApplication> createState() => _AdminApplicationState();
}

class _AdminApplicationState extends State<AdminApplication> {
  String selectedStatus = "All";

  final List<Map<String, dynamic>> applicationCards = [
    {
      "name": "Johnson",
      "type": "Personal Loan",
      "email": "johnson@gmail.com",
      "status": "Pending",
      "amount": 10000.0,
      "duration": 11.0,
      "date": DateTime(2021, 2, 12),
    },
    {
      "name": "Brick Nop",
      "type": "Education Loan",
      "email": "bricknop@gmail.com",
      "status": "Approved",
      "amount": 5500.0,
      "duration": 12.0,
      "date": DateTime(2021, 2, 13),
    },
    {
      "name": "Hollor",
      "type": "Business Loan",
      "email": "hollar@gmail.com",
      "status": "Rejected",
      "amount": 20000.0,
      "duration": 12.0,
      "date": DateTime(2021, 2, 14),
    },
  ];

  Widget filterButton(String title) {
    final bool isSelected = selectedStatus == title;

    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            selectedStatus = title;
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? ThemeColors.primary1 : Colors.white,
          foregroundColor: isSelected ? Colors.white : Colors.black,
          elevation: isSelected ? 2 : 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
              color: isSelected ? ThemeColors.primary1 : Colors.grey.shade300,
            ),
          ),
        ),
        child: Text(title),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredList = selectedStatus == "All"
        ? applicationCards
        : applicationCards.where((e) => e["status"] == selectedStatus).toList();

    return Scaffold(
      body: Container(
        color: ThemeColors.bgcolor,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Applications",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              const Text(
                "Review loan requests.",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(height: 12),
              TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: const Icon(Icons.search),
                  hintText: "Search applications",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    filterButton("All"),
                    filterButton("Pending"),
                    filterButton("Approved"),
                    filterButton("Rejected"),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: filteredList.length,
                itemBuilder: (context, index) {
                  final card = filteredList[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: appCard(
                      card["name"],
                      card["type"],
                      card["email"],
                      card["status"],
                      card["amount"],
                      card["duration"],
                      card["date"],
                      context,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
