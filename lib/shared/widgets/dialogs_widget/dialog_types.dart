import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

// Requires: iconly
// Place in: lib/shared/widgets/dialogs_widget/dialog_types.dart

enum DialogType {
  success,
  warning,
  delete,
  subscription,
  clearChat,
  mute,
  leave,
  accept,
  reject,
  report,
}

class DialogConfig {
  final IconData icon;
  final Color iconColor;

  const DialogConfig({required this.icon, required this.iconColor});
}

class DialogTypes {
  static const Map<DialogType, DialogConfig> config = {
    DialogType.success: DialogConfig(
      icon: Icons.check,
      iconColor: Color(0xFF16A34A),
    ),
    DialogType.warning: DialogConfig(
      icon: Icons.warning_rounded,
      iconColor: Color(0xFF16A34A),
    ),
    DialogType.delete: DialogConfig(
      icon: IconlyLight.delete,
      iconColor: Color(0xFF0F9D58),
    ),
    DialogType.subscription: DialogConfig(
      icon: Icons.auto_awesome,
      iconColor: Color(0xFF0F9D58),
    ),
    DialogType.clearChat: DialogConfig(
      icon: Icons.delete_sweep_rounded,
      iconColor: Color(0xFF0F9D58),
    ),
    DialogType.mute: DialogConfig(
      icon: Icons.notifications_off_outlined,
      iconColor: Color(0xFF0F9D58),
    ),
    DialogType.leave: DialogConfig(
      icon: Icons.group_outlined,
      iconColor: Color(0xFF0F9D58),
    ),
    DialogType.accept: DialogConfig(
      icon: Icons.check_circle_outline,
      iconColor: Color(0xFF16A34A),
    ),
    DialogType.reject: DialogConfig(
      icon: Icons.cancel_outlined,
      iconColor: Colors.red,
    ),
    DialogType.report: DialogConfig(
      icon: Icons.report_problem_outlined,
      iconColor: Colors.orange,
    ),
  };
}
