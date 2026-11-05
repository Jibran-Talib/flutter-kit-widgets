import 'package:flutter/material.dart';

// Place in: lib/shared/widgets/text_component.dart
// Usage:
//   TextComponent(text: 'Hello', color: AppColors.primary, fontWeight: FontWeight.bold)
//   TextComponent(text: 'Gradient', color: AppNavigator.gradients.primaryGradient)

enum FontFamilyEnum { generalSans, manrope }

String getFontFamilyName(FontFamilyEnum fontFamily) {
  switch (fontFamily) {
    case FontFamilyEnum.manrope:
      return 'Manrope';
    case FontFamilyEnum.generalSans:
      return 'GeneralSans';
  }
}

class TextComponent extends StatelessWidget {
  const TextComponent({
    super.key,
    required this.text,
    this.color = Colors.black,
    this.fontWeight,
    this.fontsize,
    this.overflow,
    this.textAlign,
    this.fontFamily = FontFamilyEnum.generalSans,
    this.decoration,
    this.maxLines,
    this.softWrap = true,
    this.maxCharacters,
  });

  final String text;
  final dynamic color;
  final bool softWrap;
  final FontWeight? fontWeight;
  final double? fontsize;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final FontFamilyEnum fontFamily;
  final TextDecoration? decoration;
  final int? maxLines;
  final int? maxCharacters;

  String _getLimitedText(String input) {
    if (maxCharacters != null && input.length > maxCharacters!) {
      return '${input.substring(0, maxCharacters!)}...';
    }
    return input;
  }

  @override
  Widget build(BuildContext context) {
    final family = getFontFamilyName(fontFamily);
    final displayText = _getLimitedText(text);

    if (color is List<Color>) {
      return ShaderMask(
        shaderCallback: (bounds) => LinearGradient(
          colors: color as List<Color>,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
        child: Text(
          displayText,
          textAlign: textAlign,
          maxLines: maxLines,
          softWrap: softWrap,
          overflow: overflow,
          style: TextStyle(
            fontSize: fontsize,
            fontWeight: fontWeight,
            fontFamily: family,
            color: Colors.white,
            decoration: decoration,
            decorationColor: Colors.white,
          ),
        ),
      );
    } else {
      return Text(
        displayText,
        textAlign: textAlign,
        maxLines: maxLines,
        softWrap: softWrap,
        overflow: overflow,
        style: TextStyle(
          color: color as Color?,
          fontWeight: fontWeight,
          fontFamily: family,
          fontSize: fontsize,
          decoration: decoration,
          decorationColor: color as Color?,
        ),
      );
    }
  }
}
