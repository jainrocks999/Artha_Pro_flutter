enum InvestmentType { sip, lumpsum, fd, rd, ppf }

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
    }
  }

  double get defaultRate {
    switch (this) {
      case InvestmentType.sip:
        return 12;
      case InvestmentType.lumpsum:
        return 12;
      case InvestmentType.fd:
        return 7;
      case InvestmentType.rd:
        return 6;
      case InvestmentType.ppf:
        return 7;
    }
  }

  double get defaultYears {
    switch (this) {
      case InvestmentType.sip:
        return 10;
      case InvestmentType.lumpsum:
        return 10;
      case InvestmentType.fd:
        return 5;
      case InvestmentType.rd:
        return 5;
      case InvestmentType.ppf:
        return 15;
    }
  }

  String get investmentLabel {
    switch (this) {
      case InvestmentType.sip:
        return 'Monthly Investment';
      case InvestmentType.lumpsum:
        return 'Total Investment';
      case InvestmentType.fd:
        return 'Principal Amount';
      case InvestmentType.rd:
        return 'Monthly Deposit';
      case InvestmentType.ppf:
        return 'Yearly Investment';
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
      case InvestmentType.fd:
        return 10000;
      case InvestmentType.ppf:
        return 500;
    }
  }

  double get maxAmount {
    switch (this) {
      case InvestmentType.sip:
      case InvestmentType.rd:
        return 100000;
      case InvestmentType.lumpsum:
      case InvestmentType.fd:
        return 10000000;
      case InvestmentType.ppf:
        return 150000;
    }
  }
  int get maxLength {
    switch (this) {
      case InvestmentType.sip:
      case InvestmentType.rd:
        return 6;
      case InvestmentType.lumpsum:
      case InvestmentType.fd:
        return 8;
      case InvestmentType.ppf:
        return 6;
    }
  }

  String get minLabel {
    switch (this) {
      case InvestmentType.sip:
        return '₹1K';
      case InvestmentType.rd:
        return '₹500';
      case InvestmentType.lumpsum:
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
      case InvestmentType.fd:
        return '₹1Cr';
      case InvestmentType.ppf:
        return '₹1.5L';
    }
  }

  double get minRate {
    switch (this) {
      case InvestmentType.sip:
      case InvestmentType.lumpsum:
        return 1;
      case InvestmentType.rd:
      case InvestmentType.fd:
      case InvestmentType.ppf:
        return 3;
    }
  }

  double get maxRate {
    switch (this) {
      case InvestmentType.sip:
      case InvestmentType.lumpsum:
        return 30;
      case InvestmentType.rd:
      case InvestmentType.fd:
      case InvestmentType.ppf:
        return 10;
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
      case InvestmentType.lumpsum:
        return 1;
    }
  }

  double get maxYears {
    switch (this) {
      case InvestmentType.ppf:
        return 15;
      case InvestmentType.fd:
      case InvestmentType.rd:
        return 10;
      case InvestmentType.sip:
      case InvestmentType.lumpsum:
        return 40;
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
      case InvestmentType.lumpsum:
        return 'Investment Period (Yrs)';
    }
  }
}
