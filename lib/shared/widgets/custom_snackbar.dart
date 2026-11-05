import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

// Requires: flutter_animate
// Place in: lib/shared/widgets/custom_snackbar.dart

import '../../core/theme/theme_extensions.dart';

class CustomSnackBar {
  static OverlayEntry? _currentEntry;

  static void success(BuildContext context, String message) {
    _show(context, message, color: context.colors.primary, icon: Icons.check_circle);
  }

  static void error(BuildContext context, String message) {
    _show(context, message, color: context.colors.error, icon: Icons.error);
  }

  static void _show(
    BuildContext context,
    String message, {
    required Color color,
    required IconData icon,
  }) {
    if (!context.mounted) return;

    final overlay = Navigator.of(context, rootNavigator: true).overlay;
    if (overlay == null) return;

    if (_currentEntry != null) return;

    late OverlayEntry entry;
    var isRemoved = false;

    void safelyRemoveEntry() {
      if (isRemoved) return;
      isRemoved = true;
      if (entry.mounted) entry.remove();
      if (identical(_currentEntry, entry)) _currentEntry = null;
    }

    entry = OverlayEntry(
      builder: (_) => _TopSnackBarWidget(
        message: message,
        color: color,
        icon: icon,
        onDismiss: safelyRemoveEntry,
      ),
    );

    _currentEntry = entry;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      overlay.insert(entry);
    });

    Future.delayed(const Duration(seconds: 3)).then((_) {
      safelyRemoveEntry();
    });
  }
}

class _TopSnackBarWidget extends StatelessWidget {
  const _TopSnackBarWidget({
    required this.message,
    required this.color,
    required this.icon,
    required this.onDismiss,
  });

  final String message;
  final Color color;
  final IconData icon;
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: false,
      child: Material(
        color: Colors.transparent,
        child: Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Dismissible(
              key: const ValueKey('top_snackbar'),
              direction: DismissDirection.up,
              onDismissed: (_) => onDismiss(),
              child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: const [
                        BoxShadow(blurRadius: 12, color: Colors.black26, offset: Offset(0, 6)),
                      ],
                    ),
                    child: Row(
                      children: [
                        Icon(icon, color: context.colors.onPrimary),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            message,
                            style: TextStyle(
                              color: context.colors.onPrimary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                  .animate()
                  .slideY(begin: -1, end: 0, duration: 300.ms)
                  .fade(duration: 250.ms),
            ),
          ),
        ),
      ),
    );
  }
}
