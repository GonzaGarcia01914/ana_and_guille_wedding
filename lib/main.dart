import 'dart:async';
import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:invitacion_boda_mama/background_video.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    debugPrint('FlutterError: ${details.exceptionAsString()}');
    if (details.stack != null) {
      debugPrint(details.stack.toString());
    }
  };

  PlatformDispatcher.instance.onError = (Object error, StackTrace stackTrace) {
    debugPrint('Unhandled platform error: $error');
    debugPrint(stackTrace.toString());
    return true;
  };

  runZonedGuarded(() => runApp(const WeddingInvitationApp()), (
    Object error,
    StackTrace stackTrace,
  ) {
    debugPrint('Uncaught zone error: $error');
    debugPrint(stackTrace.toString());
  });
}

class WeddingInvitationApp extends StatelessWidget {
  const WeddingInvitationApp({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF4F6F5B);
    const secondaryColor = Color(0xFF95A89C);
    const textPrimaryColor = Colors.white;
    const accentColor = Color(0xFFCFB793);

    final colorScheme = ColorScheme.light(
      primary: primaryColor,
      onPrimary: Colors.white,
      secondary: secondaryColor,
      onSecondary: Colors.white,
      surface: Colors.white,
      onSurface: textPrimaryColor,
      surfaceTint: primaryColor,
      tertiary: accentColor,
      onTertiary: const Color(0xFF2E261F),
    );

    final textTheme = TextTheme(
      displayLarge: GoogleFonts.playfairDisplay(
        fontSize: 60,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.6,
        color: Colors.white,
      ),
      displaySmall: GoogleFonts.playfairDisplay(
        fontSize: 42,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.1,
        color: colorScheme.onSurface,
      ),
      headlineMedium: GoogleFonts.playfairDisplay(
        fontSize: 27,
        fontWeight: FontWeight.w500,
        color: colorScheme.onSurface,
      ),
      headlineSmall: GoogleFonts.playfairDisplay(
        fontSize: 22,
        fontWeight: FontWeight.w500,
        color: colorScheme.onSurface,
      ),
      titleMedium: GoogleFonts.workSans(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
        color: colorScheme.onSurface,
      ),
      bodyLarge: GoogleFonts.workSans(
        fontSize: 18,
        height: 1.6,
        color: colorScheme.onSurface,
      ),
      bodyMedium: GoogleFonts.workSans(
        fontSize: 16,
        height: 1.6,
        color: colorScheme.onSurface.withValues(alpha: 0.72),
      ),
      labelLarge: GoogleFonts.workSans(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
        color: colorScheme.onPrimary,
      ),
    );

    return MaterialApp(
      title: 'Invitación de boda',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: colorScheme,
        scaffoldBackgroundColor: Colors.transparent,
        textTheme: textTheme,
        dividerTheme: DividerThemeData(
          color: colorScheme.onSurface.withValues(alpha: 0.12),
          thickness: 1,
          space: 32,
        ),
        chipTheme: ChipThemeData(
          backgroundColor: colorScheme.secondary.withValues(alpha: 0.18),
          selectedColor: colorScheme.secondary.withValues(alpha: 0.42),
          labelStyle: GoogleFonts.workSans(
            fontSize: 14,
            color: colorScheme.onSurface,
            letterSpacing: 0.4,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          shape: const StadiumBorder(),
        ),
        cardTheme: CardThemeData(
          color: Colors.white.withValues(alpha: 0.9),
          elevation: 0,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
            side: BorderSide(
              color: colorScheme.primary.withValues(alpha: 0.08),
            ),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: colorScheme.primary,
            foregroundColor: colorScheme.onPrimary,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 15),
            textStyle: GoogleFonts.workSans(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.6,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: colorScheme.primary,
            side: BorderSide(
              color: colorScheme.primary.withValues(alpha: 0.32),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
            textStyle: GoogleFonts.workSans(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: colorScheme.primary,
            textStyle: GoogleFonts.workSans(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ),
        useMaterial3: true,
      ),
      home: const WeddingInvitationPage(),
    );
  }
}

class WeddingInvitationPage extends StatefulWidget {
  const WeddingInvitationPage({super.key});

  static const WeddingDetails details = WeddingDetails(
    coupleNames: 'Ana & Guilhem',
    videoUrl: 'assets/media/hero.mp4',
    audioUrl: 'assets/audio/version_final.mp3',
    mapUrl: 'https://maps.app.goo.gl/HyyjJ1SwnHrW1MUf9',
    rsvpEmail: 'anakarinagarcia@gmail.com',
    rsvpPhoneNumber: '595986561861',
    localized: {
      InvitationLocale.es: LocaleStrings(
        heroTagline: '',
        celebrationDate:
            'El sábado 19 de septiembre a las 12:00 hs del 2026 en nuestra querida Monoblet.',
        countdownTitle: 'Cuenta regresiva',
        countdownSubtitle: 'Hasta el 19 de septiembre de 2026',
        countdownLeadLabel: 'Faltan',
        countdownTargetLabel: '19 de septiembre de 2026 · Monoblet',
        daysLabel: 'Días',
        hoursLabel: 'Horas',
        minutesLabel: 'Minutos',
        secondsLabel: 'Segundos',
        storyLines: [
          'Diez años, muchas aventuras,',
          'Una historia ❤️',
          'Y ahora… la más especial de todas....',
          'Está vez queremos que seas parte....',
        ],
        storyInvite:
            '¡Te invitamos a compartir con nosotros este momento tan especial!',
        locationTitle: 'Ubicación',
        venueName: 'Le Chat',
        locationSummary: 'Monoblet, Francia',
        fullAddress: 'Le Chat, Monoblet, Francia',
        locationButtonLabel: 'Ver en Google Maps',
        calendarButtonLabel: 'Agregar al calendario',
        calendarTitle: 'Boda',
        calendarDescription:
            'Celebramos nuestra boda en Le Chat, Monoblet. ¡Te esperamos para brindar juntos!',
        rsvpTitle: 'Confirmar asistencia',
        rsvpDateLimit: '',
        emailButtonLabel: 'Enviar correo',
        whatsappButtonLabel: 'Mensaje por WhatsApp',
        emailSubject: 'Confirmación de asistencia',
        whatsappMessage:
            'Hola, quiero confirmar mi asistencia a la boda de Ana y Guilhem.',
        dressCodeLabel: 'Dress code',
        dressCode:
            'Elegante relajado en tonos neutros, tierra o verdes suaves.',
        registryLabel: 'Regalo',
        registryNote: 'Tu presencia es nuestro mejor regalo',
        footerMessage: 'Gracias por ser parte de este capítulo tan importante.',
        linkErrorMessage:
            'No pudimos abrir el enlace. Podés copiarlo desde la invitación.',
      ),
      InvitationLocale.fr: LocaleStrings(
        heroTagline: '',
        celebrationDate:
            'Le samedi 19 septembre a 12h00 en notre chere Monoblet.',
        countdownTitle: 'Compte a rebours',
        countdownSubtitle: "Jusqu'au 19 septembre 2026",
        countdownLeadLabel: 'Plus que',
        countdownTargetLabel: '19 septembre 2026 · Monoblet',
        daysLabel: 'Jours',
        hoursLabel: 'Heures',
        minutesLabel: 'Minutes',
        secondsLabel: 'Secondes',
        storyLines: [
          "Dix ans, tant d'aventures,",
          'Une histoire ❤️',
          'Et maintenant... la plus speciale de toutes....',
          "Cette fois, nous voulons que tu en fasses partie....",
        ],
        storyInvite:
            "Nous t'invitons a partager ce moment si special avec nous !",
        locationTitle: 'Localisation',
        venueName: 'Le Chat',
        locationSummary: 'Monoblet, France',
        fullAddress: 'Le Chat, Monoblet, France',
        locationButtonLabel: 'Voir sur Google Maps',
        calendarButtonLabel: 'Ajouter au calendrier',
        calendarTitle: 'Mariage',
        calendarDescription:
            "Nous celebrons notre mariage a Le Chat, Monoblet. Nous t'attendons pour trinquer ensemble !",
        rsvpTitle: 'Confirmer ta presence',
        rsvpDateLimit: '',
        emailButtonLabel: 'Envoyer un e-mail',
        whatsappButtonLabel: 'Message WhatsApp',
        emailSubject: 'Confirmation de presence',
        whatsappMessage:
            'Bonjour ! Je souhaite confirmer ma presence au mariage de Ana et Guilhem.',
        dressCodeLabel: 'Tenue',
        dressCode:
            'Elegant decontracte dans des tons neutres, terre ou verts doux.',
        registryLabel: 'Cadeau',
        registryNote: 'Ta presence est notre plus beau cadeau',
        footerMessage: 'Merci de faire partie de ce chapitre si important.',
        linkErrorMessage:
            "Nous n'avons pas pu ouvrir le lien. Tu peux le copier depuis l'invitation.",
      ),
    },
  );

  @override
  State<WeddingInvitationPage> createState() => _WeddingInvitationPageState();
}

class _WeddingInvitationPageState extends State<WeddingInvitationPage> {
  final ScrollController _scrollController = ScrollController();
  final DateTime _targetDate = DateTime(2026, 9, 19, 12);
  late final ValueNotifier<Duration> _countdownNotifier =
      ValueNotifier<Duration>(_timeRemaining());
  InvitationLocale _locale = InvitationLocale.es;
  Timer? _timer;
  double _scrollOffset = 0;
  bool _isAudioMuted = true;
  double _introOpacity = 1.0;
  bool _introDismissed = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScroll);
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _countdownNotifier.value = _timeRemaining();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _scrollController
      ..removeListener(_handleScroll)
      ..dispose();
    _countdownNotifier.dispose();
    super.dispose();
  }

  void _handleScroll() {
    setState(() {
      _scrollOffset = _scrollController.offset;
    });
  }

  Duration _timeRemaining() {
    final now = DateTime.now();
    if (_targetDate.isBefore(now)) {
      return Duration.zero;
    }
    return _targetDate.difference(now);
  }

  double get _blurSigma => (_scrollOffset / 45).clamp(0.0, 18.0);

  double get _overlayOpacity => (_scrollOffset / 480).clamp(0.0, 0.65);

  void _switchLocale(InvitationLocale locale) {
    if (_locale != locale) {
      setState(() {
        _locale = locale;
      });
    }
  }

  void _toggleAudioMute() {
    setState(() {
      _isAudioMuted = !_isAudioMuted;
    });
  }

  void _scrollToContent() {
    if (!_scrollController.hasClients) {
      return;
    }
    final double heroHeight = MediaQuery.of(context).size.height;
    _scrollController.animateTo(
      heroHeight * 0.95,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOut,
    );
  }

  void _dismissIntroOverlay() {
    if (_introDismissed || _introOpacity == 0) {
      return;
    }
    setState(() {
      _introOpacity = 0;
      if (_isAudioMuted) {
        _isAudioMuted = false;
      }
    });
  }

  Future<void> _openLink(
    BuildContext context,
    String url,
    String errorMessage,
  ) async {
    final uri = Uri.parse(url);
    final launched = await launchUrl(uri, mode: LaunchMode.platformDefault);
    if (!launched) {
      if (!context.mounted) {
        return;
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(errorMessage)));
    }
  }

