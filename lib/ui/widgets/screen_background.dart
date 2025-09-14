import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/assets_paths.dart';

class ScreenBackground extends StatelessWidget {
  const ScreenBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(AssetsPath.backgroundSvg, width: double.infinity, height: double.infinity, fit: BoxFit.cover,),
        SafeArea(child: child),

      ],
    );
  }
}
