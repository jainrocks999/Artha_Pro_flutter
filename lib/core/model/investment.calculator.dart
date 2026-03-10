import 'dart:math';
import 'package:artha_pro_app/core/utils/intestment_type.dart';

class InvestmentResult {
  final double totalInvested;
  final double estimatedReturns;
  final double maturityValue;

  InvestmentResult({
    required this.totalInvested,
    required this.estimatedReturns,
    required this.maturityValue,
  });
}

class InvestmentCalculator {
  static InvestmentResult calculate({
    required InvestmentType type,
    required double amount,
    required double annualRate,
    required double years,
  }) {
    double futureValue = 0;
    double invested = 0;

    int totalMonths = (years * 12).toInt();
    double rate = annualRate / 100;

    switch (type) {
      case InvestmentType.sip:
        double monthlyRate = rate / 12;
        futureValue =
            amount *
            ((pow(1 + monthlyRate, totalMonths) - 1) / monthlyRate) *
            (1 + monthlyRate);
        invested = amount * totalMonths;
        break;
      case InvestmentType.lumpsum:
        futureValue = amount * pow(1 + rate, years);
        invested = amount;
        break;
      case InvestmentType.fd:
        int n = 4;
        futureValue = amount * pow((1 + rate / n), n * years);
        invested = amount;
        break;
      case InvestmentType.rd:
        const int n = 4;
        final double quarterlyRate = rate / n;
        final double totalQuarters = years * n;

        futureValue =
            amount *
            (pow(1 + quarterlyRate, totalQuarters) - 1) /
            (1 - pow(1 + quarterlyRate, -1 / 3));

        invested = amount * totalMonths;
        break;
      case InvestmentType.ppf:
        double balance = 0;
        for (int i = 0; i < years; i++) {
          balance += amount;
          balance += balance * rate;
        }
        futureValue = balance;
        invested = amount * years;
        break;
    }
    return InvestmentResult(
      totalInvested: invested,
      maturityValue: futureValue,
      estimatedReturns: futureValue - invested,
    );
  }
}
