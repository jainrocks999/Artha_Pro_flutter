import 'dart:math';

class LoanCalculator {
  final double loanAmount;
  final double interestRate;
  final double tenureValue;
  final bool isMonthly;
  final double downpayment;
  final double processingFee;

  late final double principal;
  late final double emi;
  late final double totalInterest;
  late final double totalPayment;
  late final double processingFeeAmount;

  LoanCalculator({
    required this.loanAmount,
    required this.interestRate,
    required this.tenureValue,
    required this.isMonthly,
    required this.downpayment,
    required this.processingFee,
  }) {
    _calculate();
  }

  void _calculate() {  
   principal = loanAmount - downpayment;

    final monthlyRate = interestRate / 12 / 100;
    final months = isMonthly ? tenureValue.toInt() : (tenureValue * 12).toInt();

    processingFeeAmount = principal * (processingFee / 100);
    emi =
        principal *
        monthlyRate *
        pow(1 + monthlyRate, months) /
        (pow(1 + monthlyRate, months) - 1);
    totalInterest = (emi * months) - principal;
    totalPayment = (emi * months) + processingFeeAmount;
  }
}
