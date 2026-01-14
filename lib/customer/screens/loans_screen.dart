import 'package:flutter/material.dart';
import 'package:flutter_loan_management/customer/main_customer/main_customer_screen.dart';
import '../models/loan.dart';

import 'loan_detail_screen.dart';

class LoansScreen extends StatefulWidget {
  const LoansScreen({super.key});

  @override
  State<LoansScreen> createState() => _LoansScreenState();
}

class _LoansScreenState extends State<LoansScreen> {
  String _selectedFilter = 'All';
  final List<String> _filters = [
    'All',
    'Active',
    'Pending',
    'Completed',
    'Rejected',
  ];

  final List<Loan> allLoans = [
    Loan(
      id: '1',
      type: 'Personal Loan',
      amount: 50000,
      appliedDate: DateTime(2024, 1, 15),
      status: 'Approved',
      interestRate: 8.5,
      tenureMonths: 60,
      emiAmount: 4500,
      nextPaymentDate: DateTime(2024, 1, 25),
    ),
    Loan(
      id: '2',
      type: 'Home Loan',
      amount: 500000,
      appliedDate: DateTime(2024, 1, 20),
      status: 'Pending',
      interestRate: 7.5,
      tenureMonths: 120,
      emiAmount: 8500,
    ),
    Loan(
      id: '3',
      type: 'Education Loan',
      amount: 200000,
      appliedDate: DateTime(2023, 12, 10),
      status: 'Approved',
      interestRate: 6.5,
      tenureMonths: 84,
      emiAmount: 8500,
      nextPaymentDate: DateTime(2024, 1, 20),
    ),
    Loan(
      id: '4',
      type: 'Business Loan',
      amount: 100000,
      appliedDate: DateTime(2023, 11, 5),
      status: 'Rejected',
      interestRate: 8.5,
      tenureMonths: 36,
    ),
    Loan(
      id: '5',
      type: 'Personal Loan',
      amount: 30000,
      appliedDate: DateTime(2023, 5, 1),
      status: 'Completed',
      interestRate: 8.5,
      tenureMonths: 36,
      emiAmount: 1000,
    ),
  ];

  List<Loan> get _filteredLoans {
    switch (_selectedFilter) {
      case 'All':
        return allLoans;
      case 'Active':
        return allLoans.where((loan) => loan.status == 'Approved').toList();
      case 'Pending':
        return allLoans.where((loan) => loan.status == 'Pending').toList();
      case 'Completed':
        return allLoans.where((loan) => loan.status == 'Completed').toList();
      case 'Rejected':
        return allLoans.where((loan) => loan.status == 'Rejected').toList();
      default:
        return allLoans;
    }
  }

  double get _totalActiveLoans {
    return allLoans
        .where((loan) => loan.status == 'Approved')
        .fold(0.0, (sum, loan) => sum + loan.amount);
  }

  double get _monthlyEMI {
    return allLoans
        .where((loan) => loan.status == 'Approved' && loan.emiAmount > 0)
        .fold(0.0, (sum, loan) => sum + loan.emiAmount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const MainCustomerScreen(initialIndex: 0),
              ),
              (route) => false,
            );
          },
        ),
        title: const Text(
          'My Loans',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Summary Card
            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF10B981), Color(0xFF059669)],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Active Loans',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '\$${_formatAmount(_totalActiveLoans.toStringAsFixed(0))}',
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Monthly EMI',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '\$${_formatAmount(_monthlyEMI.toStringAsFixed(0))}',
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Filter Tabs
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _filters.map((filter) {
                    final isSelected = _selectedFilter == filter;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedFilter = filter;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFF10B981)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: isSelected
                                ? null
                                : Border.all(
                                    color: Colors.grey.shade300,
                                    width: 1,
                                  ),
                          ),
                          child: Text(
                            filter,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: isSelected
                                  ? Colors.white
                                  : Colors.grey.shade700,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Loan List
            Expanded(
              child: _filteredLoans.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.inbox_outlined,
                            size: 64,
                            color: Colors.grey.shade300,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No loans found',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      key: ValueKey(_selectedFilter),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: _filteredLoans.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: _buildLoanCard(_filteredLoans[index]),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoanCard(Loan loan) {
    Color statusBgColor;
    Color statusTextColor;

    switch (loan.status) {
      case 'Approved':
        statusBgColor = const Color(0xFF10B981).withOpacity(0.15);
        statusTextColor = const Color(0xFF10B981);
        break;
      case 'Pending':
        statusBgColor = Colors.blue.withOpacity(0.15);
        statusTextColor = Colors.blue;
        break;
      case 'Rejected':
        statusBgColor = Colors.red;
        statusTextColor = Colors.white;
        break;
      case 'Completed':
        statusBgColor = Colors.grey.shade300;
        statusTextColor = Colors.grey.shade700;
        break;
      default:
        statusBgColor = Colors.grey.shade300;
        statusTextColor = Colors.grey.shade700;
    }

    // Calculate remaining balance (for approved loans)
    double remainingBalance = 0;
    if (loan.status == 'Approved' && loan.emiAmount > 0) {
      // Simple calculation: assume some payments made
      remainingBalance = loan.amount * 0.9; // 90% remaining as example
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoanDetailScreen(loan: loan)),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color(0xFF10B981).withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color(0xFF10B981).withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: const Icon(
                    Icons.description_outlined,
                    color: Color(0xFF10B981),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        loan.type,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Applied on ${_formatDateISO(loan.appliedDate)}',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      if (loan.status == 'Approved' && loan.emiAmount > 0) ...[
                        const SizedBox(height: 4),
                        Text(
                          'EMI: \$${_formatAmount(loan.emiAmount.toStringAsFixed(0))} / month',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                // Amount and Status
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '\$${_formatAmount(loan.amount.toStringAsFixed(0))}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: statusBgColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        loan.status,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: statusTextColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 8),
                // Arrow Icon
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.grey.shade400,
                ),
              ],
            ),
            // Remaining Balance (for approved loans)
            if (loan.status == 'Approved' && remainingBalance > 0) ...[
              const SizedBox(height: 16),
              const Divider(height: 1),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Remaining Balance',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '\$${_formatAmount(remainingBalance.toStringAsFixed(0))}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Colors.grey.shade400,
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _formatAmount(String amount) {
    final number = double.tryParse(amount) ?? 0;
    return number
        .toStringAsFixed(0)
        .replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );
  }

  String _formatDateISO(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}
