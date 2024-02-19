import "package:flutter/material.dart";
import "package:instagram_flutter/utils/dimensions.dart";

class ResoponsiveLayout extends StatelessWidget {
  final Widget webScreenLayout;
  final Widget mobScreenLayout;
  const ResoponsiveLayout(
      {super.key,
      required this.mobScreenLayout,
      required this.webScreenLayout});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > webScreenSize) {
          return webScreenLayout;
        }
        return mobScreenLayout;
      },
    );
  }
}
