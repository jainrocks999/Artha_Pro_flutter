import 'package:artha_pro_app/core/constants/app_colors.dart';
import 'package:artha_pro_app/core/widgets/light_app_topbar.dart';
import 'package:artha_pro_app/screens/main/howitworks/data.dart';
import 'package:flutter/material.dart';

class HowItWorksScreen extends StatelessWidget {
  const HowItWorksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const LightAppTopbar(title: 'How It Works'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          children: [
            const Center(
              child: Text(
                'Simple steps to calculate, understand and\n'
                'achieve your financial goals.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xff57505E),
                  fontFamily: 'Manrope',
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  height: 1.45,
                ),
              ),
            ),
            const SizedBox(height: 20),
            CustomPaint(
              painter: _TimelinePainter(),
              child: Column(
                children: List.generate(steps.length, (index) {
                  final step = steps[index];
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: index == steps.length - 1 ? 0 : 12,
                    ),
                    child: _StepItem(
                      stepNumber: index + 1,
                      prefixIcon: step.icon,
                      title: step.title,
                      description: step.description,
                    ),
                  );
                }),
              ),
            ),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              margin: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                color: Color(0xfffaf6e8),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.secondary, width: 1),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.info_rounded,
                    color: AppColors.secondary,
                    size: 28,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Note: ',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontFamily: 'Manrope',
                              fontWeight: FontWeight.w900,
                              fontSize: 14,
                              height: 1.4,
                            ),
                          ),
                          TextSpan(
                            text:
                                'Arth Pro provides estimates based on the information entered. Actual returns, interest, taxes and maturity amounts may vary depending on applicable rates, rules and financial institutions.',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontFamily: 'Manrope',
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
           
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onPrimary,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppColors.secondaryLightText.withAlpha(70),
                  width: 2,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 15,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: List.generate(steps.length * 2 - 1, (index) {
                  if (index.isEven) {
                    final stepIndex = index ~/ 2;
                    final step = steps[stepIndex];

                    return Expanded(
                      child: _IconSection(
                        prefixIcon: step.icon,
                        size: 30,
                        title: step.shortTitle,
                      ),
                    );
                  }
                  return const _ArrowIcon();
                }),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

class _StepNumber extends StatelessWidget {
  final int stepNumber;
  const _StepNumber({required this.stepNumber});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 30,
          height: 30,
          margin: const EdgeInsets.only(top: 18),
          decoration: BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(
            '$stepNumber',
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'Manrope',
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}

class _StepItem extends StatelessWidget {
  final int stepNumber;
  final IconData prefixIcon;
  final String title;
  final String description;

  const _StepItem({
    required this.stepNumber,
    required this.prefixIcon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _StepNumber(stepNumber: stepNumber),
        const SizedBox(width: 12),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onPrimary,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppColors.secondaryLightText.withAlpha(70),
                width: 2,
              ),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 15,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Icon
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: AppColors.secondary.withAlpha(30),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  child: Icon(prefixIcon, color: AppColors.secondary, size: 34),
                ),

                const SizedBox(width: 16),

                // Text
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontFamily: 'Manrope',
                          fontWeight: FontWeight.w900,
                          fontSize: 16,
                        ),
                      ),

                      const SizedBox(height: 6),

                      Text(
                        description,
                        style: const TextStyle(
                          color: AppColors.slateLight,
                          fontFamily: 'Manrope',
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                          height: 1.35,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _IconSection extends StatelessWidget {
  final IconData prefixIcon;
  final double size;
  final String title;

  const _IconSection({
    required this.prefixIcon,
    required this.size,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(prefixIcon, color: AppColors.secondary, size: size),
        Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontFamily: 'Manrope',
            fontWeight: FontWeight.w500,
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}

class _ArrowIcon extends StatelessWidget {
  const _ArrowIcon();

  @override
  Widget build(BuildContext context) {
    return const Icon(Icons.chevron_right, color: AppColors.primary, size: 22);
  }
}

class _TimelinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primary.withAlpha(70)
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;
    const double x = 17;
    const double startY = 70;

    final double endY = size.height - 50;
    canvas.drawLine(const Offset(x, startY), Offset(x, endY), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
