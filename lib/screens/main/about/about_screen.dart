import 'dart:io';

import 'package:artha_pro_app/core/constants/app_colors.dart';
import 'package:artha_pro_app/core/widgets/app_icon.dart';
import 'package:artha_pro_app/core/widgets/app_top_bar.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  String appVersion = '';
  @override
  void initState() {
    super.initState();
    _loadVersion();
  }

  Future<void> _loadVersion() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      appVersion = 'Version ${info.version}';
    });
  }

  Future<void> openUrl(String url) async {
    final Uri uri = Uri.parse(url);

    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppTopBar(title: 'About'),
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
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            ),
            SizedBox(
              height: 350,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const AppIcon(),
                  const SizedBox(height: 20),
                  Text(
                    'Arth Pro',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontFamily: 'Manrope',
                      fontWeight: FontWeight.w900,
                      fontSize: 23,
                    ),
                  ),
                  Text(
                    appVersion,
                    style: TextStyle(
                      color: AppColors.slateLight,
                      fontFamily: 'Manrope',
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),

            Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onPrimary,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppColors.secondaryLightText.withAlpha(70),
                  width: 2,
                ),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 15),
                ],
              ),
              child: Column(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Our Mission',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontFamily: 'Manrope',
                      fontWeight: FontWeight.w900,
                      fontSize: 16,
                    ),
                  ),
                  const Text(
                    'Empowering everyone with premium financial tools for a smarter future. ArthPro is built to simplify your financial journey with institutional-grade insights and secure management.',
                    style: TextStyle(
                      color: AppColors.slateLight,
                      fontFamily: 'Manrope',
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            _MenuItem(
              prefixIcon: Icons.support_agent_rounded,
              lable: 'Contact Support',
              onPress: () => openUrl('https://forebearpro.com/support/'),
            ),
            const SizedBox(height: 15),
            _MenuItem(
              prefixIcon: Icons.star_rate_rounded,
              lable: 'Rate Us',
              onPress: () => openUrl(
                Platform.isIOS
                    ? 'https://forebearpro.com/'
                    : 'https://play.google.com/store/apps/details?id=com.arthapro.calculator&pcampaignid=web_share',
              ),
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData prefixIcon;
  final String lable;
  final VoidCallback? onPress;
  const _MenuItem({
    required this.prefixIcon,
    required this.lable,
    this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ElevatedButton(
        onPressed: onPress,
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.onPrimary,
          foregroundColor: Theme.of(context).colorScheme.primary,
          elevation: 1,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
              color: AppColors.secondaryLightText.withAlpha(70),
              width: 0.5,
            ),
          ),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Row(
          spacing: 10,
          children: [
            Icon(prefixIcon, size: 25, color: AppColors.slateLight),
            Text(
              lable,
              style: TextStyle(
                fontFamily: 'Manrope',
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const Spacer(),
            Icon(
              Icons.chevron_right_rounded,
              size: 30,
              color: AppColors.secondaryLightText,
            ),
          ],
        ),
      ),
    );
  }
}
