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
    this.audioUrl,
    this.audioStartPosition = 0,
  });

  final String videoUrl;
  final double blurSigma;
  final double overlayOpacity;
  final String? audioUrl;
  final double audioStartPosition;

  @override
  State<BackgroundVideo> createState() => _BackgroundVideoState();
}

class _BackgroundVideoState extends State<BackgroundVideo> {
  static final Set<String> _registeredViewTypes = <String>{};
  late final String _viewType;
  late final html.VideoElement _videoElement;
  html.DivElement? _wrapperElement;
  String? _resolvedVideoUrl;
  html.AudioElement? _audioElement;
  String? _resolvedAudioUrl;
  StreamSubscription<html.Event>? _canPlaySubscription;
  StreamSubscription<html.Event>? _errorSubscription;
  StreamSubscription<html.Event>? _audioCanPlaySubscription;
  StreamSubscription<html.Event>? _audioErrorSubscription;
  StreamSubscription<html.Event>? _audioMetadataSubscription;
  final List<StreamSubscription<html.Event>> _userInteractionSubscriptions = [];
  bool _audioStartApplied = false;

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

    _resolvedVideoUrl = _resolveMediaUrl(widget.videoUrl);
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

    if (widget.audioUrl != null && widget.audioUrl!.isNotEmpty) {
      _audioStartApplied = false;
      _initializeAudioElement(widget.audioUrl!);
    }
  }

  html.Element _createWrapper() {
    _wrapperElement = html.DivElement()
      ..style.width = '100%'
      ..style.height = '100%'
      ..style.overflow = 'hidden'
      ..style.position = 'relative'
      ..style.pointerEvents = 'none'
      ..style.background =
          'linear-gradient(135deg, #2F3C35 0%, #4A665A 100%)';
    _wrapperElement!.append(_videoElement);
    if (_audioElement != null) {
      _wrapperElement!.append(_audioElement!);
    }
    return _wrapperElement!;
  }

  @override
  void didUpdateWidget(covariant BackgroundVideo oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.videoUrl != widget.videoUrl) {
      _updateVideoSource();
    }
    if (oldWidget.audioUrl != widget.audioUrl) {
      _audioStartApplied = false;
      _updateAudioSource();
    } else if (oldWidget.audioStartPosition != widget.audioStartPosition) {
      _audioStartApplied = false;
      _seekAudioToStart();
    }
  }

  void _updateVideoSource() {
    final String? newSource = _resolveMediaUrl(widget.videoUrl);
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
    _disposeAudioElement();
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

  String? _resolveMediaUrl(String rawUrl) {
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

  void _initializeAudioElement(String rawUrl) {
    final audioElement = html.AudioElement()
      ..autoplay = true
      ..loop = true
      ..preload = 'auto'
      ..controls = false
      ..style.display = 'none'
      ..setAttribute('playsinline', 'true')
      ..volume = 0.55;
    _audioElement = audioElement;
    _resolvedAudioUrl = _resolveMediaUrl(rawUrl);
    audioElement.src = _resolvedAudioUrl ?? rawUrl;
    _wrapperElement?.append(audioElement);

    _audioMetadataSubscription = audioElement.onLoadedMetadata.listen((_) {
      _seekAudioToStart();
    });

    _audioCanPlaySubscription = audioElement.onCanPlay.listen((_) {
      _seekAudioToStart();
      unawaited(audioElement.play());
    });
    _audioErrorSubscription = audioElement.onError.listen((event) {
      debugPrint(
        'Background audio failed to load: ${_resolvedAudioUrl ?? rawUrl}',
      );
    });

    if (_userInteractionSubscriptions.isEmpty) {
      _userInteractionSubscriptions.add(
        html.document.onClick.listen(_handleUserInteractionUnlock),
      );
      _userInteractionSubscriptions.add(
        html.document.onKeyDown.listen(_handleUserInteractionUnlock),
      );
    }

    unawaited(audioElement.play());
  }

  void _updateAudioSource() {
    final audioUrl = widget.audioUrl;
    if (audioUrl == null || audioUrl.isEmpty) {
      _disposeAudioElement();
      return;
    }
    final String? newSource = _resolveMediaUrl(audioUrl);
    if (_audioElement == null) {
      _initializeAudioElement(audioUrl);
      return;
    }
    if (newSource == _resolvedAudioUrl) {
      _seekAudioToStart();
      return;
    }
    _resolvedAudioUrl = newSource;
    _audioElement!
      ..pause()
      ..src = _resolvedAudioUrl ?? audioUrl;
    _audioElement!.load();
    _audioStartApplied = false;
    unawaited(_audioElement!.play());
  }

  void _disposeAudioElement() {
    _audioCanPlaySubscription?.cancel();
    _audioCanPlaySubscription = null;
    _audioErrorSubscription?.cancel();
    _audioErrorSubscription = null;
    if (_audioElement != null) {
      _audioElement!
        ..pause()
        ..removeAttribute('src')
        ..load();
      _audioElement!.remove();
      _audioElement = null;
      _resolvedAudioUrl = null;
    }
    for (final subscription in _userInteractionSubscriptions) {
      subscription.cancel();
    }
    _userInteractionSubscriptions.clear();
    _audioMetadataSubscription?.cancel();
    _audioMetadataSubscription = null;
  }

  void _handleUserInteractionUnlock(html.Event _) {
    final audioElement = _audioElement;
    if (audioElement == null || !audioElement.paused) {
      return;
    }
    audioElement.play().catchError((Object error, StackTrace _) {
      debugPrint('Background audio play blocked: $error');
    });
  }

  void _seekAudioToStart() {
    if (_audioStartApplied) {
      return;
    }
    final audioElement = _audioElement;
    if (audioElement == null) {
      return;
    }
    final target = widget.audioStartPosition;
    if (target <= 0) {
      _audioStartApplied = true;
      return;
    }
    if (audioElement.readyState < html.MediaElement.HAVE_METADATA) {
      return;
    }
    try {
      audioElement.currentTime = target;
      _audioStartApplied = true;
    } catch (error, stackTrace) {
      debugPrint('Background audio seek failed: $error');
      debugPrint(stackTrace.toString());
    }
  }
}
