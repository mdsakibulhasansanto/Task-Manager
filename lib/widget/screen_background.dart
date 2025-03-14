import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../ui/utils/assets_path.dart';

class screenBackground extends StatelessWidget {
  const screenBackground({
    super.key,
    required this.child,
  });

  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          AssetsPath.background,
          fit: BoxFit.cover,
          height: double.maxFinite,
          width: double.maxFinite,
        ),
        SafeArea(child: child)
      ],
    );
  }
}
