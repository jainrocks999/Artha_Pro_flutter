enum LoanType { home, personal, vehical, education }

extension LoanTypeExtension on LoanType {
  String get title {
    switch (this) {
      case LoanType.home:
        return 'Home Loan Calculator';
      case LoanType.personal:
        return 'Personal Loan Calculator';
      case LoanType.vehical:
        return 'Vehical Loan Calculator';
      case LoanType.education:
        return 'Education Loan Calculator';
    }
  }
  double get minRate {
    switch (this) {
      case LoanType.home:
        return 6; 
      case LoanType.personal:
           return 10;
      case LoanType.vehical:
      return 7;
      case LoanType.education:
        return 5;
    }
  }
   double get minLoanAmount {
    switch (this) {
      case LoanType.home:
        return 500000; 
      case LoanType.personal:
        return 10000; 
      case LoanType.vehical:
        return 50000; 
      case LoanType.education:
        return 50000; 
    }
  }

  double get maxLoanAmount {
    switch (this) {
      case LoanType.home:
        return 100000000; 
      case LoanType.personal:
        return 2000000; 
      case LoanType.vehical:
        return 2000000; 
      case LoanType.education:
        return 5000000; 
    }
  }
}
