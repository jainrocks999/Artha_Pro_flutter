import 'package:artha_pro_app/core/utils/intestment_type.dart';
import 'package:artha_pro_app/core/utils/loan_type.dart';
import 'package:artha_pro_app/core/utils/tax_type.dart';
import 'package:flutter/material.dart';

final List<Map<String, dynamic>> investmentData = [
  {
    'icon': Icons.trending_up,
    'title': "Sip Calculor",
    'shortTitle': 'Sip',
    'shortDes': 'Systematic Investment Plan',
    'des': 'Calculate wealth accumulation through monthly investments.',
    "type": InvestmentType.sip,
  },
  {
    'icon': Icons.payments_outlined,
    'title': "Lumpsum Calculor",
    'shortTitle': 'Lumpsum',
    'shortDes': 'One-Time Investment',
    'des': 'Calculate returns from a single large investment.',
    "type": InvestmentType.lumpsum,
  },
  {
    'icon': Icons.account_balance_wallet_outlined,
    'title': "SWP Calculor",
    'shortTitle': 'swp',
    'shortDes': 'Systematic Withdrawal Plan',
    'des': 'Check maturity returns and interest on your fixed deposits.',
    "type": InvestmentType.swp,
  },
  {
    'icon': Icons.savings_outlined,
    'title': "FD Calculor",
    'shortTitle': 'fd',
    'shortDes': 'Fixed Deposit',
    'des': 'Check maturity returns and interest on your fixed deposits.',
    "type": InvestmentType.fd,
  },
  {
    'icon': Icons.health_and_safety_outlined,
    'title': "PPF Calculor",
    'shortTitle': 'ppf',
    'shortDes': 'Public Provident Fund',
    'des': 'Calculate long-term tax-free savings with PPF.',
    "type": InvestmentType.ppf,
  },
  {
    'icon': Icons.account_balance_outlined,
    'title': "EPF Calculor",
    'shortTitle': 'epf',
    'shortDes': 'Employee Provident Fund',
    'des':
        'Calculate your EPF savings with employee and employer contributions plus interest.',
    "type": InvestmentType.epf,
  },
  {
    'icon': Icons.show_chart,
    'title': "RD Calculor",
    'shortTitle': 'rd',
    'shortDes': 'Recurring deposit',
    'des': 'Calculate interest and final corpus for recurring deposits.',
    "type": InvestmentType.rd,
  },
];

final List<Map<String, dynamic>> loanData = [
  {
    'icon': Icons.home_work_outlined,
    'title': "Home Loan",
    'shortTitle': 'Home',
    'shortDes': 'Loan for house purchase',
    'des':
        'Calculate monthly installments and total payable amount for a home loan.',
    "type": LoanType.home,
  },
  {
    'icon': Icons.person_outline_outlined,
    'title': "Personal Loan",
    'shortTitle': 'Personal',
    'shortDes': 'Loan for personal use',
    'des':
        'Calculate monthly installments for a personal loan based on principal, interest, and tenure.',
    "type": LoanType.personal,
  },
  {
    'icon': Icons.directions_car_filled_outlined,
    'title': "Car/Bike Loan",
    'shortTitle': "vehicle",
    'shortDes': 'Loan for vehicle purchase',
    'des': 'Calculate monthly installments for a car or bike loan easily.',
    "type": LoanType.vehical,
  },
  {
    'icon': Icons.school_outlined,
    'title': "Education Loan",
    'shortTitle': "Education",
    'shortDes': 'Loan for studies',
    'des':
        'Calculate monthly installments for education loans including interest and tenure.',
    "type": LoanType.education,
  },
];

final List<Map<String, dynamic>> taxData = [
  {
    'icon': Icons.receipt_long_outlined,
    'title': "Income Tax",
    'shortTitle': 'Income',
    'shortDes': 'Annual tax calculation',
    'des': 'Calculate your annual income tax based on salary and exemptions.',
    "type": TaxType.income,
  },
  {
    'icon': Icons.percent_rounded,
    'title': "GST",
    'shortTitle': "GST",
    'shortDes': 'Goods & Services Tax',
    'des': 'Calculate GST payable on goods and services easily.',
    "type": TaxType.gst,
  },
];
