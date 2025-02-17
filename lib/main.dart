import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'dart:ui_web' as web_ui;

import 'package:img_app/views/home_page.dart';

void main() {
  // Using the web_ui prefix for web-specific UI components
  web_ui.PlatformViewRegistry().registerViewFactory(
    'image-container',
    (int viewId) => html.DivElement()
      ..id = 'image-container'
      ..style.width = '100%'
      ..style.height = '100%'
      ..style.objectFit = 'contain',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Viewer',
      home: const HomePage(),
    );
  }
}
