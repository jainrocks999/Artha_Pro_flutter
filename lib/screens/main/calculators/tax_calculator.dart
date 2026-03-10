import 'package:artha_pro_app/core/constants/app_colors.dart';
import 'package:artha_pro_app/core/utils/helper.dart';
import 'package:artha_pro_app/core/utils/tax_type.dart';
import 'package:artha_pro_app/core/widgets/calculator_top_header.dart';
import 'package:artha_pro_app/core/widgets/cricle_shap.dart';
import 'package:artha_pro_app/core/widgets/light_app_topbar.dart';
import 'package:artha_pro_app/core/widgets/tab_toggle_btn.dart';
import 'package:flutter/material.dart';

final List<double> _rateList = [0.25, 3, 5, 12, 18, 28];

class TaxCalculatorScreen extends StatefulWidget {
  final TaxType type;
  const TaxCalculatorScreen({super.key, required this.type});

  @override
  State<TaxCalculatorScreen> createState() => _TaxCalculatorScreenState();
}

class _TaxCalculatorScreenState extends State<TaxCalculatorScreen> {
  double taxRate = 12;
  static const double maxTransactionLimit = 1000000000;
  bool isExclusive = true;
  late TextEditingController amountController;
  bool _limitShown = false;

  double transactionAmount = 5000;

  double totalGst = 0;
  double netAmount = 0;
  double grossAmount = 0;
  double cgst = 0;
  double sgst = 0;

  String formatRate(double rate) {
    if (rate % 1 == 0) {
      return rate.toInt().toString();
    } else {
      return rate.toString();
    }
  }

