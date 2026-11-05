import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconly/iconly.dart';

// Requires: flutter_screenutil, flutter_animate, iconly
// Requires: AppNavigator from flutter-kit-core
// Place in: lib/shared/widgets/button_component.dart

// ignore: depend_on_referenced_packages
import '../../core/app_navigator.dart';
import '../../core/constants/app_colors.dart';

class ButtonComponent extends StatelessWidget {
  const ButtonComponent({
    super.key,
    required this.buttonText,
    required this.onPressed,
    this.gradient,
    this.height,
    this.width,
    this.radius,
    this.fontSize,
    this.fontWeight,
    this.fontColor,
    this.icon,
    this.iconSize,
    this.iconColor,
    this.isLoading = false,
    this.enabled = true,
    this.borderColor,
    this.borderWidth,
    this.backgroundColor,
  });

  factory ButtonComponent.primary({
    required String text,
    required VoidCallback onPressed,
    bool enabled = true,
    bool isLoading = false,
    double? height,
    double? width,
    double? radius,
    IconData? icon,
    double? iconSize,
    Color? iconColor,
    Color? fontColor,
  }) {
    return ButtonComponent(
      buttonText: text,
      onPressed: onPressed,
      enabled: enabled,
      isLoading: isLoading,
      height: height,
      width: width,
      radius: radius ?? 12.r,
      gradient: AppNavigator.gradients.primaryGradient,
      icon: icon,
      iconSize: iconSize,
      iconColor: iconColor,
      fontColor: fontColor,
    );
  }

  factory ButtonComponent.grey({
    required String text,
    required VoidCallback onPressed,
    bool enabled = true,
    bool isLoading = false,
  }) {
    return ButtonComponent(
      buttonText: text,
      onPressed: onPressed,
      enabled: enabled,
      isLoading: isLoading,
      radius: 12.r,
      gradient: [AppNavigator.colors.secondary, AppNavigator.colors.secondary],
      fontColor: AppNavigator.colors.onSecondary,
    );
  }

  factory ButtonComponent.disabled({required String text}) {
    return ButtonComponent(
      buttonText: text,
      onPressed: () {},
      enabled: false,
      radius: 12.r,
      gradient: AppNavigator.gradients.primaryGradient,
      fontColor: AppNavigator.colors.onPrimary,
    );
  }

  factory ButtonComponent.delete({
    required String text,
    required VoidCallback onPressed,
    bool enabled = true,
    bool isLoading = false,
  }) {
    return ButtonComponent(
      buttonText: text,
      onPressed: onPressed,
      enabled: enabled,
      isLoading: isLoading,
      radius: 12.r,
      gradient: [AppColors.error, AppColors.error],
      fontColor: Colors.white,
    );
  }

  factory ButtonComponent.outline({
    required String text,
    required VoidCallback onPressed,
    bool enabled = true,
    bool isLoading = false,
  }) {
    return ButtonComponent(
      buttonText: text,
      onPressed: onPressed,
      enabled: enabled,
      isLoading: isLoading,
      radius: 12.r,
      gradient: null,
      height: 42.h,
      backgroundColor: Colors.transparent,
      borderColor: Colors.grey,
      borderWidth: 1.5,
      fontColor: AppNavigator.colors.onSurface,
    );
  }

  factory ButtonComponent.edit({
    required String text,
    required VoidCallback onPressed,
    bool enabled = true,
    bool isLoading = false,
  }) {
    return ButtonComponent(
      buttonText: text,
      onPressed: onPressed,
      enabled: enabled,
      isLoading: isLoading,
      radius: 12.r,
      gradient: null,
      backgroundColor: AppNavigator.colors.surface,
      icon: IconlyLight.edit,
    );
  }

  final String buttonText;
  final VoidCallback onPressed;
  final List<Color>? gradient;
  final double? height;
  final double? width;
  final double? radius;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? fontColor;
  final IconData? icon;
  final double? iconSize;
  final Color? iconColor;
  final bool isLoading;
  final bool enabled;
  final Color? borderColor;
  final double? borderWidth;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(radius ?? 40.r);
    final colors = AppNavigator.colors;

    return InkWell(
          borderRadius: borderRadius,
          onTap: (!enabled || isLoading)
              ? null
              : () {
                  HapticFeedback.lightImpact();
                  onPressed();
                },
          child: Container(
            width: width ?? double.infinity,
            height: height ?? 44.h,
            decoration: BoxDecoration(
              color: backgroundColor,
              gradient: backgroundColor == Colors.transparent
                  ? null
                  : (enabled
                        ? LinearGradient(
                            colors: gradient ?? [colors.primary, colors.primary.withValues(alpha: 0.9)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )
                        : LinearGradient(
                            colors: [colors.secondary, colors.secondary.withValues(alpha: 0.9)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )),
              borderRadius: borderRadius,
              border: borderColor != null
                  ? Border.all(color: borderColor!, width: borderWidth ?? 1)
                  : null,
            ),
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null) ...[
                  Icon(icon, size: iconSize ?? 18.sp, color: iconColor ?? fontColor ?? colors.onPrimary),
                  SizedBox(width: 8.w),
                ],
                Text(
                  buttonText,
                  style: TextStyle(
                    fontSize: fontSize ?? 16.sp,
                    fontWeight: fontWeight ?? FontWeight.w600,
                    color: fontColor ?? colors.onPrimary,
                  ),
                ),
              ],
            ),
          ),
        )
        .animate()
        .fadeIn(duration: 300.ms)
        .scale(begin: const Offset(0.96, 0.96), duration: 200.ms, curve: Curves.easeOut);
  }
}
