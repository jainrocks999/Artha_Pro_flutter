enum InvestmentType { sip, lumpsum, fd, rd, ppf, swp,epf }

extension InvestmentTypeExtension on InvestmentType {
  String get title {
    switch (this) {
      case InvestmentType.sip:
        return 'SIP Calculator';
      case InvestmentType.lumpsum:
        return 'Lumpsum Calculator';
      case InvestmentType.fd:
        return 'FD Calculator';
      case InvestmentType.rd:
        return 'RD Calculator';
      case InvestmentType.ppf:
        return 'PPF Calculator';
      case InvestmentType.swp:
        return 'SWP Calculator';
      case InvestmentType.epf:
        return 'EPF Calculator';
    }
  }

  double get defaultRate {
    switch (this) {
      case InvestmentType.sip:
        return 12;
      case InvestmentType.lumpsum:
        return 12;
      case InvestmentType.swp:
        return 8;
      case InvestmentType.fd:
        return 7;
      case InvestmentType.rd:
        return 6;
      case InvestmentType.ppf:
        return 7;
      case InvestmentType.epf:
        return 8.25;
    }
  }

  double get defaultYears {
    switch (this) {
      case InvestmentType.sip:
        return 10;
      case InvestmentType.lumpsum:
        return 10;
      case InvestmentType.swp:
      case InvestmentType.fd:
        return 5;
      case InvestmentType.rd:
        return 5;
      case InvestmentType.ppf:
        return 15;
      case InvestmentType.epf:
        return 30;
    }
  }

  String get investmentLabel {
    switch (this) {
      case InvestmentType.sip:
        return 'Monthly Investment';
      case InvestmentType.swp:
      case InvestmentType.lumpsum:
        return 'Total Investment';
      case InvestmentType.fd:
        return 'Principal Amount';
      case InvestmentType.rd:
        return 'Monthly Deposit';
      case InvestmentType.ppf:
        return 'Yearly Investment';
      case InvestmentType.epf:
        return 'Monthly Salary(basic + Da)';
    }
  }

  String get withdrawalLabel {
    switch (this) {
      case InvestmentType.swp:
        return 'Withdrawal per month';
      case InvestmentType.sip:
      case InvestmentType.lumpsum:
      case InvestmentType.fd:
      case InvestmentType.rd:
      case InvestmentType.ppf:
      case InvestmentType.epf:
        return '';
    }
  }

  double get minAmount {
    switch (this) {
      case InvestmentType.sip:
        return 1000;
      case InvestmentType.rd:
        return 500;
      case InvestmentType.lumpsum:
        return 10000;
      case InvestmentType.swp:
      case InvestmentType.fd:
        return 10000;
      case InvestmentType.ppf:
        return 500;
      case InvestmentType.epf:
        return 1000;
    }
  }

  double get maxAmount {
    switch (this) {
      case InvestmentType.sip:
      case InvestmentType.rd:
        return 100000;
      case InvestmentType.lumpsum:
      case InvestmentType.fd:
      case InvestmentType.swp:
        return 10000000;
      case InvestmentType.ppf:
        return 150000;
      case InvestmentType.epf:
        return 500000;
    }
  }

  int get maxLength {
    switch (this) {
      case InvestmentType.sip:
      case InvestmentType.rd:
        return 6;
      case InvestmentType.lumpsum:
      case InvestmentType.swp:
      case InvestmentType.fd:
        return 8;
      case InvestmentType.epf:
      case InvestmentType.ppf:
        return 6;
    }
  }

  String get minLabel {
    switch (this) {
      case InvestmentType.sip:
      case InvestmentType.epf:
        return '₹1K';
      case InvestmentType.rd:
        return '₹500';
      case InvestmentType.lumpsum:
      case InvestmentType.swp:
      case InvestmentType.fd:
        return '₹10K';
      case InvestmentType.ppf:
        return '₹500';
    }
  }

  String get maxLabel {
    switch (this) {
      case InvestmentType.sip:
      case InvestmentType.rd:
        return '₹1L';
      case InvestmentType.lumpsum:
      case InvestmentType.swp:
      case InvestmentType.fd:
        return '₹1Cr';
      case InvestmentType.ppf:
        return '₹1.5L';
      case InvestmentType.epf:
        return '₹5L';
    }
  }

  double get minRate {
    switch (this) {
      case InvestmentType.sip:
      case InvestmentType.lumpsum:
      case InvestmentType.swp:
        return 1;
      case InvestmentType.rd:
      case InvestmentType.fd:
      case InvestmentType.ppf:
        return 3;
      case InvestmentType.epf:
        return 8.25;
    }
  }

  double get maxRate {
    switch (this) {
      case InvestmentType.sip:
      case InvestmentType.lumpsum:
      case InvestmentType.swp:
        return 30;
      case InvestmentType.rd:
      case InvestmentType.fd:
      case InvestmentType.ppf:
        return 10;
      case InvestmentType.epf:
        return 8.25;
    }
  }

  double get minYears {
    switch (this) {
      case InvestmentType.ppf:
        return 15;
      case InvestmentType.fd:
      case InvestmentType.rd:
        return 1;
      case InvestmentType.sip:
      case InvestmentType.swp:
      case InvestmentType.lumpsum:
        return 1;
        case InvestmentType.epf:
        return 15;
    }
  }

  double get maxYears {
    switch (this) {
      case InvestmentType.ppf:
        return 15;
      case InvestmentType.fd:
      case InvestmentType.rd:
        return 10;
      case InvestmentType.swp:
        return 30;
      case InvestmentType.sip:
      case InvestmentType.lumpsum:
        return 40;
        case InvestmentType.epf:
        return 58;
    }
  }

  String get tenureLable {
    switch (this) {
      case InvestmentType.ppf:
        return 'PPF Tenure (Yrs)';
      case InvestmentType.fd:
        return 'FD Tenure (Yrs)';
      case InvestmentType.rd:
        return 'RD Tenure (Yrs)';
      case InvestmentType.sip:
      case InvestmentType.swp:
      case InvestmentType.lumpsum:
        return 'Investment Period (Yrs)';
        case InvestmentType.epf:
        return "Your Age";
    }
  }
}
