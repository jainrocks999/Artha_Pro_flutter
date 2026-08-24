import 'package:artha_pro_app/core/ads/ad_manager.dart';
import 'package:artha_pro_app/core/constants/app_theme.dart';
import 'package:artha_pro_app/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final requestConfiguration = RequestConfiguration(
    maxAdContentRating: MaxAdContentRating.pg,
  );
  await MobileAds.instance.updateRequestConfiguration(requestConfiguration);

  await MobileAds.instance.initialize();
  AdManager.intrestitail.loadAd();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: route,
      debugShowCheckedModeBanner: false,
      title: 'Arth pro',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,

      themeMode: ThemeMode.system,
    );
  }
}
