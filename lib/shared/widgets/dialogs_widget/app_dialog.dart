import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconly/iconly.dart';

// Requires: flutter_screenutil, flutter_animate, iconly
// Requires: AppNavigator + AppRouter from flutter-kit-core
// Place in: lib/shared/widgets/dialogs_widget/app_dialog.dart

import '../../../core/app_navigator.dart';
import '../../../core/routing/app_router.dart';
import 'dialog_types.dart';

class AppDialog {
  static BuildContext get _context {
    final ctx = AppRouter.navigatorKey.currentState?.overlay?.context;
    if (ctx == null) {
      throw Exception(
        "Dialog context not available. Make sure navigatorKey is attached to MaterialApp",
      );
    }
    return ctx;
  }

  static Future<T?> show<T>(Widget dialog, {bool barrierDismissible = true}) {
    return showDialog<T>(
      context: _context,
      barrierDismissible: barrierDismissible,
      useRootNavigator: true,
      builder: (_) => dialog,
    );
  }

  /// REMOVE MEMBER
  static void removeMember({
    required VoidCallback onConfirm,
    String title = "Remove Member",
    String message = "Are you sure you want to remove this member from the group?",
    String cancelText = "Cancel",
    String confirmText = "Remove",
    String? assetImage,
    bool isDanger = true,
  }) {
    show(_DialogWidget(
      type: DialogType.delete,
      title: title,
      message: message,
      cancelText: cancelText,
      confirmText: confirmText,
      isDanger: isDanger,
      assetImage: assetImage,
      onConfirm: onConfirm,
    ));
  }

  /// BLOCK USER
  static void blockUser({
    required VoidCallback onConfirm,
    String title = "Block User",
    String message = "Are you sure you want to block this user? You won't receive messages from them anymore.",
    String cancelText = "Cancel",
    String confirmText = "Block",
    String? assetImage,
    bool isDanger = true,
  }) {
    show(_DialogWidget(
      type: DialogType.warning,
      title: title,
      message: message,
      cancelText: cancelText,
      confirmText: confirmText,
      isDanger: isDanger,
      assetImage: assetImage,
      onConfirm: onConfirm,
    ));
  }

  /// SUCCESS — generic, pass your own title/message
  static void success({
    String title = "Success",
    String message = "Operation completed successfully.",
    bool barrierDismissible = true,
    String? assetImage,
  }) {
    show(
      _DialogWidget(
        type: DialogType.success,
        title: title,
        message: message,
        assetImage: assetImage,
      ),
      barrierDismissible: barrierDismissible,
    );
  }

  /// WARNING — generic, pass your own title/message
  static void warning({
    required VoidCallback onConfirm,
    String title = "Warning",
    String message = "Are you sure you want to proceed?",
    String cancelText = "Go Back",
    String confirmText = "Continue",
    String? assetImage,
  }) {
    show(_DialogWidget(
      type: DialogType.warning,
      title: title,
      message: message,
      cancelText: cancelText,
      confirmText: confirmText,
      assetImage: assetImage,
      onConfirm: onConfirm,
    ));
  }

  /// DELETE
  static void delete({
    required VoidCallback onConfirm,
    String title = "Delete",
    String message = "This will be permanently deleted and cannot be undone.",
    String cancelText = "Don't Delete",
    String confirmText = "Delete Now",
    String? assetImage,
    bool isDanger = true,
  }) {
    show(_DialogWidget(
      type: DialogType.delete,
      title: title,
      message: message,
      cancelText: cancelText,
      confirmText: confirmText,
      isDanger: isDanger,
      assetImage: assetImage,
      onConfirm: onConfirm,
    ));
  }

  /// LEAVE
  static void leave({
    required VoidCallback onConfirm,
    String title = "Leave Group",
    String message = "Are you sure you want to leave group?",
    String cancelText = "Don't Leave",
    String confirmText = "Leave Now",
    bool isDanger = false,
  }) {
    show(_DialogWidget(
      type: DialogType.leave,
      title: title,
      message: message,
      cancelText: cancelText,
      confirmText: confirmText,
      isDanger: isDanger,
      onConfirm: onConfirm,
    ));
  }

  /// MUTE
  static void mute({
    required VoidCallback onConfirm,
    String title = "Mute Notifications",
    String message = "Are you sure you want to mute notifications for this group?",
    String cancelText = "Don't Mute",
    String confirmText = "Mute Now",
    bool isDanger = false,
  }) {
    show(_DialogWidget(
      type: DialogType.mute,
      title: title,
      message: message,
      cancelText: cancelText,
      confirmText: confirmText,
      isDanger: isDanger,
      onConfirm: onConfirm,
    ));
  }

  /// SUBSCRIPTION
  static void subscription({required VoidCallback onConfirm, String? assetImage}) {
    show(_DialogWidget(
      type: DialogType.subscription,
      title: "Buy Plans",
      message: "You need a subscription to use this feature.",
      cancelText: "Cancel",
      confirmText: "View Plans",
      assetImage: assetImage,
      onConfirm: onConfirm,
    ));
  }

  /// LOGOUT
  static void logout({required VoidCallback onConfirm, String? assetImage}) {
    show(_DialogWidget(
      type: DialogType.warning,
      title: "Logout",
      message: "Are you sure you want to logout your account?",
      cancelText: "No",
      confirmText: "Yes",
      assetImage: assetImage,
      onConfirm: onConfirm,
    ));
  }

