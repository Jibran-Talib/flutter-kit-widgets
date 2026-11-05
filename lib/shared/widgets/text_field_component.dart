import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Requires: nothing extra
// Place in: lib/shared/widgets/text_field_component.dart

import '../../core/constants/app_colors.dart';
import '../../core/theme/theme_extensions.dart';

class InputField extends StatelessWidget {
  const InputField({
    super.key,
    this.labelText,
    this.hintText,
    this.initialValue,
    this.obscureText,
    this.isPassword,
    this.inLineLabel = false,
    this.readOnly,
    this.disabled = false,
    this.filled = true,
    this.isDense = true,
    this.controller,
    this.suffixIcon,
    this.prefixIcon,
    this.validator,
    this.onChanged,
    this.onTap,
    this.keyboardType,
    this.contentPadding,
    this.showBorder = false,
    this.radius,
    this.maxLines = 1,
    this.showLimit = false,
    this.maxLength,
    this.minLines,
    this.labelColor,
    this.onFieldSubmitted,
    this.onEditingComplete,
    this.focusNode,
    this.nextFocusNode,
    this.textCapitalization = TextCapitalization.sentences,
    this.formatter,
    this.decoration,
    this.hintStyle,
    this.textInputAction,
    this.textColor,
    this.fillColor,
  });

  final TextEditingController? controller;
  final List<TextInputFormatter>? formatter;
  final String? labelText;
  final String? hintText;
  final String? initialValue;
  final Color? labelColor;
  final bool inLineLabel;
  final bool showLimit;
  final bool? obscureText;
  final bool? isPassword;
  final bool? readOnly;
  final bool? hideText = false;
  final bool filled;
  final bool disabled;
  final bool isDense;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final EdgeInsets? contentPadding;
  final FormFieldValidator<String>? validator;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final TextInputType? keyboardType;
  final bool showBorder;
  final double? radius;
  final int? maxLines;
  final int? maxLength;
  final int? minLines;
  final TextCapitalization textCapitalization;
  final void Function()? onEditingComplete;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final InputDecoration? decoration;
  final TextStyle? hintStyle;
  final TextInputAction? textInputAction;
  final Color? textColor;
  final Color? fillColor;

  void _handleFieldSubmitted(String v) {
    if (onFieldSubmitted != null) {
      onFieldSubmitted!(v);
    } else if (nextFocusNode != null) {
      nextFocusNode!.requestFocus();
    } else {
      focusNode?.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final effectiveObscureText = obscureText ?? isPassword ?? false;
    final effectiveReadOnly = readOnly ?? false;

    final textField = TextFormField(
      onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
      obscureText: effectiveObscureText,
      style: context.textTheme.bodyMedium?.copyWith(color: textColor ?? AppColors.black),
      textInputAction: textInputAction ??
          (nextFocusNode != null ? TextInputAction.next : TextInputAction.done),
      focusNode: focusNode,
      initialValue: initialValue,
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      readOnly: effectiveReadOnly,
      inputFormatters: formatter,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onTap: onTap,
      onChanged: onChanged,
      enabled: !disabled,
      maxLines: effectiveObscureText ? 1 : maxLines,
      minLines: minLines,
      maxLength: maxLength,
      onFieldSubmitted: _handleFieldSubmitted,
      onEditingComplete: onEditingComplete,
      textCapitalization: keyboardType == TextInputType.emailAddress
          ? TextCapitalization.none
          : textCapitalization,
      decoration: decoration ??
          InputDecoration(
            filled: filled,
            errorMaxLines: 3,
            fillColor: fillColor ?? (disabled ? Colors.white : null),
            counterText: !showLimit ? '' : null,
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            counterStyle: context.textTheme.bodySmall?.copyWith(color: AppColors.black),
            isDense: isDense,
            contentPadding: contentPadding,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: hintText,
            hintStyle: hintStyle ?? TextStyle(color: context.colors.secondary),
            border: showBorder
                ? OutlineInputBorder(
                    borderRadius: BorderRadius.circular(radius ?? 8),
                    borderSide: const BorderSide(color: Color(0xffCCCCCC)),
                  )
                : null,
            enabledBorder: showBorder
                ? OutlineInputBorder(
                    borderRadius: BorderRadius.circular(radius ?? 8),
                    borderSide: const BorderSide(color: Color(0xffCCCCCC)),
                  )
                : null,
            focusedBorder: showBorder
                ? OutlineInputBorder(
                    borderRadius: BorderRadius.circular(radius ?? 8),
                    borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.5),
                  )
                : null,
          ),
    );

    if (labelText?.isNotEmpty ?? false) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(labelText!, style: context.textTheme.titleMedium?.copyWith(color: labelColor)),
          const SizedBox(height: 5),
          textField,
        ],
      );
    }
    return textField;
  }
}
