class Loan {
  final String id;
  final String type;
  final double amount;
  final DateTime appliedDate;
  final String status; // Approved, Pending, Rejected
  final double interestRate;
  final int tenureMonths;
  final double emiAmount;
  final DateTime? nextPaymentDate;

  Loan({
    required this.id,
    required this.type,
    required this.amount,
    required this.appliedDate,
    required this.status,
    this.interestRate = 8.5,
    this.tenureMonths = 60,
    this.emiAmount = 0,
    this.nextPaymentDate,
  });
}

class Repayment {
  final String id;
  final String loanId;
  final double amount;
  final DateTime paymentDate;
  final String status; // Paid, Pending, Overdue

  Repayment({
    required this.id,
    required this.loanId,
    required this.amount,
    required this.paymentDate,
    required this.status,
  });
}