  /// CLEAR CHAT
  static void clearChat({required VoidCallback onConfirm, String? assetImage}) {
    show(_DialogWidget(
      type: DialogType.clearChat,
      title: "Clear Chat",
      message: "This will remove all your conversation history. This cannot be undone.",
      cancelText: "Cancel",
      confirmText: "Clear Now",
      assetImage: assetImage,
      onConfirm: onConfirm,
    ));
  }

  /// ACCEPT INVITATION
  static void acceptInvitation({
    required VoidCallback onConfirm,
    String title = "Accept Invitation",
    String message = "Are you sure you want to accept this invitation?",
    String cancelText = "Cancel",
    String confirmText = "Accept",
  }) {
    show(_DialogWidget(
      type: DialogType.accept,
      title: title,
      message: message,
      cancelText: cancelText,
      confirmText: confirmText,
      onConfirm: onConfirm,
    ));
  }

  /// REJECT INVITATION
  static void rejectInvitation({
    required VoidCallback onConfirm,
    String title = "Reject Invitation",
    String message = "Are you sure you want to reject this invitation?",
    String cancelText = "Cancel",
    String confirmText = "Reject",
    bool isDanger = true,
  }) {
    show(_DialogWidget(
      type: DialogType.reject,
      title: title,
      message: message,
      cancelText: cancelText,
      confirmText: confirmText,
      isDanger: isDanger,
      onConfirm: onConfirm,
    ));
  }

  /// REPORT USER
  static void reportUser({
    required void Function(String reason) onConfirm,
    String title = "Report User",
    String cancelText = "Cancel",
    String confirmText = "Report",
  }) {
    final controller = TextEditingController();
    show(Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 56,
              width: 56,
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(Icons.report_problem_outlined, color: Colors.orange, size: 26),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controller,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: "Reason for reporting...",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: _DialogButton(
                    text: cancelText,
                    onPressed: AppDialog.close,
                    gradient: [AppNavigator.colors.secondary, AppNavigator.colors.secondary],
                    fontColor: AppNavigator.colors.onSecondary,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _DialogButton(
                    text: confirmText,
                    onPressed: () {
                      if (controller.text.isNotEmpty) {
                        AppDialog.close();
                        onConfirm(controller.text);
                      }
                    },
                    gradient: [Colors.orange, Colors.orangeAccent],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }

  static void close() {
    Navigator.pop(_context);
  }
}

class _DialogWidget extends StatelessWidget {
  final DialogType type;
  final String title;
  final String message;
  final String? cancelText;
  final String? confirmText;
  final bool isDanger;
  final String? assetImage;
  final Color? assetImageColor;
  final VoidCallback? onConfirm;

  const _DialogWidget({
    required this.type,
    required this.title,
    required this.message,
    this.cancelText,
    this.confirmText,
    this.isDanger = false,
    this.assetImage,
    this.assetImageColor,
    this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    final config = DialogTypes.config[type]!;

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Stack(
        children: [
          Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 56,
                      width: 56,
                      decoration: BoxDecoration(
                        color: type == DialogType.warning && title == "Logout"
                            ? const Color(0xFF16A34A)
                            : config.iconColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: assetImage == null
                          ? Icon(
                              type == DialogType.warning && title == "Logout"
                                  ? IconlyLight.logout
                                  : config.icon,
                              color: Colors.white,
                              size: 26,
                            )
                          : Padding(
                              padding: const EdgeInsets.all(12),
                              child: Image.asset(
                                assetImage!,
                                fit: BoxFit.contain,
                                color: assetImageColor,
                                colorBlendMode: assetImageColor != null
                                    ? BlendMode.srcIn
                                    : BlendMode.multiply,
                              ),
                            ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      message,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    const SizedBox(height: 24),
                    if (confirmText != null)
                      Row(
                        children: [
                          if (cancelText != null)
                            Expanded(
                              child: _DialogButton(
                                text: cancelText!,
                                onPressed: AppDialog.close,
                                gradient: [
                                  AppNavigator.colors.secondary,
                                  AppNavigator.colors.secondary,
                                ],
                                fontColor: AppNavigator.colors.onSecondary,
                              ),
                            ),
                          if (cancelText != null) const SizedBox(width: 10),
                          Expanded(
                            child: _DialogButton(
                              text: confirmText!,
                              onPressed: () {
                                AppDialog.close();
                                onConfirm?.call();
                              },
                              gradient: isDanger
                                  ? [Colors.red, Colors.red.withValues(alpha: 0.8)]
                                  : AppNavigator.gradients.primaryGradient,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              )
              .animate()
              .scale(
                duration: 400.ms,
                curve: Curves.easeOutBack,
                begin: const Offset(0.85, 0.85),
              )
              .fadeIn(duration: 300.ms),
          Positioned(
            top: 8,
            right: 8,
            child: GestureDetector(
              onTap: AppDialog.close,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.05),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.close, size: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DialogButton extends StatelessWidget {
  const _DialogButton({
    required this.text,
    required this.onPressed,
    required this.gradient,
    this.fontColor,
  });

  final String text;
  final VoidCallback onPressed;
  final List<Color> gradient;
  final Color? fontColor;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(12.r);
    final colors = AppNavigator.colors;

    return InkWell(
          borderRadius: borderRadius,
          onTap: () {
            HapticFeedback.lightImpact();
            onPressed();
          },
          child: Container(
            height: 54.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: gradient,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: borderRadius,
            ),
            alignment: Alignment.center,
            child: Text(
              text,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: fontColor ?? colors.onPrimary,
              ),
            ),
          ),
        )
        .animate()
        .fadeIn(duration: 300.ms)
        .scale(
          begin: const Offset(0.96, 0.96),
          duration: 200.ms,
          curve: Curves.easeOut,
        );
  }
}