  void _calculateGST() {
    if (transactionAmount <= 0) {
      setState(() {
        totalGst = 0;
        netAmount = 0;
        grossAmount = 0;
        cgst = 0;
        sgst = 0;
      });
      return;
    }
    double rate = taxRate / 100;

    if (isExclusive) {
      netAmount = transactionAmount;
      totalGst = netAmount * rate;
      grossAmount = netAmount + totalGst;
    } else {
      grossAmount = transactionAmount;
      netAmount = grossAmount / (1 + rate);
      totalGst = grossAmount - netAmount;
    }
    cgst = totalGst / 2;
    sgst = totalGst / 2;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    amountController = TextEditingController(
      text: transactionAmount.toInt().toString(),
    );
    _calculateGST();
  }

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LightAppTopbar(title: widget.type.title),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          spacing: 15,
          children: [
            const CalculatorTopHeader(
              title: 'GST Calculator',
              description:
                  'Calculate Goods and Services Tax for your business or personal transactions. Get a clear breakdown of CGST, SGST, and IGST.',
            ),

            Container(
              padding: const EdgeInsets.all(15),
              decoration: AppCardThemes.whiteCard(context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _LableText(title: 'Transaction amount'),
                  const SizedBox(height: 15),
                  TextField(
                    controller: amountController,
                    maxLength: 13,
                    onChanged: (value) {
                      double parsedValue = double.tryParse(value) ?? 0;

                      if (parsedValue > maxTransactionLimit) {
                        parsedValue = maxTransactionLimit;

                        amountController.text = parsedValue.toInt().toString();
                        amountController.selection = TextSelection.fromPosition(
                          TextPosition(offset: amountController.text.length),
                        );
                        if (!_limitShown) {
                          _limitShown = true;

                          CustomSnackBar.show(
                            context: context,
                            title: "Limit Exceeded",
                            message:
                                "Maximum allowed amount is ₹${maxTransactionLimit.toInt()}.",
                            icon: Icons.info,
                            actionText: "DISMISS",
                            onAction: () {
                              ScaffoldMessenger.of(
                                context,
                              ).removeCurrentSnackBar();
                            },
                          );
                        } else {
                          _limitShown = false;
                        }
                      }
                      setState(() {
                        transactionAmount = parsedValue;
                      });

                      _calculateGST();
                    },
                    cursorColor: Theme.of(context).colorScheme.primary,
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Theme.of(context).colorScheme.primary,
                    ),

                    decoration: InputDecoration(
                      counterText: "",
                      isDense: true,
                      prefixIcon: Icon(
                        Icons.currency_rupee_rounded,
                        size: 20,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      filled: true,
                      fillColor: Theme.of(
                        context,
                      ).inputDecorationTheme.fillColor,
                      enabledBorder: AppInputeBorders.primary(),
                      focusedBorder: AppInputeBorders.primary(),
                    ),
                  ),
                ],
              ),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _LableText(title: 'Select Gst rate'),
                const SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    spacing: 10,
                    children: List.generate(_rateList.length, (index) {
                      final rate = _rateList[index];
                      return _RateBtn(
                        label: '${formatRate(rate)}%',
                        isSelected: taxRate == rate,
                        onTap: () {
                          setState(() {
                            taxRate = rate;
                            FocusScope.of(context).unfocus();
                            _calculateGST();
                          });
                        },
                      );
                    }),
                  ),
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
                      label: 'GST Exclusive',
                      isSelected: isExclusive,
                      onTap: () {
                        setState(() {
                          isExclusive = true;
                          FocusScope.of(context).unfocus();
                          _calculateGST();
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2.4,
                    child: TabToggleBtn(
                      label: 'GST Inclusive',
                      isSelected: !isExclusive,
                      onTap: () {
                        setState(() {
                          isExclusive = false;
                          FocusScope.of(context).unfocus();
                          _calculateGST();
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),

            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                children: [
                  Container(
                    color: AppColors.primary,
                    width: double.infinity,
                    padding: const EdgeInsets.all(25),
                    child: Column(
                      children: [
                        const _LableText(title: 'Total GST Amount'),
                        Text(
                          currencyFormat.format(totalGst),
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
                        Row(
                          children: [
                            Expanded(
                              child: _SmallCard(
                                label: "Net Amount",
                                value: currencyFormat.format(netAmount),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _SmallCard(
                                label: "Gross Total",
                                value: currencyFormat.format(grossAmount),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const SizedBox(
                          height: 1,
                          width: double.infinity,
                          child: ColoredBox(color: Color(0xff422f59)),
                        ),
                        const SizedBox(height: 10),
                        _CardFooterSection(
                          label: 'CGST',
                          value: currencyFormat.format(cgst),
                        ),
                        const SizedBox(height: 10),
                        _CardFooterSection(
                          label: 'SGST',
                          value: currencyFormat.format(sgst),
                        ),
                      ],
                    ),
                  ),
                  const CircleDecoration(right: -45, top: -28, size: 120),
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

class _RateBtn extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  const _RateBtn({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        backgroundColor: isSelected
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.onPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            width: 1,
            color: isSelected
                ? AppColors.primary
                : AppColors.secondaryLightText.withAlpha(80),
          ),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: 'Manrope',
          fontWeight: FontWeight.w900,
          fontSize: 14,
          color: isSelected ? AppColors.primaryLightText : AppColors.slateLight,
        ),
      ),
    );
  }
}

class _SmallCard extends StatelessWidget {
  final String label;
  final String value;
  const _SmallCard({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.primaryLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: const BorderSide(width: 1, color: Color(0xff422f59)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 5,
          children: [
            _LableText(title: label, fontSize: 10),
            Text(
              value,
              softWrap: true,
              overflow: TextOverflow.visible,
              style: const TextStyle(
                fontFamily: 'Manrope',
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: AppColors.primaryLightText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CardFooterSection extends StatelessWidget {
  final String label;
  final String value;
  const _CardFooterSection({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Manrope',
            fontWeight: FontWeight.w500,
            fontSize: 14,
            color: AppColors.slateLight,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontFamily: 'Manrope',
            fontWeight: FontWeight.w900,
            fontSize: 16,
            color: AppColors.primaryLightText,
          ),
        ),
      ],
    );
  }
}
