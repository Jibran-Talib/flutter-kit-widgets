import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

// Requires: cached_network_image
// Place in: lib/shared/widgets/cache_image_component.dart

class CachedImageComponent extends StatelessWidget {
  final String imageUrl;
  final double? imageSize;
  final Widget? loaderWidget;
  final Widget defaultWidget;
  final BoxFit? imageBoxFit;
  final BlendMode? colorBlendMode;
  final Color? imageColor;

  const CachedImageComponent({
    super.key,
    required this.imageUrl,
    this.imageSize,
    this.loaderWidget,
    this.defaultWidget = const Icon(Icons.error),
    this.imageBoxFit = BoxFit.contain,
    this.colorBlendMode,
    this.imageColor,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return CachedNetworkImage(
      height: imageSize,
      width: imageSize,
      imageUrl: imageUrl,
      fit: imageBoxFit,
      color: imageColor,
      colorBlendMode: colorBlendMode,
      placeholder: (context, url) => Center(
        child: SizedBox(
          height: 30,
          width: 30,
          child: CircularProgressIndicator(
            strokeWidth: 2.5,
            backgroundColor: colorScheme.primaryContainer,
          ),
        ),
      ),
      errorWidget: (context, url, error) => defaultWidget,
    );
  }
}
