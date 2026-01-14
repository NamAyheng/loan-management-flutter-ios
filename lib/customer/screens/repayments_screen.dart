import 'package:flutter/material.dart';
import 'payment_detail_screen.dart';

class RepaymentsScreen extends StatefulWidget {
  const RepaymentsScreen({super.key});

  @override
  State<RepaymentsScreen> createState() => _RepaymentsScreenState();
}

class _RepaymentsScreenState extends State<RepaymentsScreen>
    with SingleTickerProviderStateMixin {
  String _selectedTab = 'All Loans';
  final List<String> _tabs = ['All Loans', 'Personal Loan', 'Home Loan'];
  
  late AnimationController _animationController;
  late Animation<double> _progressAnimation;
  
  double _animatedPaidAmount = 0;
  double _animatedTotalAmount = 0;
  double _animatedRemainingAmount = 0;
  int _animatedPaidEMIs = 0;
  int _animatedTotalEMIs = 0;

  // Sample data for different loan types
  final Map<String, Map<String, dynamic>> _loanData = {
    'All Loans': {
      'nextPaymentDue': 50400,
      'paidAmount': 40000,
      'totalAmount': 90000,
      'paidEMIs': 3,
      'totalEMIs': 6,
      'remainingAmount': 50400,
    },
    'Personal Loan': {
      'nextPaymentDue': 30400,
      'paidAmount': 30000,
      'totalAmount': 60000,
      'paidEMIs': 2,
      'totalEMIs': 4,
      'remainingAmount': 30400,
    },
    'Home Loan': {
      'nextPaymentDue': 20000,
      'paidAmount': 10000,
      'totalAmount': 30000,
      'paidEMIs': 1,
      'totalEMIs': 2,
      'remainingAmount': 20000,
    },
  };

  final List<Map<String, dynamic>> _paymentHistory = [
    {
      'month': 'December 2023',
      'dueDate': '2023-12-25',
      'amount': 20400,
      'status': 'Overdue',
      'loanType': 'Personal Loan',
    },
    {
      'month': 'January 2026',
      'dueDate': '2026-01-25',
      'amount': 10000,
      'status': 'Upcoming',
      'loanType': 'Personal Loan',
    },
    {
      'month': 'January 2026',
      'dueDate': '2026-01-25',
      'amount': 20000,
      'status': 'Upcoming',
      'loanType': 'Home Loan',
    },
    {
      'month': 'November 2023',
      'dueDate': '2023-11-25',
      'amount': 10000,
      'status': 'Paid',
      'loanType': 'Personal Loan',
    },
    {
      'month': 'November 2023',
      'dueDate': '2023-11-25',
      'amount': 20000,
      'status': 'Paid',
      'loanType': 'Personal Loan',
    },
    {
      'month': 'December 2023',
      'dueDate': '2023-12-25',
      'amount': 10000,
      'status': 'Paid',
      'loanType': 'Home Loan',
    },
  ];

  List<Map<String, dynamic>> get _filteredPaymentHistory {
    if (_selectedTab == 'All Loans') {
      return _paymentHistory;
    }
    return _paymentHistory
        .where((payment) => payment['loanType'] == _selectedTab)
        .toList();
  }

  Map<String, dynamic> get _currentLoanData {
    return _loanData[_selectedTab] ?? _loanData['All Loans']!;
  }

  double get _nextPaymentDue => (_currentLoanData['nextPaymentDue'] as num).toDouble();
  double get _paidAmount => (_currentLoanData['paidAmount'] as num).toDouble();
  double get _totalAmount => (_currentLoanData['totalAmount'] as num).toDouble();
  int get _paidEMIs => _currentLoanData['paidEMIs'] as int;
  int get _totalEMIs => _currentLoanData['totalEMIs'] as int;
  double get _remainingAmount => (_currentLoanData['remainingAmount'] as num).toDouble();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _progressAnimation = Tween<double>(
      begin: 0.0,
      end: _paidAmount / _totalAmount,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    
    _updateAnimatedValues();
    _animationController.forward();
  }

  @override
  void didUpdateWidget(RepaymentsScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget != widget) {
      _updateAnimatedValues();
    }
  }

  void _updateAnimatedValues() {
    _animationController.reset();
    _progressAnimation = Tween<double>(
      begin: _progressAnimation.value,
      end: _paidAmount / _totalAmount,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    
    _animationController.forward();
    
    // Update animated values immediately for smooth transition
    setState(() {
      _animatedPaidAmount = _paidAmount;
      _animatedTotalAmount = _totalAmount;
      _animatedRemainingAmount = _remainingAmount;
      _animatedPaidEMIs = _paidEMIs;
      _animatedTotalEMIs = _totalEMIs;
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            if (Navigator.of(context).canPop()) {
              Navigator.pop(context);
            }
          },
        ),
        title: const Text(
          'Repayments',
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tabs
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Row(
                  children: _tabs.map((tab) {
                    final isSelected = _selectedTab == tab;
                    
                    return Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedTab = tab;
                          });
                          _updateAnimatedValues();
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 8),
                          padding: const EdgeInsets.symmetric(vertical: 12),
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
                            tab,
                            textAlign: TextAlign.center,
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

              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Next Payment Due Card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFF10B981),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Next Payment Due',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withOpacity(0.9),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '\$${_formatAmount(_nextPaymentDue.toStringAsFixed(0))}',
                                    style: const TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Due: $_selectedTab',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white.withOpacity(0.9),
                                    ),
                                  ),
                                ],
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Payment feature coming soon!'),
                                      backgroundColor: Color(0xFF10B981),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 12,
                                  ),
                                ),
                                child: const Text(
                                  'Pay',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF10B981),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Loan Progress Section
                    const Text(
                      'Loan Progress',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.grey.shade200,
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Paid',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black87,
                                ),
                              ),
                              TweenAnimationBuilder<double>(
                                tween: Tween<double>(
                                  begin: _animatedPaidAmount,
                                  end: _paidAmount,
                                ),
                                duration: const Duration(milliseconds: 800),
                                curve: Curves.easeOut,
                                builder: (context, paidValue, child) {
                                  return TweenAnimationBuilder<double>(
                                    tween: Tween<double>(
                                      begin: _animatedTotalAmount,
                                      end: _totalAmount,
                                    ),
                                    duration: const Duration(milliseconds: 800),
                                    curve: Curves.easeOut,
                                    builder: (context, totalValue, child) {
                                      return Text(
                                        '\$${_formatAmount(paidValue.toStringAsFixed(0))} / \$${_formatAmount(totalValue.toStringAsFixed(0))}',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          AnimatedBuilder(
                            animation: _progressAnimation,
                            builder: (context, child) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: LinearProgressIndicator(
                                  value: _progressAnimation.value,
                                  minHeight: 8,
                                  backgroundColor: Colors.grey.shade300,
                                  valueColor: const AlwaysStoppedAnimation<Color>(
                                    Color(0xFF10B981),
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TweenAnimationBuilder<int>(
                                tween: IntTween(
                                  begin: _animatedPaidEMIs,
                                  end: _paidEMIs,
                                ),
                                duration: const Duration(milliseconds: 600),
                                curve: Curves.easeOut,
                                builder: (context, paidEMIValue, child) {
                                  return TweenAnimationBuilder<int>(
                                    tween: IntTween(
                                      begin: _animatedTotalEMIs,
                                      end: _totalEMIs,
                                    ),
                                    duration: const Duration(milliseconds: 600),
                                    curve: Curves.easeOut,
                                    builder: (context, totalEMIValue, child) {
                                      return Text(
                                        '$paidEMIValue of $totalEMIValue EMIs paid',
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey.shade700,
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                              TweenAnimationBuilder<double>(
                                tween: Tween<double>(
                                  begin: _animatedRemainingAmount,
                                  end: _remainingAmount,
                                ),
                                duration: const Duration(milliseconds: 800),
                                curve: Curves.easeOut,
                                builder: (context, remainingValue, child) {
                                  return Text(
                                    'Remaining: \$${_formatAmount(remainingValue.toStringAsFixed(0))}',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey.shade700,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Payment History Section
                    const Text(
                      'Payment History',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Payment History List
                    ..._filteredPaymentHistory.map((payment) => _buildPaymentHistoryCard(payment)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentHistoryCard(Map<String, dynamic> payment) {
    final status = payment['status'] as String;
    Color iconColor;
    Color iconBgColor;
    IconData icon;
    Color statusColor;
    Color statusBgColor;
    bool isPaid = status == 'Paid';

    if (status == 'Paid') {
      iconColor = const Color(0xFF10B981);
      iconBgColor = const Color(0xFF10B981).withOpacity(0.15);
      icon = Icons.check;
      statusColor = const Color(0xFF10B981);
      statusBgColor = const Color(0xFF10B981).withOpacity(0.15);
    } else if (status == 'Overdue') {
      iconColor = Colors.white;
      iconBgColor = Colors.red;
      icon = Icons.credit_card_outlined;
      statusColor = Colors.red;
      statusBgColor = Colors.transparent;
    } else {
      // Upcoming
      iconColor = Colors.white;
      iconBgColor = Colors.orange;
      icon = Icons.credit_card_outlined;
      statusColor = Colors.orange;
      statusBgColor = Colors.transparent;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PaymentDetailScreen(payment: payment),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.grey.shade200,
              width: 1,
            ),
          ),
          child: Row(
          children: [
            // Icon
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: iconBgColor,
                borderRadius: isPaid
                    ? BorderRadius.circular(24) // Circle for paid
                    : BorderRadius.circular(8), // Square for overdue/upcoming
              ),
              child: Icon(
                icon,
                color: iconColor,
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
                    payment['month'] as String,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Due: ${payment['dueDate']}',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  if (status == 'Overdue') ...[
                    const SizedBox(height: 4),
                    Text(
                      'Overdue Fee Applied',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.red,
                        fontWeight: FontWeight.w500,
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
                  '\$${_formatAmount((payment['amount'] as num).toStringAsFixed(0))}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                if (isPaid) ...[
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: statusBgColor,
                      borderRadius: BorderRadius.circular(12),
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
              ],
            ),
          ],
        ),
        ),
      ),
    );
  }

  String _formatAmount(String amount) {
    final number = double.tryParse(amount) ?? 0;
    return number.toStringAsFixed(0).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }
}
