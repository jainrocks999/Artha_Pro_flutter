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
    double? withdrawal,
    double? contributeToEpe,
    double? annualIncreaseSalary,
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
      case InvestmentType.swp:
        double principal = amount;
        double annualRate = rate;
        double timeInYears = years;
        double monthlyWithdrawal = withdrawal ?? 0;

        int compoundingFrequency = 12;
        double monthlyRate = annualRate / compoundingFrequency;

        int totalMonths = (compoundingFrequency * timeInYears).toInt();

        double compoundFactor = pow(1 + monthlyRate, totalMonths).toDouble();

        double futureValue =
            (principal * compoundFactor) -
            (monthlyWithdrawal *
                (1 + monthlyRate) *
                ((compoundFactor - 1) / monthlyRate));
        double totalWithdrawn = monthlyWithdrawal * totalMonths;

        return InvestmentResult(
          totalInvested: principal,
          maturityValue: futureValue,
          estimatedReturns: totalWithdrawn,
        );
      case InvestmentType.epf:
        double monthlySalary = amount;
        double employeeContributionPercent = (contributeToEpe ?? 0) / 100;
        double annualInterestRate = annualRate / 100;
        double monthlyInterestRate = annualInterestRate / 12;
        double annualSalaryGrowth = (annualIncreaseSalary ?? 0) / 100;
        int currentAge = years.toInt();
        int retirementAge = 58;
        int remainingYears = retirementAge - currentAge;
        int totalMonths = remainingYears * 12;

        double epfBalance = 0;
        const double epsSalaryCap = 15000;

        double epsRate = 1 / 12;
        const double employerTotalRate = 0.12;

        for (int month = 1; month <= totalMonths; month++) {
          epfBalance = epfBalance * (1 + monthlyInterestRate);
          double employeeEpf = monthlySalary * employeeContributionPercent;

          double salaryForEps = monthlySalary > epsSalaryCap
              ? epsSalaryCap
              : monthlySalary;
          double epsContribution = salaryForEps * epsRate;

          double employerEpf =
              (monthlySalary * employerTotalRate) - epsContribution;
          double monthlyEpfContribution = employeeEpf + employerEpf;
          epfBalance += monthlyEpfContribution;

          if (month % 12 == 0) {
            monthlySalary = monthlySalary * (1 + annualSalaryGrowth);
          }
        }
        return InvestmentResult(
          totalInvested: epfBalance,
          estimatedReturns: 0,
          maturityValue: 0,
        );
    }

    return InvestmentResult(
      totalInvested: invested,
      maturityValue: futureValue,
      estimatedReturns: futureValue - invested,
    );
  }
}
