import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tweleve_ace/core/utils/global_loading.dart';

class AppImage extends StatelessWidget {
  final String url;
  final BoxFit? fit;
  final double? width;
  final double? height;

  const AppImage({
    super.key,
    required this.url,
    this.fit,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      progressIndicatorBuilder: (context, url, progress) => GlobalLoading(),
      fit: fit ?? BoxFit.contain,
      width: width,
      height: height,
    );
  }
}
