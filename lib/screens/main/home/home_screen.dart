import 'dart:io';

import 'package:artha_pro_app/core/ads/ad_manager.dart';
import 'package:artha_pro_app/core/ads/banner_ad.dart';
import 'package:artha_pro_app/core/constants/app_colors.dart';
import 'package:artha_pro_app/core/model/tools_data.dart';
import 'package:artha_pro_app/core/utils/tax_type.dart';
import 'package:artha_pro_app/core/widgets/app_top_bar.dart';
import 'package:artha_pro_app/core/widgets/home_bottom_card.dart';
import 'package:artha_pro_app/core/widgets/home_top_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final List<Map<String, dynamic>> _topTabList = [
  {'icon': Icons.payments_outlined, 'title': "Investments"},
  {'icon': Icons.account_balance_outlined, 'title': "Loans"},
  {'icon': Icons.receipt_long_outlined, 'title': "Taxs"},
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int activeTab = 0;
  final ScrollController _scrollController = ScrollController();

@override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  List<Widget> _renderContent() {
    switch (activeTab) {
      case 0:
        return investmentData
            .map(
              (item) => _ToolsItem(
                title: item['shortTitle'],
                icon: item['icon'],
                shortDes: item['shortDes'],
                screenTitle: item['title'],
                type: item['type'],
                route: '/tools/investment',
              ),
            )
            .toList();
      case 1:
        return loanData
            .map(
              (item) => _ToolsItem(
                title: item['shortTitle'],
                icon: item['icon'],
                shortDes: item['shortDes'],
                screenTitle: item['title'],
                type: item['type'],
                route: '/tools/loan',
              ),
            )
            .toList();
      case 2:
        return taxData
            .map(
              (item) => _ToolsItem(
                title: item['shortTitle'],
                icon: item['icon'],
                shortDes: item['shortDes'],
                screenTitle: item['title'],
                type: item['type'],
                route: '/tools/tax',
              ),
            )
            .toList();

      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: const AppTopBar(),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(20),
                ),
                boxShadow: [BoxShadow(color: Colors.black54, blurRadius: 20)],
              ),
              // height: 200,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: const HomeTopCard(),
            ),

            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20, top: 20),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: AppColors.secondaryLightText.withAlpha(80),
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(_topTabList.length, (index) {
                    final item = _topTabList[index];
                    return _TopTabItem(
                      title: item['title'],
                      icon: item['icon'],
                      active: activeTab == index,
                      onTap: () {
                        setState(() {
                          activeTab = index;
                        });
                      },
                    );
                  }),
                ),
              ),
            ),
            if (Platform.isIOS) const SizedBox(height: 20),
            BannerAdSection(
              height:
                  MediaQuery.of(context).size.width *
                  (Platform.isIOS ? 0.15 : 0.25),
            ),
            if (Platform.isIOS) const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              child: Wrap(
                spacing: 16,
                runSpacing: 16,
                children: _renderContent().map((item) {
                  return SizedBox(
                    width: (MediaQuery.of(context).size.width - 56) / 2,
                    child: item,
                  );
                }).toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: const HomeBottomCard(),
            ),
          ],
        ),
      ),
    );
  }
}

class _TopTabItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool active;
  final VoidCallback onTap;

  const _TopTabItem({
    required this.title,
    required this.icon,
    this.active = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: active ? AppColors.secondary : Colors.transparent,
            width: 2,
          ),
        ),
      ),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.fromLTRB(3, 0, 3, 3),
          elevation: 0,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Row(
          spacing: 6,
          children: [
            Icon(
              icon,
              color: active ? AppColors.secondary : AppColors.secondaryDarkText,
              size: 22,
            ),
            Text(
              title,
              style: TextStyle(
                color: active
                    ? AppColors.secondary
                    : AppColors.secondaryDarkText,
                fontFamily: 'Manrope',
                fontSize: 13,
                fontWeight: active ? FontWeight.w800 : FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ToolsItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final String shortDes;
  final String screenTitle;
  final Object type;
  final String route;

  const _ToolsItem({
    required this.title,
    required this.icon,
    required this.shortDes,
    required this.screenTitle,
    required this.type,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    void handleNavigation() {
      AdManager.intrestitail.showAd(
        onAdDismissed: () {
          if (!context.mounted) return;
          if (type == TaxType.income) {
            context.push('/tools/incometax', extra: type);
          } else {
            context.push(route, extra: type);
          }
        },
      );
    }

    return SizedBox(
      width: 200,
      child: ElevatedButton(
        onPressed: handleNavigation,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(20),
          backgroundColor: Theme.of(context).colorScheme.onPrimary,
          foregroundColor: Theme.of(context).colorScheme.surface,
          elevation: 3,
          shadowColor: Colors.black45,
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(20),
            side: BorderSide(
              color: Theme.of(context).colorScheme.onSecondary.withAlpha(70),
              width: 2,
            ),
          ),
        ),
        child: SizedBox(
          width: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withAlpha(30),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SizedBox(
                  height: 40,
                  width: 40,
                  child: Icon(
                    icon,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                title.toUpperCase(),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.surface,
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w900,
                  fontSize: 15,
                  letterSpacing: -0.5,
                ),
              ),
              Text(
                shortDes,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.surface,
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.normal,
                  fontSize: 13,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
