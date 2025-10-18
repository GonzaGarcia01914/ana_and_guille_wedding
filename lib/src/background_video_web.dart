// ignore_for_file: avoid_web_libraries_in_flutter, deprecated_member_use

import 'dart:async';
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
  String? _resolvedVideoUrl;
  StreamSubscription<html.Event>? _canPlaySubscription;
  StreamSubscription<html.Event>? _errorSubscription;

  @override
  void initState() {
    super.initState();
    _videoElement = html.VideoElement()
      ..autoplay = true
      ..loop = true
      ..muted = true
      ..preload = 'auto'
      ..setAttribute('playsinline', 'true')
      ..setAttribute('muted', 'true');

    final html.CssStyleDeclaration videoStyle = _videoElement.style
      ..width = '100%'
      ..height = '100%'
      ..top = '0'
      ..left = '0'
      ..position = 'absolute';
    videoStyle.setProperty('object-fit', 'cover');
    videoStyle.setProperty('object-position', 'center');
    videoStyle.setProperty('pointer-events', 'none');

    _viewType = 'background-video-${widget.videoUrl.hashCode}';
    if (!_registeredViewTypes.contains(_viewType)) {
      ui_web.platformViewRegistry.registerViewFactory(
        _viewType,
        (int viewId) => _createWrapper(),
      );
      _registeredViewTypes.add(_viewType);
    }

    _resolvedVideoUrl = _resolveVideoUrl(widget.videoUrl);
    _videoElement.src = _resolvedVideoUrl ?? widget.videoUrl;

    _canPlaySubscription = _videoElement.onCanPlay.listen((_) {
      // Ensure playback starts even if autoplay promises are required.
      unawaited(_videoElement.play());
    });
    _errorSubscription = _videoElement.onError.listen((html.Event event) {
      debugPrint(
        'Background video failed to load: ${_resolvedVideoUrl ?? widget.videoUrl}',
      );
    });
  }

  html.Element _createWrapper() {
    final html.DivElement wrapper = html.DivElement()
      ..style.width = '100%'
      ..style.height = '100%'
      ..style.overflow = 'hidden'
      ..style.position = 'relative'
      ..style.pointerEvents = 'none'
      ..style.background =
          'linear-gradient(135deg, #2F3C35 0%, #4A665A 100%)';
    wrapper.append(_videoElement);
    return wrapper;
  }

  @override
  void didUpdateWidget(covariant BackgroundVideo oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.videoUrl != widget.videoUrl) {
      _updateVideoSource();
    }
  }

  void _updateVideoSource() {
    final String? newSource = _resolveVideoUrl(widget.videoUrl);
    if (newSource == _resolvedVideoUrl) {
      return;
    }
    _resolvedVideoUrl = newSource;
    _videoElement
      ..pause()
      ..src = _resolvedVideoUrl ?? widget.videoUrl;
    _videoElement.load();
    unawaited(_videoElement.play());
  }

  @override
  void dispose() {
    _canPlaySubscription?.cancel();
    _errorSubscription?.cancel();
    _videoElement.pause();
    _videoElement.removeAttribute('src');
    _videoElement.load();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    assert(
      kIsWeb,
      'BackgroundVideo web implementation should only run on web.',
    );
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

  String? _resolveVideoUrl(String rawUrl) {
    if (rawUrl.isEmpty) {
      return null;
    }
    try {
      final uri = Uri.parse(rawUrl);
      if (uri.hasScheme || rawUrl.startsWith('//')) {
        return rawUrl;
      }
      return Uri.base.resolveUri(uri).toString();
    } on FormatException {
      return rawUrl;
    }
  }
}
