import 'package:flutter/material.dart';
import 'package:flutter_loan_management/admin/payment_page/bottom_sheet.dart';
import 'package:flutter_loan_management/theme/colors.dart';
import 'package:intl/intl.dart';

/* ---------------- STATUS & BUTTON HELPERS ---------------- */

Color getStatusColor(String status) {
  switch (status.toLowerCase()) {
    case "verified":
      return Colors.green;
    case "pending":
      return Colors.orange;
    case "paid":
      return Colors.green;
    case "overdue":
      return Colors.red;
    default:
      return Colors.grey;
  }
}

String getButtonText(String status) {
  switch (status.toLowerCase()) {
    case "paid":
      return "Paid is Collected";
    case "pending":
    case "overdue":
      return "View Receipt & Mark as Paid";
    default:
      return "";
  }
}

Color getButtonBgColor(String status) {
  switch (status.toLowerCase()) {
    case "paid":
      return Colors.white;
    case "pending":
      return ThemeColors.primary1;
    case "overdue":
      return Colors.red;
    default:
      return Colors.grey;
  }
}

Color getButtonFgColor(String status) {
  switch (status.toLowerCase()) {
    case "paid":
      return ThemeColors.primary1;
    case "pending":
    case "overdue":
      return Colors.white;
    default:
      return Colors.black;
  }
}

BorderSide? getButtonBorder(String status) {
  if (status.toLowerCase() == "paid") {
    return BorderSide(color: ThemeColors.primary1);
  }
  return null;
}

/* ---------------- CARD UI ---------------- */

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

          const Divider(),

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
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    "Due Date",
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  Text(
                    DateFormat('MMM dd, yyyy').format(date),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 10),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: status.toLowerCase() == "paid"
                  ? null
                  : () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        builder: (_) => PaymentReceiptBottomSheet(
                          name: name,
                          amount: amount,
                          status: status,
                          uploadedDate: date,
                        ),
                      );
                    },
              icon: const Icon(Icons.show_chart_outlined),
              label: Text(getButtonText(status)),
              style: ElevatedButton.styleFrom(
                backgroundColor: getButtonBgColor(status),
                foregroundColor: getButtonFgColor(status),
                side: getButtonBorder(status),
                elevation: status.toLowerCase() == "paid" ? 0 : 2,
              ),
            ),
          ),
          /* SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: status.toLowerCase() == "paid" ? null : () {},
              icon: const Icon(Icons.show_chart_outlined),
              label: Text(getButtonText(status)),
              style: ElevatedButton.styleFrom(
                backgroundColor: getButtonBgColor(status),
                foregroundColor: getButtonFgColor(status),
                side: getButtonBorder(status),
                elevation: status.toLowerCase() == "paid" ? 0 : 2,
              ),
            ),
          ), */
        ],
      ),
    ),
  );
}

/* ---------------- GRID CARD (UNCHANGED) ---------------- */

Widget gridCard(
  String label,
  String str1,
  double value,
  String str2,
  Color color,
  Icon icon,
) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 1),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 45,
          height: 45,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: color.withOpacity(0.2),
          ),
          child: Center(child: icon),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 8),
        Text(
          "$str1$value$str2",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );
}

/* ---------------- SCREEN ---------------- */

class AdminPayment extends StatefulWidget {
  const AdminPayment({super.key});

  @override
  State<AdminPayment> createState() => _AdminPaymentState();
}

class _AdminPaymentState extends State<AdminPayment> {
  String selectedStatus = "All";

  final List<Map<String, dynamic>> paymentCards = [
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
      "status": "Paid",
      "amount": 5500.0,
      "duration": 12.0,
      "date": DateTime(2021, 2, 13),
    },
    {
      "name": "Hollorasdsad",
      "type": "Business Loan",
      "email": "hollar@gmail.com",
      "status": "Overdue",
      "amount": 20000.0,
      "duration": 12.0,
      "date": DateTime(2021, 2, 14),
    },
  ];

  List<Map<String, Object>> get payCard => [
    {
      "label": "Pending",
      "str1": "\$",
      "value": 123,
      "str2": "K",
      "color": Colors.orange,
      "icon": Icons.error_outline_rounded,
    },
    {
      "label": "Overdue",
      "str1": "",
      "value": 123,
      "str2": "K",
      "color": Colors.red,
      "icon": Icons.error_outline_rounded,
    },
  ];

  /// ✅ MOVED HERE (FIX)
  int statusPriority(String status) {
    switch (status.toLowerCase()) {
      case "pending":
        return 1;
      case "overdue":
        return 2;
      case "paid":
        return 3;
      default:
        return 4;
    }
  }

  Widget filterButton(String title) {
    final bool isSelected = selectedStatus == title;

    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ElevatedButton(
        onPressed: () => setState(() => selectedStatus = title),
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
    /// ✅ FILTER + SORT (FIX)
    List<Map<String, dynamic>> filteredList = selectedStatus == "All"
        ? List.from(paymentCards)
        : paymentCards.where((e) => e["status"] == selectedStatus).toList();

    filteredList.sort((a, b) {
      final statusCompare = statusPriority(
        a["status"],
      ).compareTo(statusPriority(b["status"]));
      if (statusCompare != 0) return statusCompare;
      return (b["date"] as DateTime).compareTo(a["date"] as DateTime);
    });

    return Scaffold(
      body: Container(
        color: ThemeColors.bgcolor,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Payments",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              const Text(
                "Track loan payments.",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(height: 12),
              TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: const Icon(Icons.search),
                  hintText: "Search payments",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.green,
                ),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "This Months Collection",
                          style: TextStyle(color: Colors.white70, fontSize: 14),
                        ),
                        Text(
                          "Total Amount K",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Expanded(child: SizedBox()),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white30,
                      ),
                      child: Icon(
                        Icons.show_chart_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: 1.1,
                children: payCard.map((card) {
                  final Color cardColor = card["color"] as Color;
                  return gridCard(
                    card["label"] as String, // fixed quote
                    card["str1"] as String,
                    card["value"] as double,
                    card["str2"] as String,
                    cardColor,
                    Icon(card["icon"] as IconData, color: cardColor),
                  );
                }).toList(),
              ),
              const SizedBox(height: 12),
              const SizedBox(height: 12),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    filterButton("All"),
                    filterButton("Pending"),
                    filterButton("Paid"),
                    filterButton("Overdue"),
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
