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
    this.audioMuted = false,
  });

  final String videoUrl;
  final double blurSigma;
  final double overlayOpacity;
  final String? audioUrl;
  final double audioStartPosition;
  final bool audioMuted;

  @override
  State<BackgroundVideo> createState() => _BackgroundVideoState();
}

class _BackgroundVideoState extends State<BackgroundVideo> {
  static final Set<String> _registeredViewTypes = <String>{};
  static const double _defaultAudioVolume = 0.55;
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
  StreamSubscription<html.Event>? _audioPlayingSubscription;
  StreamSubscription<html.Event>? _audioEndedSubscription;
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
      _applyAudioStartPosition(force: true);
      _updateAudioPlaybackMode();
    }
    if (oldWidget.audioMuted != widget.audioMuted) {
      _applyMuteState();
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
      ..loop = widget.audioStartPosition <= 0
      ..preload = 'auto'
      ..controls = false
      ..style.display = 'none'
      ..setAttribute('playsinline', 'true')
      ..volume = _defaultAudioVolume;
    _audioElement = audioElement;
    _resolvedAudioUrl = _resolveMediaUrl(rawUrl);
    audioElement.src = _resolvedAudioUrl ?? rawUrl;
    _wrapperElement?.append(audioElement);

    _audioMetadataSubscription = audioElement.onLoadedMetadata.listen((_) {
      _applyAudioStartPosition(force: true);
    });

    _audioCanPlaySubscription = audioElement.onCanPlay.listen((_) {
      _applyAudioStartPosition();
      _applyMuteState();
      unawaited(audioElement.play());
    });
    _audioErrorSubscription = audioElement.onError.listen((event) {
      debugPrint(
        'Background audio failed to load: ${_resolvedAudioUrl ?? rawUrl}',
      );
    });
    _audioPlayingSubscription = audioElement.onPlaying.listen((_) {
      _applyAudioStartPosition();
      _applyMuteState();
    });
    _attachAudioEndHandler();

    if (_userInteractionSubscriptions.isEmpty) {
      _userInteractionSubscriptions.add(
        html.document.onClick.listen(_handleUserInteractionUnlock),
      );
      _userInteractionSubscriptions.add(
        html.document.onKeyDown.listen(_handleUserInteractionUnlock),
      );
    }

    _applyMuteState();
    _applyAudioStartPosition(force: true);
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
      _applyAudioStartPosition(force: true);
      _applyMuteState();
      return;
    }
    _resolvedAudioUrl = newSource;
    _audioStartApplied = false;
    _audioElement!
      ..pause()
      ..src = _resolvedAudioUrl ?? audioUrl;
    _audioElement!.load();
    _updateAudioPlaybackMode();
    _applyMuteState();
    _applyAudioStartPosition(force: true);
    unawaited(_audioElement!.play());
  }

  void _disposeAudioElement() {
    _audioCanPlaySubscription?.cancel();
    _audioCanPlaySubscription = null;
    _audioErrorSubscription?.cancel();
    _audioErrorSubscription = null;
    _audioPlayingSubscription?.cancel();
    _audioPlayingSubscription = null;
    _audioEndedSubscription?.cancel();
    _audioEndedSubscription = null;
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

  void _applyAudioStartPosition({bool force = false}) {
    final audioElement = _audioElement;
    if (audioElement == null) {
      return;
    }
    final target = widget.audioStartPosition;
    if (target <= 0) {
      _audioStartApplied = true;
      return;
    }
    if (!force && _audioStartApplied) {
      if ((audioElement.currentTime - target).abs() <= 0.1) {
        return;
      }
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

  void _applyMuteState() {
    final audioElement = _audioElement;
    if (audioElement == null) {
      return;
    }
    audioElement.muted = widget.audioMuted;
    audioElement.volume = widget.audioMuted ? 0 : _defaultAudioVolume;
    if (!widget.audioMuted && audioElement.paused) {
      unawaited(audioElement.play());
    }
  }

  void _attachAudioEndHandler() {
    _audioEndedSubscription?.cancel();
    _audioEndedSubscription = null;
    if (widget.audioStartPosition <= 0) {
      return;
    }
    final audioElement = _audioElement;
    if (audioElement == null) {
      return;
    }
    _audioEndedSubscription = audioElement.onEnded.listen((_) {
      _audioStartApplied = false;
      _applyAudioStartPosition(force: true);
      _applyMuteState();
      unawaited(audioElement.play());
    });
  }

  void _updateAudioPlaybackMode() {
    final audioElement = _audioElement;
    if (audioElement == null) {
      return;
    }
    final bool shouldLoop = widget.audioStartPosition <= 0;
    audioElement.loop = shouldLoop;
    if (shouldLoop) {
      _audioEndedSubscription?.cancel();
      _audioEndedSubscription = null;
      _audioStartApplied = true;
    } else {
      _attachAudioEndHandler();
      _audioStartApplied = false;
    }
  }
}
