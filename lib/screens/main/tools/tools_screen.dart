import 'package:artha_pro_app/core/constants/app_colors.dart';
import 'package:artha_pro_app/core/model/tools_data.dart';
import 'package:artha_pro_app/core/utils/intestment_type.dart';
import 'package:artha_pro_app/core/utils/loan_type.dart';
import 'package:artha_pro_app/core/utils/tax_type.dart';
import 'package:artha_pro_app/core/widgets/app_top_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final List<String> _topBarTitles = ['All', 'Investments', 'Loans', 'Taxes'];

class ToolsScreen extends StatefulWidget {
  const ToolsScreen({super.key});
  @override
  State<ToolsScreen> createState() => _ToolsScreenState();
}

class _ToolsScreenState extends State<ToolsScreen> {
  int activeTab = 0;
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _searchResults = [];

  Widget _renderContent() {
    switch (activeTab) {
      case 0:
        return Column(
          children: [
            _listSection("Investments", investmentData),
            const SizedBox(height: 20),
            _listSection("Loans", loanData),
            const SizedBox(height: 20),
            _listSection("Taxes", taxData),
          ],
        );

      case 1:
        return _listSection("Investments", investmentData);
      case 2:
        return _listSection("Loans", loanData);
      case 3:
        return _listSection("Taxes", taxData);

      default:
        return const SizedBox.shrink();
    }
  }

  void _handleSearch(String quary) {
    if (quary.isEmpty) {
      if (!mounted) return;
      setState(() => _searchResults = []);
    }
    final allData = [...investmentData, ...loanData, ...taxData];
    final result = allData.where((item) {
      final name = item['title'].toString().toLowerCase();
      return name.contains(quary.toLowerCase());
    }).toList();

    if (!mounted) return;
    setState(() {
      _searchResults = List<Map<String, dynamic>>.from(result);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchResults.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppTopBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(20),
                ),
                boxShadow:[BoxShadow(color: Colors.black54, blurRadius: 20)],
              ),
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Financial Tools',
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      color: AppColors.primaryLightText,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _searchController,
                    onChanged: (value) {
                      if (value.trim().length > 2) {
                        _handleSearch(value);
                      }else{
                        setState(() => _searchResults = []);
                      }
                    },
                    cursorColor: AppColors.secondaryLightText,
                    style: const TextStyle(
                      fontSize: 16,
                      color: AppColors.primaryLightText,
                    ),
                    decoration: InputDecoration(
                    hintStyle: TextStyle(color: AppColors.slateLight),
                      prefixIcon: const Icon(Icons.search_rounded,color: AppColors.slateLight,),
                      hintText: 'Search calcutors (e.g SIP,EMI)',
                      fillColor: AppColors.primaryLight,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                          width: 1,
                          color: Color(0xff422f59),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                          width: 1,
                          color: Color(0xff422f59),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            _searchController.text.isNotEmpty &&
                    _searchController.text.trim().length > 2
                ? Padding(
                    padding: const EdgeInsets.all(20),
                    child: _listSection("Results", _searchResults),
                  )
                : Column(
                    children: [
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(
                      //     vertical: 15,
                      //     horizontal: 20,
                      //   ),
                      //   child:
                         SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 20,
                        ),
                            child: SizedBox(
                                width: MediaQuery.of(context).size.width+20,
                              child: Row(
                                spacing: 10,
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: List.generate(
                                  _topBarTitles.length,
                                  (index) => _TopBarItem(
                                    title: _topBarTitles[index],
                                    isActive: activeTab == index,
                                    onTap: () {
                                    FocusScope.of(context).unfocus();
                                      setState(() {
                                        activeTab = index;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      // ),

                      SizedBox(
                        height: 1,
                        width: double.infinity,
                        child: ColoredBox(
                          color: AppColors.secondaryLightText.withAlpha(80),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: _renderContent(),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}

class _TopBarItem extends StatelessWidget {
  final String title;
  final bool isActive;
  final VoidCallback onTap;
  const _TopBarItem({
    required this.title,
    this.isActive = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: isActive 
          ? Theme.of(context).colorScheme.primary 
          : Theme.of(context).colorScheme.onPrimary,
          border: Border.all(
            color: isActive
                ? AppColors.primary
                : AppColors.secondaryLightText.withAlpha(80),
            width: 1,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isActive
                ? AppColors.primaryLightText
                : AppColors.secondaryLightText,
            fontFamily: 'Manrope',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class _ListHeading extends StatelessWidget {
  final String title;
  final int count;
  const _ListHeading({required this.title, required this.count});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontFamily: 'Manrope',
            letterSpacing: -1,
            fontWeight: FontWeight.w900,
            fontSize: 19,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        Text(
          '$count Tools'.toUpperCase(),
          style: const TextStyle(
            fontFamily: 'Manrope',
            fontSize: 12,
            fontWeight: FontWeight.w800,
            color: AppColors.secondary,
          ),
        ),
      ],
    );
  }
}

class _ListItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String shortDes;
  final Object type;
  const _ListItem({
    required this.icon,
    required this.title,
    required this.shortDes,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    void handleNavigation() {
      FocusScope.of(context).unfocus();
      if (type is InvestmentType) {
        context.push('/tools/investment', extra: type);
      } else if (type is LoanType) {
        context.push('/tools/loan', extra: type);
      } else if (type is TaxType) {
        switch (type) {
          case TaxType.gst:
            context.push('/tools/tax', extra: type);
            break;
          case TaxType.income:
            context.push('/tools/incometax', extra: type);
            break;
        }
      }
    }

    return GestureDetector(
      onTap: handleNavigation,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onPrimary,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Theme.of(context).colorScheme.onSecondary.withAlpha(70),
            width: 2,
          ),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 15)],
        ),
        child: Row(
          spacing: 15,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.secondary.withAlpha(30),
                borderRadius: BorderRadius.circular(10),
              ),
              child: SizedBox(
                height: 50,
                width: 50,
                child: Icon(icon, color: AppColors.secondary, size: 28),
              ),
            ),

            Expanded(
              child: Column(
                spacing: 3,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontWeight: FontWeight.w900,
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.surface,
                      letterSpacing: -0.5,
                    ),
                  ),

                  Text(
                    shortDes,
                    style: const TextStyle(
                      fontFamily: 'Manrope',
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                      color: AppColors.slateLight,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _listSection(String title, List<Map<String, dynamic>> data) {
  return Column(
    children: [
      _ListHeading(title: title, count: data.length),
      const SizedBox(height: 10),
      Column(
        spacing: 10,
        children: data.isEmpty
            ? [
                const SizedBox(
                  height: 400,
                  child: Center(
                    child: Text(
                      'No record found',
                      style: TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 15,
                        color: AppColors.secondaryDarkText,
                      ),
                    ),
                  ),
                ),
              ]
            : List.generate(data.length, (index) {
                final item = data[index];

                return _ListItem(
                  type: item['type'],
                  icon: item['icon'],
                  title: item['title'],
                  shortDes: item['des'],
                );
              }),
      ),
    ],
  );
}
