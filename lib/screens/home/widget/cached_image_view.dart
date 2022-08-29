import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedImageView extends StatelessWidget {
  final String? url;

  const CachedImageView({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (url == null) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.primaries[Random().nextInt(Colors.primaries.length)]
              .withOpacity(0.2),
        ),
      );
    }
    return CachedNetworkImage(
      imageUrl: url!,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
            colorFilter: const ColorFilter.mode(
              Colors.blueGrey,
              BlendMode.colorBurn,
            ),
          ),
        ),
      ),
      placeholder: (context, url) => Container(
        color: Colors.primaries[Random().nextInt(Colors.primaries.length)]
            .withOpacity(0.2),
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
      fadeOutDuration: const Duration(milliseconds: 300),
      fadeInDuration: const Duration(milliseconds: 300),
    );
  }
}
