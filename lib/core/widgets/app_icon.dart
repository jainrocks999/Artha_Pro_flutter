import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppIcon extends StatelessWidget {
  const AppIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      padding:const  EdgeInsets.all(15),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFFFC107), Color(0xFFFF8F00)],
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x66D4AF37),
            blurRadius: 40,
            spreadRadius: 5,
            offset: Offset(0, 15),
          ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: SvgPicture.asset('assets/icons/SplashIcon.svg'),
    );
  }
}
