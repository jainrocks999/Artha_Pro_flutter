import 'package:artha_pro_app/core/ads/banner_ad.dart';
import 'package:artha_pro_app/core/constants/app_colors.dart';
import 'package:artha_pro_app/core/model/income_tax_calculator.dart';
import 'package:artha_pro_app/core/utils/helper.dart';
import 'package:artha_pro_app/core/utils/tax_type.dart';
import 'package:artha_pro_app/core/widgets/calculate_btn.dart';
import 'package:artha_pro_app/core/widgets/calculator_top_header.dart';
import 'package:artha_pro_app/core/widgets/cricle_shap.dart';
import 'package:artha_pro_app/core/widgets/dropdown.dart';
import 'package:artha_pro_app/core/widgets/light_app_topbar.dart';
import 'package:artha_pro_app/core/widgets/tab_toggle_btn.dart';
import 'package:flutter/material.dart';

final List<Map<String, String>> _ageGroups = [
  {"value": "below60", "label": "Below 60"},
  {"value": "60to80", "label": "60 - 80"},
  {"value": "above80", "label": "Above 80"},
];
final List<Map<String, String>> _assessmentYears = [
  {"value": "2025-26", "label": "2025-26"},
  {"value": "2026-27", "label": "2026-27"},
];

final List<Map<String, String>> oldTaxSlabs = [
  {"range": "Up to ₹2.5L", "rate": "Nil"},
  {"range": "₹2.5L - ₹5L", "rate": "5%"},
  {"range": "₹5L - ₹10L", "rate": "20%"},
  {"range": "Above ₹10L", "rate": "30%"},
];

final List<Map<String, String>> newTaxSalbs = [
  {"range": "Up to ₹4L", "rate": "Nil"},
  {"range": "₹4L to ₹8L", "rate": "5%"},
  {"range": "₹8L to ₹12L", "rate": "10%"},
  {"range": "₹12L to ₹16L", "rate": "15%"},
  {"range": "₹16L to ₹20L", "rate": "20%"},
  {"range": "₹20L to ₹24L", "rate": "25%"},
  {"range": "Above ₹24L", "rate": "30%"},
];

class IncomeTaxCalculatorscreen extends StatefulWidget {
  final TaxType type;
  const IncomeTaxCalculatorscreen({super.key, required this.type});

  @override
  State<IncomeTaxCalculatorscreen> createState() =>
      _IncomeTaxCalculatorscreenState();
}

class _IncomeTaxCalculatorscreenState extends State<IncomeTaxCalculatorscreen> {
  bool showSummary = false;
  bool isNewRegime = false;
  bool isMetro = false;
  String selectedAgeGroup = _ageGroups[0]['value'] ?? '';
  String selectedAssessmentYear = _assessmentYears[0]['value'] ?? '';

  double totalIncome = 0;
  double totalDeductions = 0;
  double totalHraExemption = 0;
  double taxableIncome = 0;
  double estimatedTax = 0;

  final grossSalaryController = TextEditingController();
  final otherIncomeController = TextEditingController();
  final interestIncomeController = TextEditingController();
  final letOutIncomeController = TextEditingController();
  final hlInterestSOController = TextEditingController();
  final hlInterestLOController = TextEditingController();

  final deduction80CController = TextEditingController();
  final npsController = TextEditingController();
  final mediclaimController = TextEditingController();
  final donationController = TextEditingController();
  final savingsInterestController = TextEditingController();
  final eduLoanController = TextEditingController();

  final basicSalaryController = TextEditingController();
  final daController = TextEditingController();
  final hraReceivedController = TextEditingController();
  final annualRentController = TextEditingController();

  @override
  void initState() {
    super.initState();

    final controllers = [
      grossSalaryController,
      otherIncomeController,
      interestIncomeController,
      letOutIncomeController,
      hlInterestSOController,
      hlInterestLOController,
      deduction80CController,
      npsController,
      mediclaimController,
      donationController,
      eduLoanController,
      basicSalaryController,
      daController,
      hraReceivedController,
      annualRentController,
    ];

    for (var controller in controllers) {
      controller.text = "0";
    }
  }

  @override
  void dispose() {
    grossSalaryController.dispose();
    otherIncomeController.dispose();
    interestIncomeController.dispose();
    letOutIncomeController.dispose();
    hlInterestSOController.dispose();
    hlInterestLOController.dispose();

    deduction80CController.dispose();
    npsController.dispose();
    mediclaimController.dispose();
    donationController.dispose();
    savingsInterestController.dispose();
    eduLoanController.dispose();

    basicSalaryController.dispose();
    daController.dispose();
    hraReceivedController.dispose();
    annualRentController.dispose();
    super.dispose();
  }

