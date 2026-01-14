import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_loan_management/theme/colors.dart';
import 'apply_loan_step2_screen.dart';

class ApplyLoanScreen extends StatefulWidget {
  const ApplyLoanScreen({super.key});

  @override
  State<ApplyLoanScreen> createState() => _ApplyLoanScreenState();
}

class _ApplyLoanScreenState extends State<ApplyLoanScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _amountController = TextEditingController();

  String _selectedLoanType = 'Personal Loan';
  int? _selectedDuration;

  final List<String> _loanTypes = [
    'Personal Loan',
    'Home Loan',
    'Car Loan',
    'Education Loan',
    'Business Loan',
  ];

  final List<int> _durations = [6, 12, 24, 36, 48, 60];

  @override
  void initState() {
    super.initState();
    _selectedDuration = 12; // Default selection
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _selectQuickAmount(String amount) {
    setState(() {
      // Convert $10K to 10000, $50K to 50000, $100K to 100000
      if (amount == '\$10K') {
        _amountController.text = '10000';
      } else if (amount == '\$50K') {
        _amountController.text = '50000';
      } else if (amount == '\$100K') {
        _amountController.text = '100000';
      }
    });
  }

  double _calculateEMI(double principal, double annualRate, int months) {
    if (annualRate == 0) return principal / months;

    final monthlyRate = annualRate / 12 / 100;
    final emi =
        principal *
        monthlyRate *
        pow(1 + monthlyRate, months) /
        (pow(1 + monthlyRate, months) - 1);

    return emi;
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
          'Apply for Loan',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),

                  // Progress Bar
                  _buildProgressBar(1),

                  const SizedBox(height: 40),

                  // Loan Amount Section
                  const Text(
                    'Loan Amount',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      hintText: 'Enter amount',
                      hintStyle: TextStyle(
                        color: Colors.grey.shade400,
                        fontSize: 14,
                      ),
                      prefixIcon: const Icon(
                        Icons.attach_money,
                        color: Colors.grey,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.grey.shade300,
                          width: 1,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.grey.shade300,
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: ThemeColors.primary1,
                          width: 2,
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade50,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter loan amount';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  // Quick Selection Buttons
                  Row(
                    children: [
                      Expanded(child: _buildQuickAmountButton('\$10K')),
                      const SizedBox(width: 12),
                      Expanded(child: _buildQuickAmountButton('\$50K')),
                      const SizedBox(width: 12),
                      Expanded(child: _buildQuickAmountButton('\$100K')),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // Loan Type Section
                  const Text(
                    'Loan Type',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300, width: 1),
                    ),
                    child: DropdownButton<String>(
                      value: _selectedLoanType,
                      isExpanded: true,
                      underline: const SizedBox(),
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.grey.shade600,
                      ),
                      items: _loanTypes.map((String type) {
                        return DropdownMenuItem<String>(
                          value: type,
                          child: Text(
                            type,
                            style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 14,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            _selectedLoanType = newValue;
                          });
                        }
                      },
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Loan Duration Section
                  const Text(
                    'Loan Duration (Months)',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Duration Grid
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 2.2,
                        ),
                    itemCount: _durations.length,
                    itemBuilder: (context, index) {
                      final duration = _durations[index];
                      final isSelected = _selectedDuration == duration;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedDuration = duration;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: isSelected
                                ? ThemeColors.primary1
                                : Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isSelected
                                  ? ThemeColors.primary1
                                  : Colors.grey.shade300,
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.access_time,
                                color: isSelected
                                    ? Colors.white
                                    : Colors.grey.shade600,
                                size: 18,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                '$duration',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 40),

                  // Continue Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate() &&
                            _selectedDuration != null) {
                          // Calculate EMI
                          final amount =
                              double.tryParse(_amountController.text) ?? 0;
                          const interestRate = 12.0; // 12% p.a.
                          final emi = _calculateEMI(
                            amount,
                            interestRate,
                            _selectedDuration!,
                          );

                          // Navigate to step 2
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ApplyLoanStep2Screen(
                                loanAmount: _amountController.text,
                                loanType: _selectedLoanType,
                                duration: _selectedDuration!,
                                interestRate: interestRate,
                                estimatedEMI: emi,
                              ),
                            ),
                          );
                        } else if (_selectedDuration == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please select loan duration'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ThemeColors.primary1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Continue',
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
      ),
    );
  }

  Widget _buildQuickAmountButton(String label) {
    return OutlinedButton(
      onPressed: () => _selectQuickAmount(label),
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: Colors.grey.shade300, width: 1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(vertical: 12),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildProgressBar(int currentStep) {
    return Row(
      children: [
        _buildStepIndicator(1, currentStep >= 1),
        Expanded(
          child: Container(
            height: 2,
            color: currentStep >= 2
                ? ThemeColors.primary1
                : Colors.grey.shade300,
          ),
        ),
        _buildStepIndicator(2, currentStep >= 2),
        Expanded(
          child: Container(
            height: 2,
            color: currentStep >= 3
                ? ThemeColors.primary1
                : Colors.grey.shade300,
          ),
        ),
        _buildStepIndicator(3, currentStep >= 3),
      ],
    );
  }

  Widget _buildStepIndicator(int stepNumber, bool isActive) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? ThemeColors.primary1 : Colors.grey.shade300,
      ),
      child: Center(
        child: Text(
          '$stepNumber',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: isActive ? Colors.white : Colors.grey.shade600,
          ),
        ),
      ),
    );
  }
}
