import 'package:flutter/material.dart';

// Requires: nothing extra
// Place in: lib/shared/widgets/response_widget.dart
// Usage:
//   ResponseWidget.success(title: 'Saved successfully')
//   ResponseWidget.error(title: state.message ?? 'Something went wrong')

import '../../core/constants/app_colors.dart';

class ResponseWidget extends StatelessWidget {
  final Color backgroundColor;
  final Color textColor;
  final Widget icon;
  final String title;
  final EdgeInsetsGeometry padding;

  const ResponseWidget._({
    super.key,
    required this.backgroundColor,
    required this.textColor,
    required this.icon,
    required this.title,
    this.padding = const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
  });

  factory ResponseWidget.success({required String title}) {
    return ResponseWidget._(
      backgroundColor: AppColors.success.withValues(alpha: 0.15),
      textColor: AppColors.success,
      icon: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: AppColors.success),
        child: const Icon(Icons.check, size: 12, color: AppColors.white),
      ),
      title: title,
    );
  }

  factory ResponseWidget.error({required String title}) {
    return ResponseWidget._(
      backgroundColor: AppColors.error.withValues(alpha: 0.15),
      textColor: AppColors.error,
      icon: const SizedBox(
        width: 28,
        height: 21,
        child: Icon(Icons.warning, size: 18, color: AppColors.error),
      ),
      title: title,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: icon),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: TextStyle(color: textColor, fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
