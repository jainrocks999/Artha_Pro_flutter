class IncomeTaxCalculator {
  final bool isNewRegime;
  final bool isMetro;
  final bool daIncludedInRetirement; // 🔥 IMPORTANT FIX
  final String ageGroup;
  final String assessmentYear;

  // Income
  final double grossSalary;
  final double otherIncome;
  final double interestIncome;
  final double letOutIncome;
  final double hlInterestSO;
  final double hlInterestLO;

  // Deductions
  final double deduction80C;
  final double nps;
  final double mediclaim;
  final double donation;
  final double savingsInterest;
  final double eduLoan;

  // HRA
  final double basicSalary;
  final double da;
  final double hraReceived;
  final double annualRent;

  IncomeTaxCalculator({
    required this.isNewRegime,
    required this.isMetro,
    required this.daIncludedInRetirement,
    required this.ageGroup,
    required this.assessmentYear,
    required this.grossSalary,
    required this.otherIncome,
    required this.interestIncome,
    required this.letOutIncome,
    required this.hlInterestSO,
    required this.hlInterestLO,
    required this.deduction80C,
    required this.nps,
    required this.mediclaim,
    required this.donation,
    required this.savingsInterest,
    required this.eduLoan,
    required this.basicSalary,
    required this.da,
    required this.hraReceived,
    required this.annualRent,
  });

  TaxResult calculate() {
    double housePropertyIncome = 0;

    if (!isNewRegime) {
      housePropertyIncome -= hlInterestSO.clamp(0, 200000);
    }

    double letOutNet = letOutIncome - hlInterestLO;

    if (!isNewRegime) {
      housePropertyIncome += letOutNet;

      if (housePropertyIncome < -200000) {
        housePropertyIncome = -200000;
      }
    } else {
      if (letOutNet > 0) {
        housePropertyIncome += letOutNet;
      }
    }

    double grossIncome =
        grossSalary + otherIncome + interestIncome + housePropertyIncome;
    double standardDeduction = grossSalary > 0
        ? (isNewRegime ? 75000 : 50000)
        : 0;
    double hraExemption = isNewRegime ? 0 : _calculateHRA();

    double chapter80 = 0;
    if (!isNewRegime) {
      chapter80 =
          deduction80C.clamp(0, 150000) +
          nps.clamp(0, 50000) +
          mediclaim.clamp(0, 25000) +
          donation +
          savingsInterest.clamp(0, 10000) +
          eduLoan;
    }

    double taxableIncome =
        grossIncome - (standardDeduction + hraExemption + chapter80);
    if (taxableIncome < 0) taxableIncome = 0;

    double tax = isNewRegime
        ? _calculateNewRegimeTax(taxableIncome)
        : _calculateOldRegimeTax(taxableIncome);
    tax = tax * 1.04;

    double salaryIncome = grossSalary - standardDeduction - hraExemption;
    if (salaryIncome < 0) salaryIncome = 0;

    return TaxResult(
      totalIncome: grossIncome,
      totalDeductions: chapter80 + standardDeduction + hraExemption,
      hraExemption: hraExemption,
      taxableIncome: taxableIncome,
      taxPayable: double.parse(tax.toStringAsFixed(0)),
    );
  }

  // ===============================
  // HRA CALCULATION (FIXED)
  // ===============================

  double _calculateHRA() {
    final salary = basicSalary + (daIncludedInRetirement ? da : 0);

    final percentLimit = isMetro ? salary * 0.5 : salary * 0.4;
    final rentMinusTenPercent = annualRent - (salary * 0.1);

    final values = [
      hraReceived,
      percentLimit,
      rentMinusTenPercent > 0 ? rentMinusTenPercent : 0.0,
    ];

    values.sort();
    return values.first;
  }

  // ===============================
  // OLD REGIME TAX (AY 2025-26)
  // ===============================

  double _calculateOldRegimeTax(double income) {
    double tax = 0;

    double basicExemption;

    if (ageGroup == '60to80') {
      basicExemption = 300000;
    } else if (ageGroup == 'above80') {
      basicExemption = 500000;
    } else {
      basicExemption = 250000;
    }

    if (income <= basicExemption) return 0;

    if (income <= 500000) {
      tax += (income - basicExemption) * 0.05;
    } else if (income <= 1000000) {
      tax += (500000 - basicExemption) * 0.05;
      tax += (income - 500000) * 0.20;
    } else {
      tax += (500000 - basicExemption) * 0.05;
      tax += 500000 * 0.20;
      tax += (income - 1000000) * 0.30;
    }

    // Rebate u/s 87A (Old regime)
    if (income <= 500000) {
      return 0;
    }

    return tax;
  }

  // ===============================
  // NEW REGIME TAX (AY 2025-26)
  // ===============================

  double _calculateNewRegimeTax(double income) {
    double tax = 0;

    // Rebate u/s 87A (New regime)
    if (income <= 700000) return 0;

    if (income <= 300000) return 0;

    if (income <= 700000) {
      tax = (income - 300000) * 0.05;
    } else if (income <= 1000000) {
      tax = 400000 * 0.05;
      tax += (income - 700000) * 0.10;
    } else if (income <= 1200000) {
      tax = 400000 * 0.05;
      tax += 300000 * 0.10;
      tax += (income - 1000000) * 0.15;
    } else if (income <= 1500000) {
      tax = 400000 * 0.05;
      tax += 300000 * 0.10;
      tax += 200000 * 0.15;
      tax += (income - 1200000) * 0.20;
    } else {
      tax = 400000 * 0.05;
      tax += 300000 * 0.10;
      tax += 200000 * 0.15;
      tax += 300000 * 0.20;
      tax += (income - 1500000) * 0.30;
    }

    return tax;
  }
}

class TaxResult {
  final double totalIncome;
  final double totalDeductions;
  final double hraExemption;
  final double taxableIncome;
  final double taxPayable;

  TaxResult({
    required this.totalIncome,
    required this.totalDeductions,
    required this.hraExemption,
    required this.taxableIncome,
    required this.taxPayable,
  });
}