  String _buildCalendarUrl(WeddingDetails details, LocaleStrings strings) {
    const start = '20261120T200000Z';
    const end = '20261121T020000Z';
    final title = Uri.encodeComponent(
      '${details.coupleNames} · ${strings.calendarTitle}',
    );
    final location = Uri.encodeComponent(strings.fullAddress);
    final description = Uri.encodeComponent(strings.calendarDescription);

    return 'https://www.google.com/calendar/render?action=TEMPLATE&text=$title&dates=$start/$end&location=$location&details=$description';
  }

  @override
  Widget build(BuildContext context) {
    final details = WeddingInvitationPage.details;
    final strings = details.stringsFor(_locale);
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final isWide = size.width >= 900;
    final horizontalPadding = isWide ? 160.0 : 24.0;
    final heroHeight = size.height;

    final mailtoUrl =
        'mailto:${details.rsvpEmail}?subject=${Uri.encodeComponent(strings.emailSubject)}';
    final whatsappUrl =
        'https://wa.me/${details.rsvpPhoneNumber}?text=${Uri.encodeComponent(strings.whatsappMessage)}';
    final calendarUrl = _buildCalendarUrl(details, strings);
    final double mainOpacity = _introDismissed
        ? 1.0
        : (_introOpacity < 1 ? 1.0 : 0.0);

    return Scaffold(
      body: Stack(
        children: [
          AnimatedOpacity(
            opacity: mainOpacity,
            duration: const Duration(milliseconds: 420),
            curve: Curves.easeInOut,
            child: IgnorePointer(
              ignoring: !_introDismissed,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: BackgroundVideo(
                      videoUrl: details.videoUrl,
                      audioUrl: details.audioUrl,
                      audioStartPosition: details.audioStartPosition,
                      audioMuted: _isAudioMuted,
                      blurSigma: _blurSigma,
                      overlayOpacity: _overlayOpacity,
                    ),
                  ),
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withValues(alpha: 0.28),
                            Colors.black.withValues(alpha: 0.1),
                            Colors.transparent,
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.center,
                        ),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: isWide ? 80 : 60),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(
                              height: heroHeight,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: isWide ? 96 : 32,
                                  vertical: isWide ? 72 : 48,
                                ),
                                child: _HeroOverlay(
                                  onScrollPromptTap: _scrollToContent,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: horizontalPadding,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  _WelcomeSection(
                                    details: details,
                                    strings: strings,
                                  ),
                                  const SizedBox(height: 28),
                                  SectionCard(
                                    title: strings.locationTitle,
                                    icon: Icons.place_outlined,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          strings.venueName,
                                          style: theme.textTheme.headlineSmall,
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          strings.locationSummary,
                                          style: theme.textTheme.bodyMedium
                                              ?.copyWith(
                                                fontWeight: FontWeight.w600,
                                                color:
                                                    theme.colorScheme.primary,
                                              ),
                                        ),
                                        const SizedBox(height: 18),
                                        Wrap(
                                          spacing: 16,
                                          runSpacing: 16,
                                          children: [
                                            ElevatedButton.icon(
                                              onPressed: () => _openLink(
                                                context,
                                                details.mapUrl,
                                                strings.linkErrorMessage,
                                              ),
                                              icon: const Icon(
                                                Icons.map_outlined,
                                              ),
                                              label: Text(
                                                strings.locationButtonLabel,
                                              ),
                                            ),
                                            TextButton.icon(
                                              onPressed: () => _openLink(
                                                context,
                                                calendarUrl,
                                                strings.linkErrorMessage,
                                              ),
                                              icon: const Icon(
                                                Icons.event_available_outlined,
                                              ),
                                              label: Text(
                                                strings.calendarButtonLabel,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 28),
                                  SectionCard(
                                    title: strings.rsvpTitle,
                                    icon: Icons.mark_email_read_outlined,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Wrap(
                                          spacing: 16,
                                          runSpacing: 16,
                                          children: [
                                            ElevatedButton.icon(
                                              onPressed: () => _openLink(
                                                context,
                                                mailtoUrl,
                                                strings.linkErrorMessage,
                                              ),
                                              icon: const Icon(
                                                Icons.email_outlined,
                                              ),
                                              label: Text(
                                                strings.emailButtonLabel,
                                              ),
                                            ),
                                            OutlinedButton.icon(
                                              onPressed: () => _openLink(
                                                context,
                                                whatsappUrl,
                                                strings.linkErrorMessage,
                                              ),
                                              icon: const Icon(
                                                Icons.chat_bubble_outline,
                                              ),
                                              label: Text(
                                                strings.whatsappButtonLabel,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 24),
                                        _InfoRow(
                                          icon: Icons.style_outlined,
                                          label: strings.dressCodeLabel,
                                          value: strings.dressCode,
                                        ),
                                        const SizedBox(height: 16),
                                        _InfoRow(
                                          icon: Icons.card_giftcard_outlined,
                                          label: strings.registryLabel,
                                          value: strings.registryNote,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 28),
                                  _CountdownSection(
                                    countdown: _countdownNotifier,
                                    strings: strings,
                                  ),
                                  const SizedBox(height: 28),
                                  _Footer(details: details, strings: strings),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 24,
                    right: isWide ? 32 : 16,
                    child: SafeArea(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _MuteToggleButton(
                            isMuted: _isAudioMuted,
                            onPressed: _toggleAudioMute,
                          ),
                          const SizedBox(width: 12),
                          _LanguageToggle(
                            selected: _locale,
                            onChanged: _switchLocale,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (!_introDismissed)
            Positioned.fill(
              child: AnimatedOpacity(
                opacity: _introOpacity,
                duration: const Duration(milliseconds: 420),
                curve: Curves.easeInOut,
                onEnd: () {
                  if (_introOpacity == 0 && !_introDismissed && mounted) {
                    setState(() {
                      _introDismissed = true;
                    });
                  }
                },
                child: IgnorePointer(
                  ignoring: _introOpacity == 0,
                  child: _IntroBloomOverlay(onOpened: _dismissIntroOverlay),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _HeroOverlay extends StatefulWidget {
  const _HeroOverlay({required this.onScrollPromptTap});

  final VoidCallback onScrollPromptTap;

  @override
  State<_HeroOverlay> createState() => _HeroOverlayState();
}

class _HeroOverlayState extends State<_HeroOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1100),
  )..repeat(reverse: true);

  late final Animation<double> _offset = Tween<double>(
    begin: -3.5,
    end: 3.5,
  ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine));

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isWide = MediaQuery.of(context).size.width >= 720;
    final double iconSize = isWide ? 26 : 22;

    return Column(
      children: [
        const Spacer(),
        GestureDetector(
          onTap: widget.onScrollPromptTap,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: isWide ? 22 : 18,
              vertical: isWide ? 12 : 10,
            ),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.24),
              borderRadius: BorderRadius.circular(36),
              border: Border.all(color: Colors.white.withValues(alpha: 0.5)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.22),
                  offset: const Offset(0, 8),
                  blurRadius: 18,
                ),
              ],
            ),
            child: AnimatedBuilder(
              animation: _offset,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, _offset.value),
                  child: child,
                );
              },
              child: Text(
                '👇',
                style: TextStyle(
                  fontSize: iconSize,
                  color: Colors.white.withValues(alpha: 0.92),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: isWide ? 26 : 16),
      ],
    );
  }
}

class _LanguageToggle extends StatelessWidget {
  const _LanguageToggle({required this.selected, required this.onChanged});

  final InvitationLocale selected;
  final ValueChanged<InvitationLocale> onChanged;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<InvitationLocale>(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? Colors.white.withValues(alpha: 0.98)
              : Colors.white.withValues(alpha: 0.6),
        ),
        foregroundColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? const Color(0xFF2F3C35)
              : Colors.white,
        ),
        side: WidgetStateProperty.resolveWith(
          (states) => BorderSide(
            color: Colors.white.withValues(
              alpha: states.contains(WidgetState.selected) ? 0.85 : 0.6,
            ),
          ),
        ),
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        ),
      ),
      segments: const [
        ButtonSegment<InvitationLocale>(
          value: InvitationLocale.es,
          label: Text('ES'),
        ),
        ButtonSegment<InvitationLocale>(
          value: InvitationLocale.fr,
          label: Text('FR'),
        ),
      ],
      showSelectedIcon: false,
      selected: {selected},
      onSelectionChanged: (values) {
        if (values.isNotEmpty) {
          onChanged(values.first);
        }
      },
    );
  }
}

class _MuteToggleButton extends StatelessWidget {
  const _MuteToggleButton({required this.isMuted, required this.onPressed});

  final bool isMuted;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final Color background = Colors.white.withValues(alpha: 0.65);
    final Color hoverBackground = Colors.white.withValues(alpha: 0.85);
    return Tooltip(
      message: isMuted ? 'Activar sonido' : 'Silenciar sonido',
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          isMuted ? Icons.volume_off_rounded : Icons.volume_up_rounded,
        ),
        style: IconButton.styleFrom(
          backgroundColor: background,
          foregroundColor: Colors.white,
          hoverColor: hoverBackground,
          focusColor: hoverBackground,
          highlightColor: hoverBackground,
          padding: const EdgeInsets.all(10),
          shape: const StadiumBorder(),
        ),
      ),
    );
  }
}

