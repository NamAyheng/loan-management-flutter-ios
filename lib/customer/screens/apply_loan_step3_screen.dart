import 'package:flutter/material.dart';
import 'apply_loan_step4_screen.dart';

class ApplyLoanStep3Screen extends StatefulWidget {
  final String loanAmount;
  final String loanType;
  final int duration;
  final double interestRate;
  final double estimatedEMI;

  const ApplyLoanStep3Screen({
    super.key,
    required this.loanAmount,
    required this.loanType,
    required this.duration,
    required this.interestRate,
    required this.estimatedEMI,
  });

  @override
  State<ApplyLoanStep3Screen> createState() => _ApplyLoanStep3ScreenState();
}

class _ApplyLoanStep3ScreenState extends State<ApplyLoanStep3Screen> {
  final Map<String, bool> _uploadedDocuments = {
    'Identity Proof': false,
    'Address Proof': false,
    'Income Proof': false,
    'Bank Statements': false,
  };

  void _uploadDocument(String documentName) {
    setState(() {
      _uploadedDocuments[documentName] = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$documentName uploaded successfully'),
        backgroundColor: const Color(0xFF34C77B),
      ),
    );
  }

  bool get _allDocumentsUploaded {
    return _uploadedDocuments.values.every((uploaded) => uploaded);
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
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                
                // Progress Bar
                _buildProgressBar(3),
                
                const SizedBox(height: 40),
                
                // Document Checklist Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.2),
                      width: 1,
                    ),
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
                      // Card Title
                      const Text(
                        'Document Checklist',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      
                      const SizedBox(height: 8),
                      
                      // Card Subtitle
                      Text(
                        'Upload all required documents',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                          height: 1.4,
                        ),
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Document Items
                      _buildDocumentItem('Identity Proof'),
                      const SizedBox(height: 12),
                      _buildDocumentItem('Address Proof'),
                      const SizedBox(height: 12),
                      _buildDocumentItem('Income Proof'),
                      const SizedBox(height: 12),
                      _buildDocumentItem('Bank Statements'),
                    ],
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // View Summary Link
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.arrow_back,
                        size: 16,
                        color: Colors.grey.shade700,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'View Summary',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 40),
                
                // Submit Application Button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _allDocumentsUploaded
                        ? () {
                            // Navigate to Step 4 (Application Status)
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ApplyLoanStep4Screen(
                                  loanAmount: widget.loanAmount,
                                  loanType: widget.loanType,
                                  duration: widget.duration,
                                  interestRate: widget.interestRate,
                                  estimatedEMI: widget.estimatedEMI,
                                  applicationId: '0001',
                                  appliedDate: DateTime.now(),
                                ),
                              ),
                            );
                          }
                        : () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please upload all required documents'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF34C77B),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Submit Application',
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

  Widget _buildDocumentItem(String documentName) {
    final isUploaded = _uploadedDocuments[documentName] ?? false;
    
    return Container(
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
          // Document Icon
          Icon(
            Icons.description_outlined,
            color: Colors.grey.shade600,
            size: 24,
          ),
          
          const SizedBox(width: 16),
          
          // Document Name
          Expanded(
            child: Text(
              documentName,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isUploaded ? const Color(0xFF34C77B) : Colors.black87,
              ),
            ),
          ),
          
          const SizedBox(width: 12),
          
          // Upload Button
          if (!isUploaded)
            OutlinedButton.icon(
              onPressed: () => _uploadDocument(documentName),
              icon: Icon(
                Icons.upload_outlined,
                size: 16,
                color: Colors.grey.shade700,
              ),
              label: const Text(
                'Upload',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                  color: Colors.grey.shade300,
                  width: 1,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                backgroundColor: Colors.white,
              ),
            )
          else
            Row(
              children: [
                Icon(
                  Icons.check_circle,
                  color: const Color(0xFF34C77B),
                  size: 20,
                ),
                const SizedBox(width: 6),
                Text(
                  'Uploaded',
                  style: TextStyle(
                    fontSize: 14,
                    color: const Color(0xFF34C77B),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
        ],
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
                ? const Color(0xFF34C77B)
                : Colors.grey.shade300,
          ),
        ),
        _buildStepIndicator(2, currentStep >= 2),
        Expanded(
          child: Container(
            height: 2,
            color: currentStep >= 3
                ? const Color(0xFF34C77B)
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
        color: isActive
            ? const Color(0xFF34C77B)
            : Colors.grey.shade300,
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

