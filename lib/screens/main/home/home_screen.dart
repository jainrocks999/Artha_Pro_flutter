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
              padding:const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: const HomeTopCard(),
            ),

            Padding(
              padding: const EdgeInsets.all(20),
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

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(bottom: 3),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: active ? AppColors.secondary : Colors.transparent,
              width: 2,
            ),
          ),
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
    return GestureDetector(
      onTap: () {
        if (type == TaxType.income) {
          context.push('/tools/incometax', extra: type);
        } else {
          context.push(route, extra: type);
        }
      },
      child: Container(
        width: 200,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onPrimary,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
              color: Theme.of(context).colorScheme.onSecondary.withAlpha(70),
            width: 2,
          ),
          boxShadow:const [BoxShadow(color: Colors.black12, blurRadius: 15)],
        ),
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
                child: Icon(icon, color: Theme.of(context).colorScheme.primary),
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
    );
  }
}
