import 'package:flutter/material.dart';

// Place in: lib/shared/widgets/loader_overlay.dart

import 'app_loader.dart';

class LoaderOverlay extends StatelessWidget {
  const LoaderOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withValues(alpha: 0.3),
      child: const Center(child: AppLoader()),
    );
  }
}