  void _calculate() {
    final calculator = IncomeTaxCalculator(
      daIncludedInRetirement: true,
      ageGroup: selectedAgeGroup,
      assessmentYear: selectedAssessmentYear,
      isNewRegime: isNewRegime,
      isMetro: isMetro,
      grossSalary: double.tryParse(grossSalaryController.text) ?? 0,
      otherIncome: double.tryParse(otherIncomeController.text) ?? 0,
      interestIncome: double.tryParse(interestIncomeController.text) ?? 0,
      letOutIncome: double.tryParse(letOutIncomeController.text) ?? 0,
      hlInterestSO: double.tryParse(hlInterestSOController.text) ?? 0,
      hlInterestLO: double.tryParse(hlInterestLOController.text) ?? 0,
      deduction80C: double.tryParse(deduction80CController.text) ?? 0,
      nps: double.tryParse(npsController.text) ?? 0,
      mediclaim: double.tryParse(mediclaimController.text) ?? 0,
      donation: double.tryParse(donationController.text) ?? 0,
      savingsInterest: double.tryParse(savingsInterestController.text) ?? 0,
      eduLoan: double.tryParse(eduLoanController.text) ?? 0,
      basicSalary: double.tryParse(basicSalaryController.text) ?? 0,
      da: double.tryParse(daController.text) ?? 0,
      hraReceived: double.tryParse(hraReceivedController.text) ?? 0,
      annualRent: double.tryParse(annualRentController.text) ?? 0,
    );

    final result = calculator.calculate();
    setState(() {
      if (result.totalIncome > 0) {
        showSummary = true;
      } else {
        CustomSnackBar.show(
          context: context,
          title: "Missing Input",
          message: "Please enter at valid value to calculate.",
          icon: Icons.info,
          actionText: "DISMISS",
          onAction: () {
            ScaffoldMessenger.of(context).removeCurrentSnackBar();
          },
        );
      }
      totalIncome = result.totalIncome;
      totalDeductions = (result.totalDeductions - result.hraExemption);
      totalHraExemption = result.hraExemption;
      taxableIncome = result.taxableIncome;
      estimatedTax = result.taxPayable;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget lineWidget() => SizedBox(
      height: 1.5,
      width: double.infinity,
      child: ColoredBox(color: AppColors.secondaryLightText.withAlpha(100)),
    );
    final TextStyle tbHeaderText = TextStyle(
      fontFamily: 'Manrope',
      fontWeight: FontWeight.w700,
      color: AppColors.slateLight,
      fontSize: 12,
    );
    return Scaffold(
      appBar: LightAppTopbar(title: widget.type.title),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          spacing: 15,
          children: [
            const CalculatorTopHeader(
              title: 'Income Tax Calculator',
              description:
                  'Estimate your tax liability under the Old and New tax regimes for FY 2026-27. Plan your deductions and maximize your savings.',
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _LabelDropdown(
                  label: 'Assessment year',
                  selectedValue: selectedAssessmentYear,
                  listData: _assessmentYears,
                  onChanged: (value) {
                    setState(() {
                      selectedAssessmentYear = value;
                    });
                  },
                ),
                _LabelDropdown(
                  label: 'Age Group',
                  selectedValue: selectedAgeGroup,
                  listData: _ageGroups,
                  onChanged: (value) {
                    setState(() {
                      selectedAgeGroup = value;
                    });
                  },
                ),
              ],
            ),

            Container(
              padding: const EdgeInsets.all(8),
              decoration: AppCardThemes.whiteCard(context, shadow: false),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2.4,
                    child: TabToggleBtn(
                      label: 'New Regime',
                      isSelected: isNewRegime,
                      onTap: () {
                        setState(() {
                          showSummary = false;
                          isNewRegime = true;
                          FocusScope.of(context).unfocus();
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2.4,
                    child: TabToggleBtn(
                      label: 'Old Regime',
                      isSelected: !isNewRegime,
                      onTap: () {
                        setState(() {
                          showSummary = false;
                          isNewRegime = false;
                          FocusScope.of(context).unfocus();
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),

            _ExpendationSection(
              title: "Income Sources",
              icon: Icons.account_balance_wallet_outlined,
              isExpended: true,
              children: [
                _InputTextField(
                  label: "Gross salary income",
                  controller: grossSalaryController,
                ),
                _InputTextField(
                  label: "Income (Other) – Annual",
                  controller: otherIncomeController,
                ),
                Row(
                  spacing: 10,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2.6,
                      child: _InputTextField(
                        label: "Interest Income",
                        controller: interestIncomeController,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2.6,
                      child: _InputTextField(
                        label: "Let-Out Property Income (Annual)",
                        controller: letOutIncomeController,
                      ),
                    ),
                  ],
                ),
                _InputTextField(
                  label: "Annual HL Interest (SO)",
                  controller: hlInterestSOController,
                ),
                _InputTextField(
                  label: "Annual HL Interest (LO)",
                  controller: hlInterestLOController,
                ),
              ],
            ),

            _ExpendationSection(
              title: "Deductions",
              icon: Icons.receipt_long_outlined,
              children: [
                _InputTextField(
                  label: "Deduction u/s 80C",
                  controller: deduction80CController,
                ),
                _InputTextField(
                  label: "NPS u/s 80CCD(1B) / NPS",
                  controller: npsController,
                ),
                Row(
                  spacing: 10,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2.6,
                      child: _InputTextField(
                        label: "Mediclaim u/s 80D",
                        controller: mediclaimController,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2.6,
                      child: _InputTextField(
                        label: "Donation u/s 80G",
                        controller: donationController,
                      ),
                    ),
                  ],
                ),
                Row(
                  spacing: 10,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2.6,
                      child: _InputTextField(
                        label: "Ann. Savings Int. (80TTA/TTB)",
                        controller: savingsInterestController,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2.6,
                      child: _InputTextField(
                        label: "Edu Loan Int. u/s 80E",
                        controller: eduLoanController,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            _ExpendationSection(
              title: "HRA Exemption",
              icon: Icons.home_work_outlined,
              children: [
                _InputTextField(
                  label: "Basic Salary Recv. (Annual) ",
                  controller: basicSalaryController,
                ),
                _InputTextField(
                  label: "DA Recv. (Annual)",
                  controller: daController,
                ),
                _InputTextField(
                  label: "HRA Recv. (Annual)",
                  controller: hraReceivedController,
                ),
                Row(
                  spacing: 10,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2.6,
                      child: _InputTextField(
                        label: "Annual Rent Paid",
                        controller: annualRentController,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2.6,
                      child: Column(
                        children: [
                          _LableText(title: 'Metro City? (Y/N)', fontSize: 12),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              TabToggleBtn(
                                label: 'Yes',
                                verticalPadding: 0,
                                isSelected: isMetro,
                                onTap: () {
                                  setState(() {
                                    isMetro = true;
                                    FocusScope.of(context).unfocus();
                                  });
                                },
                              ),
                              TabToggleBtn(
                                label: 'No',
                                isSelected: !isMetro,
                                verticalPadding: 0,
                                onTap: () {
                                  setState(() {
                                    isMetro = false;
                                    FocusScope.of(context).unfocus();
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),

            CalculateBtn(
              title: "calculate",
              onPressed: () {
                FocusScope.of(context).unfocus();
                _calculate();
              },
            ),
            BannerAdSection(height: MediaQuery.of(context).size.width * 0.16),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _LableText(title: 'Estimated Tax Payable'),
                              Text(
                                currencyFormat.format(estimatedTax),
                                softWrap: true,
                                overflow: TextOverflow.visible,
                                style: const TextStyle(
                                  fontFamily: 'Manrope',
                                  fontSize: 32,
                                  fontWeight: FontWeight.w900,
                                  color: AppColors.secondaryLightDark,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              const SizedBox(height: 10),
                              lineWidget(),
                              const SizedBox(height: 15),
                              _FooterSection(
                                label: 'Gross Total Income',
                                value: currencyFormat.format(totalIncome),
                              ),
                              const SizedBox(height: 5),
                              _FooterSection(
                                label: 'Total Deductions',
                                value:
                                    '- ${currencyFormat.format(totalDeductions)}',
                              ),
                              const SizedBox(height: 5),
                              _FooterSection(
                                label: 'Total HRA Exemption',
                                value:
                                    '- ${currencyFormat.format(totalHraExemption)}',
                              ),
                              const SizedBox(height: 15),
                              lineWidget(),
                              const SizedBox(height: 10),
                              _FooterSection(
                                label: 'Taxable Income',
                                value: currencyFormat.format(taxableIncome),
                                textColor: AppColors.secondaryLightDark,
                              ),
                            ],
                          ),
                        ),
                        const CircleDecoration(right: -25, top: -28, size: 120),
                      ],
                    ),
                  )
                : const SizedBox(),

            _CardHeading(
              title: "${isNewRegime ? 'New' : 'Old'} Regime Slab Rates",
              icon: Icons.bar_chart_rounded,
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.only(bottom: 20),
              decoration: AppCardThemes.whiteCard(context, shadow: false),

              child: Table(
                children: [
                  TableRow(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Text('INCOME SLAB', style: tbHeaderText),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Text(
                          'RATE',
                          style: tbHeaderText,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  ...(isNewRegime ? newTaxSalbs : oldTaxSlabs)
                      .asMap()
                      .entries
                      .map((entry) {
                        int index = entry.key;
                        var slab = entry.value;

                        return TableRow(
                          decoration: BoxDecoration(
                            color: index % 2 == 0
                                ? Theme.of(
                                    context,
                                  ).colorScheme.primary.withAlpha(21)
                                : Theme.of(context).colorScheme.onPrimary,
                          ),
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12),
                              child: Text(
                                slab["range"]!,
                                style: tbHeaderText.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12),
                              child: Text(
                                slab["rate"]!.toUpperCase(),
                                style: tbHeaderText.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        );
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LableText extends StatelessWidget {
  final String title;
  final double fontSize;
  const _LableText({required this.title, this.fontSize = 14});

  @override
  Widget build(BuildContext context) {
    return Text(
      title.toUpperCase(),
      style: TextStyle(
        fontFamily: 'Manrope',
        fontSize: fontSize,
        fontWeight: FontWeight.w700,
        color: AppColors.slateLight,
        letterSpacing: 0.5,
      ),
    );
  }
}

class _LabelDropdown extends StatelessWidget {
  final String label;
  final String selectedValue;
  final List listData;
  final ValueChanged onChanged;
  const _LabelDropdown({
    required this.label,
    required this.selectedValue,
    required this.listData,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 5,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _LableText(title: label, fontSize: 12),
        CustomDropdown<String>(
          selectedValue: selectedValue,
          items: List.generate(listData.length, (index) {
            final item = listData[index];
            return DropdownMenuEntry<String>(
              value: item['value']!,
              label: item['label']!,
            );
          }),

          onChanged: onChanged,
        ),
      ],
    );
  }
}

class _CardHeading extends StatelessWidget {
  final String title;
  final IconData icon;
  const _CardHeading({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColors.secondary.withAlpha(30),
            borderRadius: BorderRadius.circular(10),
          ),
          child: SizedBox(
            height: 35,
            width: 35,
            child: Icon(icon, color: AppColors.secondary, size: 22),
          ),
        ),
        Text(
          title,
          style: TextStyle(
            fontFamily: 'Manrope',
            fontSize: 18,
            fontWeight: FontWeight.w900,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ],
    );
  }
}

class _InputTextField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  const _InputTextField({required this.label, required this.controller});

  @override
  State<_InputTextField> createState() => __InputTextFieldState();
}

class __InputTextFieldState extends State<_InputTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        _LableText(title: widget.label, fontSize: 12),
        TextField(
          controller: widget.controller,
          maxLength: 13,
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
            prefixIcon: Icon(
              Icons.currency_rupee_rounded,
              size: 16,
              color: Theme.of(context).colorScheme.primary,
            ),
            filled: true,
            fillColor: Theme.of(context).inputDecorationTheme.fillColor,
            enabledBorder: AppInputeBorders.primary(),
            focusedBorder: AppInputeBorders.primary(),
          ),
        ),
      ],
    );
  }
}

class _ExpendationSection extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Widget> children;
  final bool isExpended;
  const _ExpendationSection({
    required this.title,
    required this.icon,
    required this.children,
    this.isExpended = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      decoration: AppCardThemes.whiteCard(context, shadow: false),
      child: Column(
        children: [
          Theme(
            data: Theme.of(context).copyWith(
              dividerColor: Colors.transparent,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            child: ExpansionTile(
              initiallyExpanded: isExpended,
              tilePadding: EdgeInsets.zero,
              childrenPadding: EdgeInsets.zero,
              iconColor: Theme.of(context).colorScheme.primary,
              collapsedIconColor: Theme.of(context).colorScheme.primary,
              maintainState: true,
              title: _CardHeading(title: title, icon: icon),
              children: [Column(spacing: 10, children: children)],
            ),
          ),
        ],
      ),
    );
  }
}

class _FooterSection extends StatelessWidget {
  final String label;
  final String value;
  final Color? textColor;
  const _FooterSection({
    required this.label,
    required this.value,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Manrope',
            fontWeight: textColor != null ? FontWeight.w900 : FontWeight.w500,
            fontSize: 14,
            color: textColor ?? AppColors.slateLight,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontFamily: 'Manrope',
            fontWeight: FontWeight.w900,
            fontSize: 16,
            color: textColor ?? AppColors.primaryLightText,
          ),
        ),
      ],
    );
  }
}
