import 'package:artha_pro_app/core/widgets/bottom_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainScreen extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const MainScreen({super.key, required this.navigationShell});

  int _getIndex(String loaction) {
    if (loaction.startsWith('/tools')) return 1;
    if (loaction.startsWith('/about')) return 2;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    final currentIndex = _getIndex(location);
    return Scaffold(
      appBar: null,
      body: navigationShell,
      bottomNavigationBar: BottomTabBar(
        currentIndex: currentIndex,
        onTap: (index) {
          switch (index) {
            case 0:
              if (location != '/home') {
                context.go('/home');
              }
              break;
            case 1:
              if (location != '/tools') {
                context.push('/tools');
              }
              break;
            case 2:
              if (location != '/about') {
                context.push('/about');
              }
              break;
          }
        },
      ),
    );
  }
}
