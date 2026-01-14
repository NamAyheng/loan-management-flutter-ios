import 'package:flutter/material.dart';
import 'package:flutter_loan_management/admin/application_page/detail_appbar.dart';
import 'package:flutter_loan_management/admin/application_page/reject_approve.dart';

import 'package:flutter_loan_management/theme/colors.dart';

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

String formatNumber(double value, {bool alwaysTwoDecimals = false}) {
  if (alwaysTwoDecimals) {
    return value.toStringAsFixed(2); // always 2 decimals
  } else {
    if (value == value.toInt()) {
      return value.toInt().toString(); // no decimals if whole number
    } else {
      return value.toString(); // keep decimals if not whole
    }
  }
}

String name = "";
String role = "Customer";
String email = "@example.com";
String phone = "+ 12 345 678";
String type = "Personal Loan";
double amount = 5000;
double duration = 5;
double rate = 7.5;
double emi = 480.5;
String status = "pending";
String purpose = "Yk luy tuk tinh ey nham bat";

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
        BoxShadow(
          color: Colors.black.withOpacity(0.1), // shadow color
          blurRadius: 1, // softness
        ),
      ],
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
                color: color.withOpacity(0.2),
              ),
              child: Center(child: icon),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Text(
              /* "$str1${value.toStringAsFixed(2)}$str2", */
              "$str1${formatNumber(value, alwaysTwoDecimals: label == "Monthly EMI")}$str2",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget submitCard({
  required String title,
  required String fileSize,
  required String status,
  required IconData defaultIcon,
}) {
  final bool isVerified = status.toLowerCase() == "verified";
  final Color statusColor = getStatusColor(status);

  return GestureDetector(
    onTap: () {},
    child: Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          // LEFT ICON
          Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: statusColor.withOpacity(0.2),
            ),
            child: Center(
              child: Icon(
                isVerified ? Icons.check : defaultIcon,
                color: statusColor,
              ),
            ),
          ),

          const SizedBox(width: 12),

          // TITLE & FILE SIZE
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  fileSize,
                  style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),

          // STATUS TEXT
          Container(
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: statusColor.withOpacity(0.2),
            ),

            child: Text(
              status,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: statusColor,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

class DetailApplication extends StatefulWidget {
  final String name;
  final String role;
  final String email;
  final String phone;
  final String type; // loan type
  final double amount;
  final double duration;
  final double rate; // we set, not input
  final double emi; // we set, not input
  final String status;
  final String purpose;

  const DetailApplication({
    super.key,
    required this.name,
    required this.role,
    required this.email,
    required this.phone,
    required this.type,
    required this.amount,
    required this.duration,
    required this.rate,
    required this.emi,
    required this.status,
    required this.purpose,
  });

  @override
  State<DetailApplication> createState() => _DetailApplicationtate();
}

class _DetailApplicationtate extends State<DetailApplication> {
  List<Map<String, Object>> get detailCard => [
    {
      "label": "Loan Amount",
      "str1": "\$",
      "value": widget.amount,
      "str2": "",
      "color": Colors.blue,
      "icon": Icons.money_outlined,
    },
    {
      "label": "Duarion",
      "str1": "",
      "value": widget.duration,
      "str2": " months",
      "color": Colors.deepPurpleAccent,
      "icon": Icons.calendar_month_outlined,
    },
    {
      "label": "Customers",
      "str1": "",
      "value": widget.rate,
      "str2": "%",

      "color": Colors.orange,
      "icon": Icons.percent_outlined,
    },
    {
      "label": "Monthly EMI",
      "str1": "\$",
      "value": widget.emi,

      "str2": "",
      "color": Colors.green,
      "icon": Icons.credit_card_outlined,
    },
  ];

  final List<Map<String, dynamic>> submittedDocuments = [
    {
      "title": "Identity Proof",
      "fileSize": "2.4 MB",
      "status": "Verified",
      "icon": Icons.badge_outlined,
    },
    {
      "title": "Address Proof",
      "fileSize": "2.4 MB",
      "status": "Pending",
      "icon": Icons.house_outlined,
    },
    {
      "title": "Income Proof",
      "fileSize": "2.4 MB",
      "status": "Pending",
      "icon": Icons.backpack_outlined,
    },
    {
      "title": "Bank Statement",
      "fileSize": "2.4 MB",
      "status": "Pending",
      "icon": Icons.account_balance_outlined,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarDetail(context),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            color: ThemeColors.bgcolor,

            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,

              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    //
                    //
                    //

                    // Customer Infomation Card
                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 1,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.person_2_outlined,
                                color: ThemeColors.primary1,
                              ),
                              SizedBox(width: 10),
                              Text(
                                "Customer Infomation",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),

                          // Name + Role
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: ThemeColors.bgcolor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  backgroundColor: ThemeColors.primary1,
                                  child: Icon(
                                    Icons.person_2_outlined,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.name,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      widget.role,
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),

                          // Email
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.blue.withOpacity(0.2),
                                ),
                                child: Icon(
                                  Icons.email_outlined,
                                  size: 20,
                                  color: Colors.blue,
                                ),
                              ),
                              SizedBox(width: 10),
                              Text(
                                widget.email,
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),

                          // Telephone
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.green.withOpacity(0.2),
                                ),
                                child: Icon(
                                  Icons.call_outlined,
                                  size: 20,
                                  color: Colors.green,
                                ),
                              ),
                              SizedBox(width: 10),
                              Text(
                                widget.phone,
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),

                    //
                    //
                    //

                    // Loan Detail Card
                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(
                              0.1,
                            ), // shadow color
                            blurRadius: 1, // softness
                            spreadRadius: 1, // size
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.document_scanner_outlined,
                                color: ThemeColors.primary1,
                              ),
                              SizedBox(width: 10),
                              Text(
                                "Loan Details",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),

                          // Loan Type
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Loan Type",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                widget.type,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          Divider(color: Colors.grey[200]),
                          SizedBox(height: 10),

                          // Amount
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Amount",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                "\$${widget.amount}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          Divider(color: Colors.grey[200]),
                          SizedBox(height: 10),

                          // Duration
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Duration",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                "${widget.duration} months",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          Divider(color: Colors.grey[200]),
                          SizedBox(height: 10),

                          //Interest
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Interest",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                "${widget.rate}%",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          Divider(color: Colors.grey[200]),
                          SizedBox(height: 10),

                          // EMI
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Monthly EMI",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                "\$${widget.emi.toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                          Divider(color: Colors.grey[200]),
                          SizedBox(height: 10),

                          //Status
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Status",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: getStatusColor(
                                    widget.status,
                                  ).withOpacity(0.2),
                                ),
                                child: Text(
                                  widget.status,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: getStatusColor(widget.status),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Grid cards
                    GridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      childAspectRatio: 1.1,
                      children: detailCard.map((card) {
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
                    const SizedBox(height: 20),

                    // Loan Purpose Card
                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(
                              0.1,
                            ), // shadow color
                            blurRadius: 1, // softness
                            spreadRadius: 1, // size
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.list_alt_outlined,
                                color: ThemeColors.primary1,
                              ),
                              SizedBox(width: 10),
                              Text(
                                "Loan Purpose",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Text(
                            widget.purpose,
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    //
                    //
                    //

                    // Submited Documents Card
                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 1,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.upload_file_outlined,
                                color: ThemeColors.primary1,
                              ),
                              SizedBox(width: 10),
                              Text(
                                "Submitted Documents",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Column(
                            children: submittedDocuments.map((doc) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: submitCard(
                                  title: doc["title"],
                                  fileSize: doc["fileSize"],
                                  status: doc["status"],
                                  defaultIcon: doc["icon"],
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ),
          ),

          //
          //
          //

          // Position
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        rejectDialog(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 20),
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      label: Text(
                        "Reject",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      icon: Icon(Icons.block_outlined),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        approveDialog(context);
                      },

                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 20),
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      label: Text(
                        "Approve",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      icon: Icon(Icons.check_circle_outline),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
