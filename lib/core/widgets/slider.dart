import 'package:artha_pro_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class SliderWidget extends StatelessWidget {
  final double value;
  final double min;
  final double max;
  final ValueChanged<double> onChanged;
  final int? divisions;
  const SliderWidget({
    super.key,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
     this.divisions
  });

  @override
  Widget build(BuildContext context) {
    return  SliderTheme(
      data: SliderTheme.of(context).copyWith(
        trackHeight: 6,
        activeTrackColor: AppColors.secondaryLightText.withAlpha(100),
        inactiveTrackColor: AppColors.secondaryLightText.withAlpha(100),
        thumbColor: AppColors.secondary,
        thumbShape:const RoundSliderThumbShape(enabledThumbRadius: 10),
        tickMarkShape: const RoundSliderTickMarkShape(tickMarkRadius: 0),
      ),
      child: Slider(
        divisions: divisions,
        min: min,
        max: max,
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}