class _IntroBloomOverlay extends StatefulWidget {
  const _IntroBloomOverlay({required this.onOpened});

  final VoidCallback onOpened;

  @override
  State<_IntroBloomOverlay> createState() => _IntroBloomOverlayState();
}

class _IntroBloomOverlayState extends State<_IntroBloomOverlay>
    with TickerProviderStateMixin {
  late final AnimationController _ambientController;
  late final AnimationController _revealController;
  late final Animation<double> _revealProgress;

  bool _hasNotified = false;
  bool _hasTapped = false;
  double _ambientPhase = 0;
  double _lastAmbientValue = 0;

  @override
  void initState() {
    super.initState();
    _ambientController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    );
    _ambientController.addListener(() {
      final double value = _ambientController.value;
      if (value < _lastAmbientValue) {
        _ambientPhase += math.pi * 2;
      }
      _lastAmbientValue = value;
    });
    _ambientController.repeat();

    _revealController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _revealProgress = CurvedAnimation(
      parent: _revealController,
      curve: Curves.easeOutCubic,
    );

    _revealController.addStatusListener((status) {
      if (status == AnimationStatus.completed && !_hasNotified) {
        _hasNotified = true;
        Future.delayed(const Duration(milliseconds: 160), () {
          if (mounted) {
            widget.onOpened();
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _ambientController.dispose();
    _revealController.dispose();
    super.dispose();
  }

  void _handleTap() {
    if (_hasTapped) {
      return;
    }
    setState(() {
      _hasTapped = true;
    });
    _revealController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;
    final bool isWide = size.shortestSide >= 540;
    final bool isCompact = size.shortestSide <= 360;
    final double cardMaxWidth = isWide
        ? math.min(size.width * 0.58, 540)
        : math.min(size.width * 0.9, size.width - 24);

    final palette = <Color>[
      const Color(0xFF8C6A8A),
      theme.colorScheme.tertiary.withValues(alpha: 0.85),
      theme.colorScheme.primary.withValues(alpha: 0.8),
      const Color(0xFF9AB7A6),
    ];

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _handleTap,
      child: AnimatedBuilder(
        animation: Listenable.merge([_ambientController, _revealProgress]),
        builder: (context, _) {
          final double animatedProgress = _revealProgress.value;
          final double animatedTime =
              _ambientPhase + _ambientController.value * math.pi * 2;
          final double idlePulse = math.sin(animatedTime * 1.25) * 0.015;
          final double callToActionOpacity = _hasTapped
              ? (1 - animatedProgress).clamp(0.0, 1.0)
              : 1.0;
          final double callToActionScale = _hasTapped
              ? (1.0 + animatedProgress * 0.18)
              : (1.0 + idlePulse);

          return Stack(
            fit: StackFit.expand,
            children: [
              CustomPaint(
                painter: _BloomPainter(
                  progress: animatedProgress,
                  time: animatedTime,
                  palette: palette,
                  glowColor: theme.colorScheme.primary,
                ),
              ),
              Center(
                child: Opacity(
                  opacity: callToActionOpacity,
                  child: Transform.scale(
                    scale: callToActionScale,
                    child: _IntroBloomCallToAction(
                      isWide: isWide,
                      isCompact: isCompact,
                      hasTapped: _hasTapped,
                      maxWidth: cardMaxWidth,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _IntroBloomCallToAction extends StatelessWidget {
  const _IntroBloomCallToAction({
    required this.isWide,
    required this.isCompact,
    required this.hasTapped,
    required this.maxWidth,
  });

  final bool isWide;
  final bool isCompact;
  final bool hasTapped;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final double horizontalPadding = isWide
        ? 44
        : isCompact
        ? 20
        : 28;
    final double verticalPadding = isWide
        ? 32
        : isCompact
        ? 18
        : 24;
    final double titleFontSize = isWide
        ? 48
        : isCompact
        ? 32
        : 36;
    final double subtitleFontSize = isWide
        ? 20
        : isCompact
        ? 16
        : 18;
    final double iconSize = isWide
        ? 28
        : isCompact
        ? 22
        : 24;
    final double titleSpacing = isWide
        ? 22
        : isCompact
        ? 16
        : 18;

    final TextStyle? titleStyle = theme.textTheme.displaySmall?.copyWith(
      color: Colors.white,
      fontSize: titleFontSize,
      letterSpacing: isWide ? 1.6 : 1.2,
      height: 1.08,
      shadows: const [Shadow(color: Colors.black45, blurRadius: 16)],
    );
    final TextStyle? subtitleStyle = theme.textTheme.bodyLarge?.copyWith(
      color: Colors.white.withValues(alpha: 0.9),
      fontSize: subtitleFontSize,
      height: 1.35,
    );

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: maxWidth,
        minWidth: math.min(maxWidth, isCompact ? 220 : 280),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: verticalPadding,
        ),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(isWide ? 44 : 34),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.52),
            width: 1.4,
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0x33000000),
              blurRadius: 24,
              offset: Offset(0, 18),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Ana & Guilhem',
              style: titleStyle,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: titleSpacing),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 360),
              switchInCurve: Curves.easeOut,
              switchOutCurve: Curves.easeIn,
              layoutBuilder: (currentChild, previousChildren) => Stack(
                alignment: Alignment.center,
                children: [
                  ...previousChildren,
                  if (currentChild != null) currentChild,
                ],
              ),
              child: hasTapped
                  ? Row(
                      key: const ValueKey('opening'),
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.auto_awesome_rounded,
                          color: Colors.white.withValues(alpha: 0.9),
                          size: iconSize,
                        ),
                        const SizedBox(width: 10),
                        Text('Preparando la magia...', style: subtitleStyle),
                      ],
                    )
                  : Wrap(
                      key: const ValueKey('cta'),
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 10,
                      runSpacing: 6,
                      children: [
                        Icon(
                          Icons.play_arrow_rounded,
                          color: Colors.white.withValues(alpha: 0.9),
                          size: iconSize,
                        ),
                        SizedBox(
                          width: isCompact
                              ? math.max(
                                  0,
                                  maxWidth - (horizontalPadding * 2 + 8),
                                )
                              : null,
                          child: Text(
                            'Toca para abrir',
                            style: subtitleStyle,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BloomPainter extends CustomPainter {
  _BloomPainter({
    required this.progress,
    required this.time,
    required this.palette,
    required this.glowColor,
  });

  final double progress;
  final double time;
  final List<Color> palette;
  final Color glowColor;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect bounds = Offset.zero & size;
    final Paint background = Paint()
      ..shader = RadialGradient(
        center: Alignment.center,
        radius: 1.05,
        colors: [
          glowColor.withValues(alpha: 0.35 + progress * 0.15),
          Colors.black.withValues(alpha: 0.7),
        ],
        stops: const [0.0, 1.0],
      ).createShader(bounds);
    canvas.drawRect(bounds, background);

    final Offset center = bounds.center;
    final double baseRadius = size.shortestSide * (0.18 + progress * 0.22);

    for (int i = 0; i < 8; i++) {
      final double angle = time * (0.5 + i * 0.05) + (i / 8) * math.pi * 2;
      final double distance = baseRadius * (1.8 + i * 0.24 + progress * 1.4);
      final Offset offset = Offset(
        math.cos(angle) * distance,
        math.sin(angle) * distance,
      );
      final double petalLength =
          size.shortestSide * (0.18 + i * 0.02) * (1 + progress * 0.6);
      final double petalWidth = petalLength * 0.45;

      canvas.save();
      canvas.translate(center.dx + offset.dx, center.dy + offset.dy);
      final double rotation =
          angle + math.sin(time * 0.8 + i) * (1 - progress) * 0.6;
      canvas.rotate(rotation);

      final Rect petalRect = Rect.fromCenter(
        center: Offset.zero,
        width: petalWidth,
        height: petalLength,
      );
      final RRect petalShape = RRect.fromRectAndRadius(
        petalRect,
        Radius.circular(petalWidth * 0.5),
      );
      final Color baseColor = palette[i % palette.length];
      final Paint petalPaint = Paint()
        ..shader = LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            baseColor.withValues(alpha: 0.18 + progress * 0.32),
            baseColor.withValues(alpha: 0.78),
          ],
        ).createShader(petalRect);
      canvas.drawRRect(petalShape, petalPaint);
      canvas.restore();
    }

    const int sparkleCount = 28;
    for (int i = 0; i < sparkleCount; i++) {
      final double angle = time * 0.9 + (i / sparkleCount) * math.pi * 2;
      final double orbit = baseRadius * (1.4 + (i % 6) * 0.26 + progress * 1.2);
      final Offset sparkleOffset =
          center + Offset(math.cos(angle) * orbit, math.sin(angle) * orbit);
      final double sparkleWave = (math.sin(time * 1.6 + i) + 1) / 2;
      final double sparkleSize =
          size.shortestSide *
          0.007 *
          (1.2 + sparkleWave * 1.4) *
          (1 - progress * 0.25);
      final Paint sparklePaint = Paint()
        ..color = Colors.white.withValues(alpha: 0.12 + sparkleWave * 0.36);
      canvas.drawCircle(sparkleOffset, sparkleSize, sparklePaint);
    }

    final double coreRadius = baseRadius * (1.1 + progress * 0.9);
    final Rect coreBounds = Rect.fromCircle(center: center, radius: coreRadius);
    final Paint corePaint = Paint()
      ..shader = RadialGradient(
        colors: [
          Colors.white.withValues(alpha: 0.9),
          glowColor.withValues(alpha: 0.0),
        ],
      ).createShader(coreBounds);
    canvas.drawCircle(center, coreRadius, corePaint);
  }

  @override
  bool shouldRepaint(covariant _BloomPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.time != time ||
        oldDelegate.glowColor != glowColor ||
        !listEquals(oldDelegate.palette, palette);
  }
}

class _CountdownSection extends StatelessWidget {
  const _CountdownSection({required this.countdown, required this.strings});

  final ValueListenable<Duration> countdown;
  final LocaleStrings strings;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final headlineColor = theme.colorScheme.onSurface;
    final bodyColor = theme.colorScheme.onSurface.withValues(alpha: 0.7);

    return _MinimalCard(
      padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            strings.countdownTitle,
            style: theme.textTheme.headlineMedium?.copyWith(
              color: headlineColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            strings.countdownSubtitle,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(color: bodyColor),
          ),
          const SizedBox(height: 24),
          ValueListenableBuilder<Duration>(
            valueListenable: countdown,
            builder: (context, duration, _) {
              final breakdown = _TimeBreakdown.fromDuration(duration);
              final width = MediaQuery.of(context).size.width;
              final bool isNarrow = width < 420;
              final bool isVeryWide = width > 960;
              final double itemSpacing = isVeryWide
                  ? 22
                  : isNarrow
                  ? 8
                  : 14;
              final double runSpacing = isNarrow ? 4 : 10;
              return Column(
                children: [
                  Text(
                    strings.countdownLeadLabel.toUpperCase(),
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: headlineColor,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: itemSpacing,
                    runSpacing: runSpacing,
                    children: [
                      _CountdownValue(
                        value: breakdown.days,
                        label: strings.daysLabel,
                      ),
                      _CountdownValue(
                        value: breakdown.hours,
                        label: strings.hoursLabel,
                      ),
                      _CountdownValue(
                        value: breakdown.minutes,
                        label: strings.minutesLabel,
                      ),
                      _CountdownValue(
                        value: breakdown.seconds,
                        label: strings.secondsLabel,
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _CountdownValue extends StatelessWidget {
  const _CountdownValue({required this.value, required this.label});

  final int value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    final width = mediaQuery.size.width;

    // Tune sizes so the four items always fit in one row.
    // We assume a minimum padding of ~32 on each side.
    final bool isNarrow = width < 420;
    final bool isVeryWide = width > 960;

    final double circleSize = isVeryWide
        ? 88
        : isNarrow
        ? 54
        : 68;
    final double fontSize = isVeryWide
        ? 28
        : isNarrow
        ? 18
        : 24;
    final double labelSpacing = isVeryWide
        ? 10
        : isNarrow
        ? 6
        : 8;
    final double labelFontSize = isVeryWide
        ? 14
        : isNarrow
        ? 11
        : 12;

    final circleColor = theme.colorScheme.primary.withValues(alpha: 0.78);
    final valueColor = theme.colorScheme.onPrimary;
    final labelColor = theme.colorScheme.onSurface.withValues(alpha: 0.75);

    final valueStyle = theme.textTheme.headlineSmall?.copyWith(
      fontSize: fontSize,
      fontWeight: FontWeight.w600,
      color: valueColor,
    );
    final labelStyle = theme.textTheme.labelMedium?.copyWith(
      letterSpacing: 1,
      fontSize: labelFontSize,
      color: labelColor,
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: circleSize,
          height: circleSize,
          alignment: Alignment.center,
          decoration: BoxDecoration(shape: BoxShape.circle, color: circleColor),
          child: Text(value.toString().padLeft(2, '0'), style: valueStyle),
        ),
        SizedBox(height: labelSpacing),
        Text(label.toUpperCase(), style: labelStyle),
      ],
    );
  }
}

class _WelcomeSection extends StatelessWidget {
  const _WelcomeSection({required this.details, required this.strings});

  final WeddingDetails details;
  final LocaleStrings strings;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.colorScheme.onSurface;
    final subtitleColor = theme.colorScheme.onSurface.withValues(alpha: 0.72);
    final isWide = MediaQuery.of(context).size.width >= 720;

    return _MinimalCard(
      padding: EdgeInsets.symmetric(
        horizontal: isWide ? 46 : 24,
        vertical: isWide ? 44 : 30,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            details.coupleNames,
            textAlign: TextAlign.center,
            style: theme.textTheme.displaySmall?.copyWith(
              fontSize: isWide ? 60 : 42,
              color: textColor,
            ),
          ),
          SizedBox(height: isWide ? 32 : 26),
          for (int i = 0; i < strings.storyLines.length; i++) ...[
            Text(
              strings.storyLines[i],
              textAlign: TextAlign.center,
              style: theme.textTheme.displaySmall?.copyWith(
                fontSize: isWide ? 28 : 22,
                height: 1.35,
                color: textColor,
              ),
            ),
            if (i != strings.storyLines.length - 1) const SizedBox(height: 6),
          ],
          SizedBox(height: isWide ? 22 : 18),
          Text(
            strings.storyInvite,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: subtitleColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: isWide ? 24 : 18),
          Text(
            strings.celebrationDate,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: subtitleColor,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.4,
            ),
          ),
        ],
      ),
    );
  }
}

class SectionCard extends StatelessWidget {
  const SectionCard({
    super.key,
    required this.title,
    required this.icon,
    required this.child,
  });

  final String title;
  final IconData icon;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return _MinimalCard(
      padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 26),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon, color: theme.colorScheme.primary),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: theme.textTheme.headlineMedium,
                  softWrap: true,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          child,
        ],
      ),
    );
  }
}

class _MinimalCard extends StatelessWidget {
  const _MinimalCard({
    required this.child,
    this.padding = const EdgeInsets.all(24),
  });

  final Widget child;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: theme.colorScheme.primary.withValues(alpha: 0.18),
        ),
      ),
      child: child,
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: theme.colorScheme.secondary),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: theme.textTheme.titleMedium),
              const SizedBox(height: 6),
              Text(value, style: theme.textTheme.bodyMedium),
            ],
          ),
        ),
      ],
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer({required this.details, required this.strings});

  final WeddingDetails details;
  final LocaleStrings strings;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Divider(color: theme.colorScheme.outlineVariant),
        const SizedBox(height: 24),
        Text(
          strings.footerMessage,
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          details.coupleNames,
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.65),
            letterSpacing: 0.8,
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}

