import 'package:flutter/material.dart';
import 'dart:html' as html;

import 'package:img_app/utils/utility.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _urlController = TextEditingController();
  bool _isMenuOpen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Image Viewer')),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Image display area
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: HtmlElementView(viewType: 'image-container'),
                  ),
                ),
                const SizedBox(height: 8),
                // URL input row
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _urlController,
                        decoration: const InputDecoration(
                          hintText: 'Enter image URL',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Load image button
                    ElevatedButton(
                      onPressed: () => loadImage(_urlController.text),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Icon(Icons.arrow_forward),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 64),
              ],
            ),
          ),
          // Fullscreen menu and overlay
          if (_isMenuOpen) _buildMenuOverlay(),
          if (_isMenuOpen) _buildContextMenu(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() => _isMenuOpen = !_isMenuOpen),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildMenuOverlay() {
    return GestureDetector(
      onTap: () => setState(() => _isMenuOpen = false),
      child: Container(
        color: Colors.black54,
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }

  Widget _buildContextMenu() {
    return Positioned(
      right: 16,
      bottom: 80,
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildMenuButton('Enter Fullscreen', () {
              html.document.documentElement?.requestFullscreen();
              setState(() => _isMenuOpen = false);
            }),
            _buildMenuButton('Exit Fullscreen', () {
              if (html.document.fullscreenElement != null) {
                html.document.exitFullscreen();
              }
              setState(() => _isMenuOpen = false);
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuButton(String text, VoidCallback action) {
    return SizedBox(
      width: 150,
      child: TextButton(
        onPressed: action,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Text(text),
        ),
      ),
    );
  }
}
