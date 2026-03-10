import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryBg = Color(0xfffef8ff);
  // primary
  static const Color primary = Color(0xFF26103B);
  static const Color primaryLight = Color(0xFF2C1945);

  //secondary
  static const Color secondary = Color(0xFFd4AF38);
  static const Color secondaryLightDark = Color(0xFFba983c);
  static const Color secondaryLight = Color(0xFFFFC107);
  static const Color slateLight = Color(0xFF64748B);
  static const Color lightGreen = Color(0xff3cc853);

  //text color
  static const Color primaryDarkText = Color(0xff200b3c);
  static const Color primaryLightText = Color(0xffffffff);
  static const Color secondaryDarkText = Color(0xff788599);
  static const Color secondaryLightText = Color(0xffbcb6c5);

  static const Color textColor = Color((0xff000000));
  static const Color smCardColor = Color(0xfff7f6f8);

  static const Color inputColor = Color(0xfffef8ff);
  static const Color appBarColor = Color(0xfffefeff);
}

class AppDarkColors {
  static const Color primaryBg = Color(0xff1c0f2c);

  static const Color primary = Color(0xffbcb6c5);

  static const Color primaryLightText = Color(0xFF2C1945);
  static const Color secondaryLightText = Color(0xff422f59);

  static const Color textColor = Color((0xffbcb6c5));

  static const Color smCardColor = Color((0xff240e45));
  static const Color inputColor = Color(0xff1c0f2c);
  static const Color appBarColor = Color(0xFF26103B);
}

class AppInputeBorders {
  static OutlineInputBorder primary({double radius = 20}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius),
      borderSide: BorderSide(color: AppColors.secondaryLightText.withAlpha(80)),
    );
  }

  static OutlineInputBorder error({double radius = 20}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius),
      borderSide: BorderSide(color: Colors.red),
    );
  }
}

class AppCardThemes {
  static BoxDecoration whiteCard( BuildContext context,{double radius = 20, bool shadow = true}) {
    return BoxDecoration(
      color: Theme.of(context).colorScheme.onPrimary,
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(
        color: Theme.of(context).colorScheme.onSecondary.withAlpha(70),
        width: 2,
      ),

      boxShadow: shadow
          ? const [BoxShadow(color: Colors.black12, blurRadius: 5)]
          : null,
    );
  }
}
