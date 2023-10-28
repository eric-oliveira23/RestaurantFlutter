import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:convert';

class ImageFromBase64 extends StatelessWidget {
  final String base64String;
  final double? width;
  final double? height;

  const ImageFromBase64({
    super.key,
    required this.base64String,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    List<int> bytes = base64.decode(base64String);

    return Image.memory(
      gaplessPlayback: true,
      height: height,
      width: width,
      Uint8List.fromList(bytes),
      fit: BoxFit.fill,
    );
  }
}
