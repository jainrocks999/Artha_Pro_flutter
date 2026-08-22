import 'package:artha_pro_app/core/ads/banner_ad.dart';
import 'package:artha_pro_app/core/ads/intrestitail_ad_service.dart';
import 'package:artha_pro_app/core/constants/app_colors.dart';
import 'package:artha_pro_app/core/model/loan_calculator.dart';
import 'package:artha_pro_app/core/utils/helper.dart';
import 'package:artha_pro_app/core/utils/loan_type.dart';
import 'package:artha_pro_app/core/widgets/calculate_btn.dart';
import 'package:artha_pro_app/core/widgets/calculator_top_header.dart';
import 'package:artha_pro_app/core/widgets/cricle_shap.dart';
import 'package:artha_pro_app/core/widgets/investment_chart.dart';
import 'package:artha_pro_app/core/widgets/light_app_topbar.dart';
import 'package:artha_pro_app/core/widgets/slider.dart';
import 'package:flutter/material.dart';

class LoanCalculatorScreen extends StatefulWidget {
  final LoanType type;
  const LoanCalculatorScreen({super.key, required this.type});

  @override
  State<LoanCalculatorScreen> createState() => _LoanCalculatorState();
}

class _LoanCalculatorState extends State<LoanCalculatorScreen> {
  final _formKey = GlobalKey<FormState>();

  bool showSummary = false;
  bool isMonthly = false;
  double loanAmount = 50000;
  double interestRate = 8;
  double tenureValue = 5;
  double downpayment = 0;
  double processingFee = 0;
  double emi = 0;
  double totalPayment = 0;
  double totalInterest = 0;

  final TextEditingController _loanAmountController = TextEditingController();
  final TextEditingController _tenureController = TextEditingController();
  final TextEditingController _downpaymentController = TextEditingController();
  final TextEditingController _processingFeeController =
      TextEditingController();

  final IntrestitailAdService _intrestitailAdService = IntrestitailAdService();

