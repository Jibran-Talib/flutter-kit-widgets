import 'package:flutter/material.dart';
import 'package:material_loading_indicator/loading_indicator.dart';

// Requires: material_loading_indicator
// Place in: lib/shared/widgets/app_loader.dart

import '../../core/app_navigator.dart';

class AppLoader extends StatelessWidget {
  const AppLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          colors: AppNavigator.gradients.primaryGradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ).createShader(bounds);
      },
      blendMode: BlendMode.srcATop,
      child: SizedBox(
        width: 100,
        height: 100,
        child: LoadingIndicator(activeIndicatorColor: Colors.white),
      ),
    );
  }
}
