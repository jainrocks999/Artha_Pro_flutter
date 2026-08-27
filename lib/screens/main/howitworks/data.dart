import 'package:flutter/material.dart';

class _StepData {
  final IconData icon;
  final String title;
  final String description;
  final String shortTitle;

  const _StepData({
    required this.icon,
    required this.title,
    required this.description,
    required this.shortTitle,
  });
}

const List steps = [
  _StepData(
    icon: Icons.grid_view_outlined,
    title: 'Choose Your Financial Goal',
    description:
        'Select the calculator you need from the home screen - Investments, Loans, Taxes & Business and more.',
    shortTitle: 'Choose',
  ),
  _StepData(
    icon: Icons.edit_note_outlined,
    title: 'Enter Your Information',
    description:
        'Enter details like amount, rate, duration, EMI and more. Use sliders to quickly adjust values.',
    shortTitle: 'Enter',
  ),
  _StepData(
    icon: Icons.calculate_outlined,
    title: 'Get Instant Results',
    description:
        'Tap Calculate and get instant, accurate results including returns, maturity, EMI, interest, taxes and more.',
    shortTitle: 'Calculate',
  ),
  _StepData(
    icon: Icons.trending_up,
    title: 'Explore & Compare',
    description:
        'Modify inputs to compare different scenarios. Visual charts help you understand potential growth.',
    shortTitle: 'Understand',
  ),
  _StepData(
    icon: Icons.track_changes_outlined,
    title: 'Make Better Decisions',
    description:
        'Use the insights to plan your investments, loans and taxes with confidence and achieve your financial goals.',
    shortTitle: 'Plan',
  ),
];
