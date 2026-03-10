import 'package:artha_pro_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class BottomTabBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  const BottomTabBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 90,
      decoration: const BoxDecoration(
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 12)],
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        selectedItemColor: AppColors.secondary,
        unselectedItemColor: Colors.grey,
        unselectedLabelStyle: const TextStyle(),
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
        iconSize: 25,
        items: _bottomTabList
            .map(
              (item) => BottomNavigationBarItem(
                icon: Icon(item['icon']),
                label: item['title'].toString().toUpperCase(),
              ),
            )
            .toList(),
      ),
    );
  }
}

final List<Map<String, dynamic>> _bottomTabList = [
  {'icon': Icons.home_rounded, 'title': "home"},
  {'icon': Icons.calculate, 'title': "tools"},
  {'icon': Icons.info_rounded, 'title': "about"},
];
