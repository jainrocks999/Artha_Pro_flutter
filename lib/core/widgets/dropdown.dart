import 'package:artha_pro_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CustomDropdown<T> extends StatelessWidget {
  // final String label;
  final T selectedValue; // non-nullable
  final List<DropdownMenuEntry<T>> items;
  final void Function(T) onChanged;

  const CustomDropdown({
    super.key,
    required this.items,
    required this.onChanged,
    required this.selectedValue,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<T>(
      width: MediaQuery.of(context).size.width / 2.4,
      initialSelection: selectedValue,
      dropdownMenuEntries: items.map((item) {
        final bool isSelected = item.value == selectedValue;
        return DropdownMenuEntry<T>(
          value: item.value,
          label: item.label,
          style: MenuItemButton.styleFrom(
            textStyle: const TextStyle(
              fontFamily: 'Manrope',
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            foregroundColor: isSelected
                ? AppColors.primary
                : AppColors.secondaryDarkText,
            backgroundColor: isSelected
                ? AppColors.secondaryDarkText.withAlpha(51)
                : Colors.transparent,
          ),
        );
      }).toList(),
      onSelected: (value) {
        if (value != null) {
          onChanged(value);
        }
      },
      trailingIcon: Icon(
        Icons.keyboard_arrow_down_rounded,
        color: Theme.of(context).colorScheme.primary,
        size: 28,
      ),
      selectedTrailingIcon:  Icon(
        Icons.keyboard_arrow_up_rounded,
        color: Theme.of(context).colorScheme.primary,
        size: 28,
      ),
      textStyle:TextStyle(
        fontFamily: 'Manrope',
        fontSize: 15,
        fontWeight: FontWeight.w900,
        color: Theme.of(context).colorScheme.primary,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Theme.of(context).colorScheme.onPrimary,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: AppColors.secondaryLightText.withAlpha(80),
          ),
        ),
      ),
      menuStyle: MenuStyle(
        backgroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
          if (states.contains(WidgetState.pressed)) {
            return AppColors.primary;
          }
          if (states.contains(WidgetState.hovered)) {
            return AppColors.primaryLight;
          }
          return Theme.of(context).colorScheme.onPrimary;
        }),
      ),
    );
  }
}
