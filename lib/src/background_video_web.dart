// ignore_for_file: avoid_web_libraries_in_flutter, deprecated_member_use

import 'dart:html' as html;
import 'dart:ui' show ImageFilter;
import 'dart:ui_web' as ui_web;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BackgroundVideo extends StatefulWidget {
  const BackgroundVideo({
    super.key,
    required this.videoUrl,
    required this.blurSigma,
    required this.overlayOpacity,
  });

  final String videoUrl;
  final double blurSigma;
  final double overlayOpacity;

  @override
  State<BackgroundVideo> createState() => _BackgroundVideoState();
}

class _BackgroundVideoState extends State<BackgroundVideo> {
  static final Set<String> _registeredViewTypes = <String>{};
  late final String _viewType;
  late final html.VideoElement _videoElement;

  @override
  void initState() {
    super.initState();
    _videoElement = html.VideoElement()
      ..src = widget.videoUrl
      ..autoplay = true
      ..loop = true
      ..muted = true
      ..setAttribute('playsinline', 'true');

    final html.CssStyleDeclaration videoStyle = _videoElement.style
      ..width = '100%'
      ..height = '100%'
      ..top = '0'
      ..left = '0'
      ..position = 'absolute';
    videoStyle.setProperty('object-fit', 'cover');
    videoStyle.setProperty('object-position', 'center');

    _viewType = 'background-video-${widget.videoUrl.hashCode}';
    if (!_registeredViewTypes.contains(_viewType)) {
      ui_web.platformViewRegistry.registerViewFactory(
        _viewType,
        (int viewId) => _createWrapper(),
      );
      _registeredViewTypes.add(_viewType);
    }
  }

  html.Element _createWrapper() {
    final html.DivElement wrapper = html.DivElement()
      ..style.width = '100%'
      ..style.height = '100%'
      ..style.overflow = 'hidden'
      ..style.position = 'relative';
    wrapper.append(_videoElement);
    return wrapper;
  }

  @override
  void dispose() {
    _videoElement.pause();
    _videoElement.removeAttribute('src');
    _videoElement.load();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    assert(kIsWeb, 'BackgroundVideo web implementation should only run on web.');
    return Stack(
      fit: StackFit.expand,
      children: [
        HtmlElementView(viewType: _viewType),
        ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: widget.blurSigma,
              sigmaY: widget.blurSigma,
            ),
            child: Container(
              color: Colors.black.withValues(
                alpha: widget.overlayOpacity.clamp(0, 1),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
