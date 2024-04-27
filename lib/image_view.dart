

import 'dart:io';

import 'package:flutter/material.dart';

class ImageViewWidget extends StatelessWidget {
  final String imagePath;
  final String name;
  const ImageViewWidget({super.key, required this.imagePath,required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(name),
      ),
      body: Center(
        child: Image.file(
          File(imagePath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
