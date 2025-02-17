import 'dart:html' as html;

/// Loads image from URL input into HTML container
void loadImage(String url) {
  if (url.isEmpty) return;

  final container = html.document.getElementById('image-container');
  if (container != null) {
    container.children.clear();
    final image = html.ImageElement()
      ..src = url
      ..style.width = '100%'
      ..style.height = '100%'
      ..style.objectFit = 'contain';

    image.onDoubleClick.listen((_) => _toggleImageFullscreen(image));
    container.children.add(image);
  }
}

/// Toggles fullscreen mode for image element
void _toggleImageFullscreen(html.ImageElement image) {
  if (html.document.fullscreenElement != null) {
    html.document.exitFullscreen();
  } else {
    image.requestFullscreen();
  }
}
