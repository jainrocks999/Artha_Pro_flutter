import 'dart:io';

import 'package:artha_pro_app/core/ads/banner_ad.dart';
import 'package:artha_pro_app/core/constants/app_colors.dart';
import 'package:artha_pro_app/core/model/investment.calculator.dart';
import 'package:artha_pro_app/core/utils/helper.dart';
import 'package:artha_pro_app/core/utils/intestment_type.dart';
import 'package:artha_pro_app/core/widgets/calculate_btn.dart';
import 'package:artha_pro_app/core/widgets/calculator_top_header.dart';
import 'package:artha_pro_app/core/widgets/investment_chart.dart';
import 'package:artha_pro_app/core/widgets/light_app_topbar.dart';
import 'package:artha_pro_app/core/widgets/slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class SipCalculatorScreen extends StatefulWidget {
  final InvestmentType type;
  const SipCalculatorScreen({super.key, required this.type});

  @override
  State<SipCalculatorScreen> createState() => _SipCalculatorScreenState();
}

class _SipCalculatorScreenState extends State<SipCalculatorScreen> {
  double monthlyInvestment = 2500;
  double lumpsumInvestment = 10000;
  double annualReturnRate = 12;
  double monthlyWithdrawal = 1000;
  double year = 10;

  double contributeToEpe = 12;
  double annualIncreaseSalary = 5;

  double totalInvested = 0;
  double estimateReturns = 0;
  double maturityValue = 0;
  bool showSummary = false;
  bool isError = false;

  final NumberFormat _currencyFormat = NumberFormat.currency(
    locale: 'en_IN',
    symbol: '₹',
    decimalDigits: 0,
  );
  final TextEditingController _monthInvestmentController =
      TextEditingController();
  final TextEditingController _rateOfReturnController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _widthDrawalController = TextEditingController();
  final TextEditingController _contributeToEpeController =
      TextEditingController();
  final TextEditingController _annualIncreaseSalaryController =
      TextEditingController();

  final FocusNode _monthFocus = FocusNode();
  final FocusNode _rateFocus = FocusNode();
  final FocusNode _yearFocus = FocusNode();
  final FocusNode _withdrawal = FocusNode();