  @override
  void initState() {
    super.initState();

    _intrestitailAdService.loadAd();

    loanAmount = widget.type.minLoanAmount;
    interestRate = widget.type.minRate;
    _loanAmountController.text = loanAmount.toStringAsFixed(0);
    _tenureController.text = tenureValue.toStringAsFixed(0);
    _downpaymentController.text = downpayment.toStringAsFixed(0);
    _processingFeeController.text = processingFee.toStringAsFixed(0);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _intrestitailAdService.showAd(
        onAdDismissed: () {
          if (!mounted) return;
        },
      );
    });
  }

  @override
  void dispose() {
    _intrestitailAdService.dispose();
    super.dispose();
  }

  String? validateNumberField({
    required String? text,
    required double min,
    required double max,
    String? emptyMessage,
    String? invalidMessage,
    String? minMessage,
    String? maxMessage,
    bool checkDownPayment = false,
  }) {
    if (text == null || text.trim().isEmpty) {
      return emptyMessage ?? "This field is required";
    }

    final value = double.tryParse(text);

    if (value == null) {
      return invalidMessage ?? "Enter a valid number";
    }

    if (value < min) {
      return minMessage ?? "Minimum is $min";
    }

    if (value > max) {
      return maxMessage ?? "Maximum is $max";
    }

    if (checkDownPayment && value >= loanAmount) {
      return "Down payment cannot be greater than loan amount";
    }

    return null;
  }

  void _calculate() {
    final calculator = LoanCalculator(
      loanAmount: loanAmount,
      interestRate: interestRate,
      tenureValue: tenureValue,
      isMonthly: isMonthly,
      downpayment: downpayment,
      processingFee: processingFee,
    );

    setState(() {
      emi = calculator.emi;
      totalInterest = calculator.totalInterest;
      totalPayment = calculator.totalPayment;
      showSummary = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LightAppTopbar(title: widget.type.title),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 15,
            children: [
              CalculatorTopHeader(
                title: 'Loan EMI Calculator',
                description:
                    'Calculate your monthly loan repayments, total interest, and overall cost of borrowing for home, car, or personal loans.',
              ),
              _InputCard(
                title: 'Loan Amount',
                trailing: Text(
                  currencyFormat.format(loanAmount),
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                child: _InputTextField(
                  controller: _loanAmountController,
                  maxLength: 9,
                  onChanged: (val) {
                    setState(() {
                      loanAmount = val;
                    });
                  },
                  min: 10000,
                  max: widget.type.maxLoanAmount,

                  prefix: Icon(
                    Icons.currency_rupee_rounded,
                    size: 16,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              _InputCard(
                title: 'Interest rate (%)',
                trailing: Text(
                  '${interestRate.toStringAsFixed(1)}%',
                  style: const TextStyle(
                    fontFamily: 'Manrope',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.lightGreen,
                  ),
                ),
                child: SliderWidget(
                  value: interestRate,
                  min: 1,
                  max: 30,
                  divisions: ((30 - 1) / (0.5)).round(),
                  onChanged: (newValue) {
                    setState(() {
                      interestRate = double.parse(newValue.toStringAsFixed(1));
                    });
                  },
                ),
              ),
              _InputCard(
                title: 'Tenure',
                trailing: Container(
                  height: 35,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withAlpha(30),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      _TenureToggleButton(
                        label: 'Years',
                        isSelected: !isMonthly,
                        onTap: () => setState(() {
                          isMonthly = false;
                        }),
                      ),
                      _TenureToggleButton(
                        label: 'Months',
                        isSelected: isMonthly,
                        onTap: () => setState(() {
                          isMonthly = true;
                        }),
                      ),
                    ],
                  ),
                ),
                child: Row(
                  spacing: 20,
                  children: [
                    Expanded(
                      flex: 8,
                      child: _InputTextField(
                        controller: _tenureController,
                        maxLength: 4,
                        onChanged: (val) {
                          setState(() {
                            tenureValue = val;
                          });
                        },
                        min: 1,
                        max: isMonthly ? 12 : 30,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        (isMonthly ? 'Mo' : 'Yrs').toUpperCase(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 15,
                          fontWeight: FontWeight.w900,
                          color: AppColors.slateLight,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                spacing: 15,
                children: [
                  Expanded(
                    child: _InputCard(
                      title: 'Down payment',
                      child: _InputTextField(
                        controller: _downpaymentController,
                        maxLength: 9,
                        onChanged: (val) {
                          setState(() {
                            downpayment = val;
                          });
                        },
                        min: 0,
                        max: loanAmount * 0.9,
                        prefix: const Icon(
                          Icons.currency_rupee_rounded,
                          size: 16,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),

                  Expanded(
                    child: _InputCard(
                      title: 'Processing fee',
                      child: _InputTextField(
                        suffix: const Icon(
                          Icons.percent,
                          size: 16,
                          color: AppColors.primary,
                        ),
                        maxLength: 4,
                        controller: _processingFeeController,
                        onChanged: (val) {
                          setState(() {
                            processingFee = val;
                          });
                        },
                        min: 0,
                        max: 50,
                      ),
                    ),
                  ),
                ],
              ),
              CalculateBtn(
                title: "calculate",
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _calculate();
                  }
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.16,
                child: BannerAdSection(),
              ),
              showSummary
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Stack(
                        children: [
                          Container(
                            color: AppColors.primary,
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 20,
                            ),
                            child: Column(
                              children: [
                                Text(
                                  'monthly emi'.toUpperCase(),
                                  style: const TextStyle(
                                    fontFamily: 'Manrope',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.slateLight,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                                Text(
                                  currencyFormat.format(emi),
                                  style: const TextStyle(
                                    fontFamily: 'Manrope',
                                    fontSize: 28,
                                    fontWeight: FontWeight.w900,
                                    color: AppColors.secondaryLight,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  spacing: 10,
                                  children: [
                                    const Icon(
                                      Icons.trending_up,
                                      color: AppColors.lightGreen,
                                      size: 20,
                                    ),
                                    Text(
                                      'Calculated at ${interestRate.toStringAsFixed(1)} % p.a.',
                                      style: const TextStyle(
                                        fontFamily: 'Manrope',
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.lightGreen,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 15),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  spacing: 10,
                                  children: [
                                    SizedBox(
                                      height: 150,
                                      width: 150,
                                      child: InvestmentChart(
                                        principalAmount:
                                            loanAmount - downpayment,
                                        principalColor: AppColors.lightGreen,
                                        interestAmount: totalInterest,
                                        interestColor: AppColors.secondaryLight,
                                        title: 'Split',
                                        centerSpaceRadius: 45,
                                      ),
                                    ),

                                    Column(
                                      spacing: 15,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        _LegendItem(
                                          indicatorColor:
                                              AppColors.secondaryLight,
                                          title: 'Total Interest',
                                          value: currencyFormat.format(
                                            totalInterest,
                                          ),
                                        ),
                                        _LegendItem(
                                          indicatorColor: AppColors.lightGreen,
                                          title: 'Principle',
                                          value: currencyFormat.format(
                                            (loanAmount - downpayment),
                                          ),
                                        ),
                                        _LegendItem(
                                          indicatorColor:
                                              AppColors.secondaryDarkText,
                                          title: 'Total paymant',
                                          value: currencyFormat.format(
                                            totalPayment,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          CircleDecoration(left: -45, top: -28, size: 140),
                          CircleDecoration(right: -35, bottom: -58, size: 120),
                        ],
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}

class _InputCard extends StatelessWidget {
  final String title;
  final Widget child;
  final Widget? trailing;

  const _InputCard({required this.title, required this.child, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: AppCardThemes.whiteCard(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title.toUpperCase(),
                  softWrap: true,
                  style: const TextStyle(
                    fontFamily: 'Manrope',
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.slateLight,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              trailing ?? const SizedBox(),
            ],
          ),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}

class _InputTextField extends StatefulWidget {
  final TextEditingController controller;
  final Function(double) onChanged;
  final double min;
  final double max;
  final Widget? prefix;
  final Widget? suffix;
  final int? maxLength;

  const _InputTextField({
    required this.controller,
    required this.onChanged,
    required this.min,
    required this.max,
    this.prefix,
    this.suffix,
    this.maxLength,
  });

  @override
  State<_InputTextField> createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<_InputTextField> {
  String? _errorText;

  String? _validate(String? text) {
    if (text == null || text.trim().isEmpty) {
      return "This field is required";
    }
    final value = double.tryParse(text);
    if (value == null) {
      return "Enter a valid number";
    }
    if (value < widget.min) {
      return "Minimum is ${widget.min.toStringAsFixed(0)}";
    }
    if (value > widget.max) {
      return "Maximum is ${widget.max.toStringAsFixed(0)}";
    }
    return null;
  }

  void _handleChanged(String text) {
    final error = _validate(text);
    setState(() {
      _errorText = error;
    });

    final newValue = double.tryParse(text);
    if (newValue != null) {
      widget.onChanged(newValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      maxLength: widget.maxLength,
      onChanged: _handleChanged,
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
        prefixIcon: widget.prefix,
        suffixIcon: widget.suffix,
        filled: true,
        fillColor: Theme.of(context).inputDecorationTheme.fillColor,
        enabledBorder: AppInputeBorders.primary(),
        focusedBorder: AppInputeBorders.primary(),
        errorBorder: AppInputeBorders.error(),
        focusedErrorBorder: AppInputeBorders.error(),
        errorMaxLines: 2,
        errorStyle: const TextStyle(fontSize: 12, color: Colors.redAccent),
        errorText: _errorText,
      ),
      validator: (text) {
        final error = _validate(text);
        setState(() {
          _errorText = error;
        });
        return error;
      },
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color indicatorColor;
  final String title;
  final String value;
  const _LegendItem({
    required this.indicatorColor,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 5,
      children: [
        Row(
          spacing: 5,
          children: [
            Icon(Icons.circle, color: indicatorColor, size: 12),
            Text(
              title.toUpperCase(),
              maxLines: 2,
              softWrap: true,
              style: const TextStyle(
                fontFamily: 'Manrope',
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: AppColors.slateLight,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
        Text(
          value,
          style: const TextStyle(
            fontFamily: 'Manrope',
            fontSize: 18,
            fontWeight: FontWeight.w900,
            color: AppColors.primaryLightText,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }
}

class _TenureToggleButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _TenureToggleButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        backgroundColor: isSelected ? AppColors.primary : Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: 'Manrope',
          fontWeight: FontWeight.w900,
          fontSize: 12,
          color: isSelected ? AppColors.secondary : AppColors.primary,
        ),
      ),
    );
  }
}
