import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_loan_management/customer/main_customer/main_customer_screen.dart';

import 'apply_loan_screen.dart';

class EMICalculatorScreen extends StatefulWidget {
  const EMICalculatorScreen({super.key});

  @override
  State<EMICalculatorScreen> createState() => _EMICalculatorScreenState();
}

class _EMICalculatorScreenState extends State<EMICalculatorScreen> {
  double _loanAmount = 100000;
  double _interestRate = 12.0;
  double _tenureMonths = 12.0;

  double _emiAmount = 0;
  double _totalInterest = 0;
  double _totalAmount = 0;
  double _principalAmount = 0;

  @override
  void initState() {
    super.initState();
    _calculateEMI();
  }

  void _calculateEMI() {
    _principalAmount = _loanAmount;
    final monthlyRate = _interestRate / 12 / 100;

    if (monthlyRate > 0 && _tenureMonths > 0) {
      final emi =
          _loanAmount *
          monthlyRate *
          pow(1 + monthlyRate, _tenureMonths.toInt()) /
          (pow(1 + monthlyRate, _tenureMonths.toInt()) - 1);

      setState(() {
        _emiAmount = emi;
        _totalAmount = emi * _tenureMonths.toInt();
        _totalInterest = _totalAmount - _loanAmount;
      });
    } else {
      setState(() {
        _emiAmount = _loanAmount / _tenureMonths.toInt();
        _totalAmount = _loanAmount;
        _totalInterest = 0;
      });
    }
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
          'EMI Calculator',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Loan Amount Slider
                _buildSliderSection(
                  label: '\$ Loan Amount',
                  value: _loanAmount,
                  min: 10000,
                  max: 1000000,
                  onChanged: (value) {
                    setState(() {
                      _loanAmount = value;
                      _calculateEMI();
                    });
                  },
                  minLabel: '\$10K',
                  maxLabel: '\$10L',
                ),

                const SizedBox(height: 32),

                // Interest Rate Slider
                _buildSliderSection(
                  label: '% Interest Rate (p.a.)',
                  value: _interestRate,
                  min: 5.0,
                  max: 30.0,
                  onChanged: (value) {
                    setState(() {
                      _interestRate = value;
                      _calculateEMI();
                    });
                  },
                  minLabel: '5%',
                  maxLabel: '30%',
                ),

                const SizedBox(height: 32),

                // Loan Tenure Slider
                _buildSliderSection(
                  label: 'Loan Tenure (Months)',
                  value: _tenureMonths,
                  min: 3.0,
                  max: 60.0,
                  onChanged: (value) {
                    setState(() {
                      _tenureMonths = value;
                      _calculateEMI();
                    });
                  },
                  minLabel: '3 months',
                  maxLabel: '60 months',
                  showClockIcon: true,
                ),

                const SizedBox(height: 40),

                // Monthly EMI Button
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF10B981), Color(0xFF059669)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Your Monthly EMI',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '\$${_formatAmount(_emiAmount.toStringAsFixed(0))}',
                        style: const TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                // Loan Breakdown Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
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
                      // Title
                      const Text(
                        'Loan Breakdown',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Principal Amount
                      _buildBreakdownRow(
                        'Principal Amount',
                        '\$${_formatAmount(_principalAmount.toStringAsFixed(0))}',
                        Colors.black87,
                      ),
                      _buildDivider(),

                      // Total Interest
                      _buildBreakdownRow(
                        'Total Interest',
                        '\$${_formatAmount(_totalInterest.toStringAsFixed(0))}',
                        Colors.orange,
                      ),
                      _buildDivider(),

                      // Total Amount Payable
                      _buildBreakdownRow(
                        'Total Amount Payable',
                        '\$${_formatAmount(_totalAmount.toStringAsFixed(0))}',
                        const Color(0xFF10B981),
                        isBold: true,
                      ),

                      const SizedBox(height: 24),

                      // Progress Bar
                      _buildProgressBar(),

                      const SizedBox(height: 16),

                      // Legend
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 12,
                                height: 12,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF10B981),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Principal',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                width: 12,
                                height: 12,
                                decoration: const BoxDecoration(
                                  color: Colors.orange,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Interest',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Apply for This Loan Button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ApplyLoanScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF10B981),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Apply for This Loan',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSliderSection({
    required String label,
    required double value,
    required double min,
    required double max,
    required ValueChanged<double> onChanged,
    required String minLabel,
    required String maxLabel,
    bool showClockIcon = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                if (showClockIcon) ...[
                  const Icon(Icons.access_time, size: 18, color: Colors.grey),
                  const SizedBox(width: 4),
                ],
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
            Text(
              label.contains('Amount')
                  ? '\$${_formatAmount(value.toStringAsFixed(0))}'
                  : label.contains('Rate')
                  ? '${value.toStringAsFixed(0)}%'
                  : '${value.toInt()} months',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF10B981),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: const Color(0xFF10B981),
            inactiveTrackColor: Colors.grey.shade300,
            thumbColor: Colors.white,
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
            overlayShape: const RoundSliderOverlayShape(overlayRadius: 20),
            trackHeight: 4,
          ),
          child: Slider(
            value: value,
            min: min,
            max: max,
            divisions: (max - min).toInt(),
            onChanged: onChanged,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              minLabel,
              style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
            ),
            Text(
              maxLabel,
              style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBreakdownRow(
    String label,
    String value,
    Color valueColor, {
    bool isBold = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: Colors.grey.shade700,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(height: 1, thickness: 1, color: Colors.grey.shade200);
  }

  Widget _buildProgressBar() {
    if (_totalAmount == 0) {
      return Container(
        height: 8,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(4),
        ),
      );
    }

    final principalRatio = _principalAmount / _totalAmount;
    final interestRatio = _totalInterest / _totalAmount;

    final principalPercent = (principalRatio * 100).toInt();
    final interestPercent = (interestRatio * 100).toInt();

    return Row(
      children: [
        Expanded(
          flex: principalPercent > 0 ? principalPercent : 1,
          child: Container(
            height: 8,
            decoration: BoxDecoration(
              color: const Color(0xFF10B981),
              borderRadius: interestPercent > 0
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(4),
                      bottomLeft: Radius.circular(4),
                    )
                  : BorderRadius.circular(4),
            ),
          ),
        ),
        if (interestPercent > 0)
          Expanded(
            flex: interestPercent,
            child: Container(
              height: 8,
              decoration: const BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(4),
                  bottomRight: Radius.circular(4),
                ),
              ),
            ),
          ),
      ],
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
}