class _TimeBreakdown {
  const _TimeBreakdown({
    required this.days,
    required this.hours,
    required this.minutes,
    required this.seconds,
  });

  factory _TimeBreakdown.fromDuration(Duration duration) {
    final totalSeconds = duration.inSeconds;
    final days = duration.inDays;
    final hours = (totalSeconds - days * 86400) ~/ 3600;
    final minutes = (totalSeconds - days * 86400 - hours * 3600) ~/ 60;
    final seconds = totalSeconds % 60;
    return _TimeBreakdown(
      days: days,
      hours: hours,
      minutes: minutes,
      seconds: seconds,
    );
  }

  final int days;
  final int hours;
  final int minutes;
  final int seconds;
}

class WeddingDetails {
  const WeddingDetails({
    required this.coupleNames,
    required this.videoUrl,
    required this.audioUrl,
    this.audioStartPosition = 0,
    required this.mapUrl,
    required this.rsvpEmail,
    required this.rsvpPhoneNumber,
    required this.localized,
  });

  final String coupleNames;
  final String videoUrl;
  final String audioUrl;
  final double audioStartPosition;
  final String mapUrl;
  final String rsvpEmail;
  final String rsvpPhoneNumber;
  final Map<InvitationLocale, LocaleStrings> localized;

  LocaleStrings stringsFor(InvitationLocale locale) =>
      localized[locale] ?? localized.values.first;
}