  @override
  void initState() {
    super.initState();

    monthlyInvestment = widget.type.minAmount;
    annualReturnRate = widget.type.defaultRate;
    year = widget.type.defaultYears;
    _monthInvestmentController.text = monthlyInvestment.toStringAsFixed(0);
    _rateOfReturnController.text = annualReturnRate.toStringAsFixed(0);
    _timeController.text = year.toStringAsFixed(0);
    _widthDrawalController.text = monthlyWithdrawal.toStringAsFixed(0);
    _contributeToEpeController.text = contributeToEpe.toStringAsFixed(0);
    _annualIncreaseSalaryController.text = annualIncreaseSalary.toStringAsFixed(
      0,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _calculate() {
    if (isError) {
      CustomSnackBar.show(
        context: context,
        title: "Invalid Value",
        message: "Please enter at valid value to calculate.",
        icon: Icons.info,
        actionText: "DISMISS",
        onAction: () {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
        },
      );
      return;
    }
    final result = InvestmentCalculator.calculate(
      type: widget.type,
      amount: monthlyInvestment,
      annualRate: annualReturnRate,
      years: year,
      withdrawal: monthlyWithdrawal,
      contributeToEpe: contributeToEpe,
      annualIncreaseSalary: annualIncreaseSalary,
    );

    setState(() {
      totalInvested = result.totalInvested;
      maturityValue = result.maturityValue;
      estimateReturns = result.estimatedReturns;
      showSummary = true;
    });
  }

  Widget _renderSliders(
    String lable,
    String minlableText,
    String maxlableText,
    double value,
    double min,
    double max,
    int maxLength,
    Function(double) onChanged,
    TextEditingController controller,
    FocusNode focusNode, {
    bool allowDecimal = false,
    double? steps,
  }) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              lable.toString().toUpperCase(),
              style: const TextStyle(
                fontFamily: 'Manrope',
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: AppColors.slateLight,
                letterSpacing: 0.5,
              ),
            ),

            SizedBox(
              width: minlableText.contains('₹') ? 150 : 80,
              child: TextField(
                controller: controller,
                maxLength: maxLength,
                onEditingComplete: () {
                  FocusScope.of(context).unfocus();
                  final cleaned = controller.text.replaceAll('%', '').trim();
                  final newValue = double.tryParse(cleaned);
                  if (newValue == null || newValue < min || newValue > max) {
                    setState(() => isError = true);
                    CustomSnackBar.show(
                      context: context,
                      title: "Invalid Value",
                      message:
                          "Please enter a value between ${min.toInt()} and ${max.toInt()}.",
                      icon: Icons.info,
                      actionText: "DISMISS",
                      onAction: () {
                        ScaffoldMessenger.of(context).removeCurrentSnackBar();
                      },
                    );
                  }
                },
                onChanged: (text) {
                  final cleaned = text.replaceAll('%', '').trim();
                  final newValue = double.tryParse(cleaned);

                  if (newValue != null && newValue >= min && newValue <= max) {
                    setState(() {
                      double updatedValue = allowDecimal
                          ? newValue
                          : newValue.roundToDouble();

                      onChanged(updatedValue);
                      isError = false;
                    });
                  } else {
                    setState(() => isError = true);
                  }
                },
                cursorColor: Theme.of(context).colorScheme.primary,
                keyboardType: TextInputType.number,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).colorScheme.primary,
                ),
                decoration: InputDecoration(
                  counterText: "",
                  isDense: true,
                  prefixIcon: minlableText.contains('₹')
                      ? Icon(
                          Icons.currency_rupee_rounded,
                          size: 16,
                          color: Theme.of(context).colorScheme.primary,
                        )
                      : null,
                  suffixText: minlableText.contains('₹')
                      ? null
                      : minlableText.contains('%')
                      ? '%'
                      : minlableText.contains('Yr')
                      ? 'Yr'
                      : null,
                  suffixStyle: TextStyle(
                    fontFamily: 'Manrope',
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  fillColor: Theme.of(context).colorScheme.onPrimary,
                  filled: true,
                  enabledBorder: AppInputeBorders.primary(),
                  focusedBorder: AppInputeBorders.primary(),
                ),
              ),
            ),
          ],
        ),
        SliderWidget(
          value: value,
          min: min,
          max: max,
          divisions:
              [InvestmentType.ppf, InvestmentType.epf].contains(widget.type)
              ? null
              : ((max - min) / (steps ?? 1)).round(),
          onChanged: (newValue) {
            setState(() {
              double updatedValue = allowDecimal
                  ? double.parse(newValue.toStringAsFixed(1))
                  : newValue.roundToDouble();

              onChanged(updatedValue);

              controller.text = allowDecimal
                  ? updatedValue.toStringAsFixed(1)
                  : updatedValue.toStringAsFixed(0);
            });
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              minlableText,
              style: TextStyle(
                fontFamily: 'Manrope',
                fontSize: 13,
                color: AppColors.secondaryDarkText.withAlpha(120),
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              maxlableText,
              style: TextStyle(
                fontFamily: 'Manrope',
                fontSize: 13,
                color: AppColors.secondaryDarkText.withAlpha(120),
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  Widget _renderCard(
    String title,
    String value,
    Widget icon,
    Color bgColor,
    Color borderColor,
    Color valueColor,
  ) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            child: Container(
              width: 40,
              decoration: BoxDecoration(
                color: borderColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 6),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title.toUpperCase(),
                      style: const TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        color: AppColors.slateLight,
                        letterSpacing: -0.3,
                      ),
                    ),
                    Text(
                      value,
                      style: TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: valueColor,
                      ),
                    ),
                  ],
                ),
                icon,
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LightAppTopbar(title: widget.type.title),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CalculatorTopHeader(
              title: 'Plan your wealth',
              description: 'Adjust the silders to see you projected growth.',
            ),
            const SizedBox(height: 20),
            _renderSliders(
              widget.type.investmentLabel,
              widget.type.minLabel,
              widget.type.maxLabel,
              monthlyInvestment,
              widget.type.minAmount,
              widget.type.maxAmount,
              widget.type.maxLength,
              (val) => monthlyInvestment = val,
              _monthInvestmentController,
              _monthFocus,
              steps: 50,
            ),
            if (widget.type.withdrawalLabel.isNotEmpty)
              _renderSliders(
                widget.type.withdrawalLabel,
                '₹500',
                '₹10L',
                monthlyWithdrawal,
                500,
                1000000,
                8,
                (val) => monthlyWithdrawal = val,
                _widthDrawalController,
                _withdrawal,
                steps: 50,
              ),
            [InvestmentType.epf].contains(widget.type)
                ? _renderSliders(
                    'Rate of interest',
                    '${widget.type.minRate}%',
                    '${widget.type.maxRate}%',
                    annualReturnRate,
                    widget.type.minRate,
                    widget.type.maxRate,
                    3,
                    (val) => annualReturnRate = val,
                    _rateOfReturnController,
                    _rateFocus,
                    allowDecimal: true,
                    steps: 0.5,
                  )
                : _renderSliders(
                    'Expected Return (P.a)',
                    '${widget.type.minRate.toInt()}%',
                    '${widget.type.maxRate.toInt()}%',
                    annualReturnRate,
                    widget.type.minRate,
                    widget.type.maxRate,
                    3,
                    (val) => annualReturnRate = val,
                    _rateOfReturnController,
                    _rateFocus,
                    allowDecimal: true,
                    steps: 0.5,
                  ),

            [InvestmentType.epf].contains(widget.type)
                ? _renderSliders(
                    'Your contribution to EPF',
                    '12%',
                    '20%',
                    contributeToEpe,
                    12,
                    20,
                    2,
                    (val) => contributeToEpe = val,
                    _contributeToEpeController,
                    _rateFocus,
                    allowDecimal: false,
                    steps: 1,
                  )
                : SizedBox(),
            [InvestmentType.epf].contains(widget.type)
                ? _renderSliders(
                    'Annual increase in salary',
                    '0%',
                    '15%',
                    annualIncreaseSalary,
                    0,
                    15,
                    1,
                    (val) => annualIncreaseSalary = val,
                    _annualIncreaseSalaryController,
                    _rateFocus,
                    allowDecimal: false,
                    steps: 1,
                  )
                : SizedBox(),
            _renderSliders(
              widget.type.tenureLable,
              '${widget.type.minYears.toInt()} Yr',
              '${widget.type.maxYears.toInt()} Yrs',
              year,
              widget.type.minYears,
              widget.type.maxYears,
              2,
              (val) => year = val,
              _timeController,
              _yearFocus,
              steps: 1,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: CalculateBtn(title: 'Calculate', onPressed: _calculate),
            ),
            if (Platform.isIOS) const SizedBox(height: 10),
            BannerAdSection(height: MediaQuery.of(context).size.width * 0.20),
            SizedBox(height: Platform.isIOS ? 16 : 6),
            showSummary
                ? Container(
                    padding: const EdgeInsets.all(15),
                    decoration: AppCardThemes.whiteCard(context),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Projection Summary",
                              style: TextStyle(
                                fontFamily: 'Manrope',
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.secondaryLightText.withAlpha(
                                  90,
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: const Text(
                                "Estimated",
                                style: TextStyle(
                                  fontFamily: 'Manrope',
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.slateLight,
                                ),
                              ),
                            ),
                          ],
                        ),
                        // widget.type != InvestmentType.swp
                        ![
                              InvestmentType.epf,
                              InvestmentType.swp,
                            ].contains(widget.type)
                            ? SizedBox(
                                height: 300,
                                width: 300,
                                child: InvestmentChart(
                                  principalAmount: totalInvested,
                                  principalColor: Theme.of(
                                    context,
                                  ).colorScheme.primary,
                                  interestAmount: estimateReturns,
                                  interestColor: AppColors.lightGreen,
                                  title: 'Total Value',
                                  totalAmount: _currencyFormat.format(
                                    maturityValue,
                                  ),
                                ),
                              )
                            : SizedBox(height: 15),
                        if (![InvestmentType.epf].contains(widget.type))
                          _renderCard(
                            "Total  investment",
                            _currencyFormat.format(totalInvested),
                            const Icon(
                              Icons.wallet,
                              size: 30,
                              color: AppColors.slateLight,
                            ),
                            Theme.of(context).cardColor,
                            Theme.of(context).colorScheme.primary,
                            Theme.of(context).colorScheme.primary,
                          ),
                        const SizedBox(height: 15),
                        if (![InvestmentType.epf].contains(widget.type))
                          _renderCard(
                            widget.type != InvestmentType.swp
                                ? "Estimated  Returns"
                                : 'Total  Withdrawal',
                            _currencyFormat.format(estimateReturns),
                            const Icon(
                              Icons.trending_up,
                              size: 30,
                              color: AppColors.lightGreen,
                            ),
                            Theme.of(context).cardColor,
                            AppColors.lightGreen,
                            AppColors.lightGreen,
                          ),

                        if ([InvestmentType.epf].contains(widget.type))
                          Column(
                            children: [
                              Text(
                                'You will have accumulated',
                                style: const TextStyle(
                                  fontFamily: 'Manrope',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.slateLight,
                                ),
                              ),
                              Text(
                                _currencyFormat.format(totalInvested),
                                style: const TextStyle(
                                  fontFamily: 'Manrope',
                                  fontSize: 25,
                                  fontWeight: FontWeight.w900,
                                  color: AppColors.primary,
                                  letterSpacing: -0.3,
                                ),
                              ),
                              Text(
                                'by the time you retire',
                                style: const TextStyle(
                                  fontFamily: 'Manrope',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.slateLight,
                                ),
                              ),
                            ],
                          ),
                        const SizedBox(height: 15),

                        if (![InvestmentType.epf].contains(widget.type))
                          _renderCard(
                            widget.type != InvestmentType.swp
                                ? "Maturity  value"
                                : 'Final  value',
                            _currencyFormat.format(maturityValue),
                            Card(
                              color: AppColors.secondary.withAlpha(51),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: const BorderSide(
                                  width: 1,
                                  color: AppColors.secondary,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: SvgPicture.asset(
                                  'assets/icons/license.svg',
                                  height: 15,
                                  width: 15,
                                ),
                              ),
                            ),
                            AppColors.primary,
                            AppColors.primary,
                            AppColors.secondary,
                          ),
                      ],
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
