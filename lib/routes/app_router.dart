import 'package:artha_pro_app/core/utils/intestment_type.dart';
import 'package:artha_pro_app/core/utils/loan_type.dart';
import 'package:artha_pro_app/core/utils/tax_type.dart';
import 'package:artha_pro_app/screens/main/about/about_screen.dart';
import 'package:artha_pro_app/screens/main/calculators/income_tax_calculator.dart';
import 'package:artha_pro_app/screens/main/calculators/loan_calculator.dart';
import 'package:artha_pro_app/screens/main/calculators/sip_calculator.dart';
import 'package:artha_pro_app/screens/main/calculators/tax_calculator.dart';
import 'package:artha_pro_app/screens/main/home/home_screen.dart';
import 'package:artha_pro_app/screens/main/howitworks/how_it_works.dart';
import 'package:artha_pro_app/screens/main/main_screen.dart';
import 'package:artha_pro_app/screens/main/tools/tools_screen.dart';
import 'package:artha_pro_app/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final navigationKey = GlobalKey<NavigatorState>();
final route = GoRouter(
  navigatorKey: navigationKey,
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => SplashScreen()),
    GoRoute(
      path: '/tools/investment',
      builder: (context, state) {
        final type = state.extra as InvestmentType;
        return SipCalculatorScreen(type: type);
      },
    ),
    GoRoute(
      path: '/tools/loan',
      builder: (context, state) {
        final type = state.extra as LoanType;
        return LoanCalculatorScreen(type: type);
      },
    ),
    GoRoute(
      path: '/tools/tax',
      builder: (context, state) {
        final type = state.extra as TaxType;
        return TaxCalculatorScreen(type: type);
      },
    ),
    GoRoute(
      path: '/tools/incometax',
      builder: (context, state) {
        final type = state.extra as TaxType;
        return IncomeTaxCalculatorscreen(type: type);
      },
    ),
    GoRoute(
      path: '/home/howItworks',
      builder: (context, state) {
        return HowItWorksScreen();
      },
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainScreen(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',
              builder: (context, state) => const HomeScreen(),
            ),
            GoRoute(
              path: '/tools',
              builder: (context, state) => const ToolsScreen(),
            ),
            GoRoute(
              path: '/about',
              builder: (context, state) => const AboutScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);