class LocaleStrings {
  const LocaleStrings({
    required this.heroTagline,
    required this.celebrationDate,
    required this.countdownTitle,
    required this.countdownSubtitle,
    required this.countdownLeadLabel,
    required this.countdownTargetLabel,
    required this.daysLabel,
    required this.hoursLabel,
    required this.minutesLabel,
    required this.secondsLabel,
    required this.storyLines,
    required this.storyInvite,
    required this.locationTitle,
    required this.venueName,
    required this.locationSummary,
    required this.fullAddress,
    required this.locationButtonLabel,
    required this.calendarButtonLabel,
    required this.calendarTitle,
    required this.calendarDescription,
    required this.rsvpTitle,
    required this.rsvpDateLimit,
    required this.emailButtonLabel,
    required this.whatsappButtonLabel,
    required this.emailSubject,
    required this.whatsappMessage,
    required this.dressCodeLabel,
    required this.dressCode,
    required this.registryLabel,
    required this.registryNote,
    required this.footerMessage,
    required this.linkErrorMessage,
  });

  final String heroTagline;
  final String celebrationDate;
  final String countdownTitle;
  final String countdownSubtitle;
  final String countdownLeadLabel;
  final String countdownTargetLabel;
  final String daysLabel;
  final String hoursLabel;
  final String minutesLabel;
  final String secondsLabel;
  final List<String> storyLines;
  final String storyInvite;
  final String locationTitle;
  final String venueName;
  final String locationSummary;
  final String fullAddress;
  final String locationButtonLabel;
  final String calendarButtonLabel;
  final String calendarTitle;
  final String calendarDescription;
  final String rsvpTitle;
  final String rsvpDateLimit;
  final String emailButtonLabel;
  final String whatsappButtonLabel;
  final String emailSubject;
  final String whatsappMessage;
  final String dressCodeLabel;
  final String dressCode;
  final String registryLabel;
  final String registryNote;
  final String footerMessage;
  final String linkErrorMessage;
}

enum InvitationLocale { es, fr }
