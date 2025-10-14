
import 'dart:async';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:invitacion_boda_mama/background_video.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const WeddingInvitationApp());
}

class WeddingInvitationApp extends StatelessWidget {
  const WeddingInvitationApp({super.key});

  @override
  Widget build(BuildContext context) {
    final baseColorScheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF4A665A),
      brightness: Brightness.light,
    );

    const onCanvasColor = Color(0xFF2F3C35);

    final colorScheme = baseColorScheme.copyWith(
      surface: Colors.white,
      onSurface: onCanvasColor,
      onSurfaceVariant: const Color(0xFF4F5A54),
      secondary: const Color(0xFF9BB0A6),
      onSecondary: Colors.white,
      tertiary: const Color(0xFFBFA084),
      onTertiary: const Color(0xFF2E261F),
    );

    final textTheme = TextTheme(
      displayLarge: GoogleFonts.playfairDisplay(
        fontSize: 60,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.8,
        color: colorScheme.onPrimary,
      ),
      displaySmall: GoogleFonts.playfairDisplay(
        fontSize: 42,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.1,
        color: onCanvasColor,
      ),
      headlineMedium: GoogleFonts.playfairDisplay(
        fontSize: 27,
        fontWeight: FontWeight.w500,
        color: onCanvasColor,
      ),
      headlineSmall: GoogleFonts.playfairDisplay(
        fontSize: 22,
        fontWeight: FontWeight.w500,
        color: colorScheme.onSurfaceVariant,
      ),
      titleMedium: GoogleFonts.workSans(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
        color: onCanvasColor,
      ),
      bodyLarge: GoogleFonts.workSans(
        fontSize: 18,
        height: 1.65,
        color: onCanvasColor,
      ),
      bodyMedium: GoogleFonts.workSans(
        fontSize: 16,
        height: 1.6,
        color: colorScheme.onSurfaceVariant,
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
        chipTheme: ChipThemeData(
          backgroundColor: colorScheme.secondary.withValues(alpha: 0.15),
          selectedColor: colorScheme.secondary.withValues(alpha: 0.85),
          labelStyle: GoogleFonts.workSans(
            fontSize: 14,
            color: colorScheme.onSurface,
            letterSpacing: 0.4,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          shape: const StadiumBorder(),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: colorScheme.primary,
            foregroundColor: colorScheme.onPrimary,
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: colorScheme.primary,
            side: BorderSide(color: colorScheme.primary.withValues(alpha: 0.4)),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: colorScheme.primary,
            textStyle: GoogleFonts.workSans(
              fontSize: 15,
              fontWeight: FontWeight.w600,
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
    coupleNames: 'Laura & Daniel',
    videoUrl:
        'https://drive.google.com/uc?export=preview&id=1vGb6uF29ar4cRDjivzp5qx-QHj8t20-R',
    mapUrl: 'https://maps.app.goo.gl/D1xExampleParis',
    rsvpEmail: 'confirmaciones@bodalauraydaniel.com',
    rsvpPhoneNumber: '5491112345678',
    localized: {
      InvitationLocale.es: LocaleStrings(
        heroTagline: 'Nos casamos',
        celebrationDate: 'Viernes 20 de noviembre de 2026 · 17:00 hs',
        countdownTitle: 'Cuenta regresiva',
        countdownSubtitle: 'Hasta el 20 de noviembre de 2026',
        countdownLeadLabel: 'Faltan',
        countdownTargetLabel: '20 de noviembre de 2026 · París',
        daysLabel: 'Días',
        hoursLabel: 'Horas',
        minutesLabel: 'Minutos',
        secondsLabel: 'Segundos',
        storyLines: [
          'Diez años, muchas aventuras.',
          'Una historia.',
          'Y ahora... la más especial de todas.',
          'Esta vez queremos que seas parte.',
        ],
        storyInvite:
            'Te invitamos a compartir con nosotros este momento tan especial.',
        celebrationTitle: 'La celebración',
        introText:
            'Queremos que vivas una tarde serena en París: un encuentro cercano, música suave y una cena pensada para disfrutar despacio.',
        highlights: [
          'Ceremonia íntima con vistas a la ciudad',
          'Coctel al atardecer con sabores franceses',
          'Fiesta bajo luces cálidas y música en vivo',
        ],
        scheduleTitle: 'Itinerario',
        schedule: [
          LocaleScheduleItem(
            time: '16:30',
            title: 'Recepción',
            description:
                'Limonadas frescas, infusiones y aperitivos para comenzar juntos la tarde.',
          ),
          LocaleScheduleItem(
            time: '17:00',
            title: 'Ceremonia',
            description:
                'Un momento íntimo al aire libre para celebrar nuestro compromiso.',
          ),
          LocaleScheduleItem(
            time: '18:30',
            title: 'Brindis & Fotos',
            description:
                'Brindaremos con quienes más queremos y capturaremos recuerdos inolvidables.',
          ),
          LocaleScheduleItem(
            time: '19:30',
            title: 'Cena & Fiesta',
            description:
                'Gastronomía de temporada y pista al aire libre para bailar hasta tarde.',
          ),
        ],
        locationTitle: 'Ubicación',
        venueName: 'París',
        locationSummary: 'París, Francia',
        fullAddress: 'París, Francia',
        locationButtonLabel: 'Ver en Google Maps',
        calendarButtonLabel: 'Agregar al calendario',
        calendarTitle: 'Boda',
        calendarDescription:
            'Celebramos nuestra boda en París. ¡Te esperamos para brindar juntos!',
        rsvpTitle: 'Confirmar asistencia',
        rsvpDateLimit: 'Por favor confirmá tu asistencia antes del 5 de noviembre.',
        emailButtonLabel: 'Enviar correo',
        whatsappButtonLabel: 'Mensaje por WhatsApp',
        emailSubject: 'Confirmación de asistencia',
        whatsappMessage:
            'Hola! Quiero confirmar mi asistencia a la boda de Laura y Daniel.',
        dressCodeLabel: 'Dress code',
        dressCode: 'Elegante relajado en tonos neutros, tierra o verdes suaves.',
        registryLabel: 'Regalo',
        registryNote:
            'Tu presencia es nuestro mejor regalo. Si deseás acompañarnos con un detalle, habrá una pequeña urna durante la recepción.',
        footerMessage:
            'Gracias por ser parte de este capítulo tan importante.',
        linkErrorMessage:
            'No pudimos abrir el enlace. Podés copiarlo desde la invitación.',
      ),
      InvitationLocale.fr: LocaleStrings(
        heroTagline: 'Nous nous marions',
        celebrationDate: 'Vendredi 20 novembre 2026 · 17h00',
        countdownTitle: 'Compte à rebours',
        countdownSubtitle: 'Jusqu’au 20 novembre 2026',
        countdownLeadLabel: 'Plus que',
        countdownTargetLabel: '20 novembre 2026 · Paris',
        daysLabel: 'Jours',
        hoursLabel: 'Heures',
        minutesLabel: 'Minutes',
        secondsLabel: 'Secondes',
        storyLines: [
          'Dix ans, tant d’aventures.',
          'Une histoire.',
          'Et maintenant... la plus spéciale de toutes.',
          'Cette fois, nous voulons que tu en fasses partie.',
        ],
        storyInvite:
            'Nous t’invitons à partager avec nous ce moment si spécial.',
        celebrationTitle: 'La célébration',
        introText:
            'Nous rêvons d’une fin d’après-midi paisible à Paris : une rencontre intime, une musique douce et un dîner pensé pour savourer chaque instant.',
        highlights: [
          'Cérémonie intime avec vue sur la ville',
          'Cocktail au coucher du soleil aux saveurs françaises',
          'Fête sous des lumières chaleureuses et musique live',
        ],
        scheduleTitle: 'Programme',
        schedule: [
          LocaleScheduleItem(
            time: '16h30',
            title: 'Accueil',
            description:
                'Limonades, infusions et petites bouchées pour commencer la soirée en douceur.',
          ),
          LocaleScheduleItem(
            time: '17h00',
            title: 'Cérémonie',
            description:
                'Un moment intime en plein air pour célébrer notre engagement.',
          ),
          LocaleScheduleItem(
            time: '18h30',
            title: 'Toast & Photos',
            description:
                'Nous lèverons nos verres entourés de ceux que nous aimons et garderons de beaux souvenirs.',
          ),
          LocaleScheduleItem(
            time: '19h30',
            title: 'Dîner & Fête',
            description:
                'Cuisine de saison et piste en plein air pour danser jusqu’au bout de la nuit.',
          ),
        ],
        locationTitle: 'Localisation',
        venueName: 'Paris',
        locationSummary: 'Paris, France',
        fullAddress: 'Paris, France',
        locationButtonLabel: 'Voir sur Google Maps',
        calendarButtonLabel: 'Ajouter au calendrier',
        calendarTitle: 'Mariage',
        calendarDescription:
            'Nous célébrons notre mariage à Paris. Nous t’attendons pour trinquer ensemble !',
        rsvpTitle: 'Confirmer ta présence',
        rsvpDateLimit:
            'Merci de confirmer ta présence avant le 5 novembre.',
        emailButtonLabel: 'Envoyer un e-mail',
        whatsappButtonLabel: 'Message WhatsApp',
        emailSubject: 'Confirmation de présence',
        whatsappMessage:
            'Bonjour ! Je souhaite confirmer ma présence au mariage de Laura et Daniel.',
        dressCodeLabel: 'Tenue',
        dressCode:
            'Élégant décontracté dans des tons neutres, terre ou verts doux.',
        registryLabel: 'Cadeau',
        registryNote:
            'Ta présence est notre plus beau cadeau. Si tu souhaites nous offrir un détail, une petite urne sera disponible pendant la réception.',
        footerMessage:
            'Merci de faire partie de ce chapitre si important.',
        linkErrorMessage:
            'Nous n’avons pas pu ouvrir le lien. Tu peux le copier depuis l’invitation.',
      ),
    },
  );

  @override
  State<WeddingInvitationPage> createState() => _WeddingInvitationPageState();
}
class _WeddingInvitationPageState extends State<WeddingInvitationPage> {
  final ScrollController _scrollController = ScrollController();
  final DateTime _targetDate = DateTime(2026, 11, 20, 17);
  late final ValueNotifier<Duration> _countdownNotifier =
      ValueNotifier<Duration>(_timeRemaining());
  InvitationLocale _locale = InvitationLocale.es;
  Timer? _timer;
  double _scrollOffset = 0;

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

  double get _blurSigma {
    final double raw = _scrollOffset / 45;
    return raw.clamp(0.0, 18.0);
  }

  double get _overlayOpacity {
    final double raw = _scrollOffset / 480;
    return raw.clamp(0.0, 0.65);
  }

  void _switchLocale(InvitationLocale locale) {
    if (locale == _locale) {
      return;
    }
    setState(() {
      _locale = locale;
    });
  }

  void _scrollToCountdown() {
    if (!_scrollController.hasClients) {
      return;
    }
    final double heroHeight = MediaQuery.of(context).size.height;
    final double targetOffset = heroHeight * 0.95;
    _scrollController.animateTo(
      targetOffset,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOut,
    );
  }

  Future<void> _openLink(
    BuildContext context,
    String url,
    String errorMessage,
  ) async {
    final uri = Uri.parse(url);
    final bool launched =
        await launchUrl(uri, mode: LaunchMode.platformDefault);
    if (!launched) {
      if (!context.mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
        ),
      );
    }
  }

  String _buildCalendarUrl(WeddingDetails details, LocaleStrings strings) {
    const start = '20261120T200000Z';
    const end = '20261121T020000Z';
    final title =
        Uri.encodeComponent('${details.coupleNames} · ${strings.calendarTitle}');
    final location = Uri.encodeComponent(strings.fullAddress);
    final description = Uri.encodeComponent(strings.calendarDescription);
    return 'https://www.google.com/calendar/render?action=TEMPLATE&text=$title&dates=$start/$end&location=$location&details=$description';
  }
  @override
  Widget build(BuildContext context) {
    final details = WeddingInvitationPage.details;
    final LocaleStrings strings = details.stringsFor(_locale);
    final theme = Theme.of(context);
    final Size size = MediaQuery.of(context).size;
    final bool isWide = size.width >= 900;
    final double horizontalPadding = isWide ? 160 : 24;
    final double heroHeight = size.height;

    final String mailtoUrl =
        'mailto:${details.rsvpEmail}?subject=${Uri.encodeComponent(strings.emailSubject)}';
    final String whatsappUrl =
        'https://wa.me/${details.rsvpPhoneNumber}?text=${Uri.encodeComponent(strings.whatsappMessage)}';
    final String calendarUrl = _buildCalendarUrl(details, strings);

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: BackgroundVideo(
              videoUrl: details.videoUrl,
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
                          details: details,
                          strings: strings,
                          onScrollPromptTap: _scrollToCountdown,
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
                          _CountdownSection(
                            countdown: _countdownNotifier,
                            strings: strings,
                          ),
                          const SizedBox(height: 32),
                          _StorySection(strings: strings),
                          const SizedBox(height: 32),
                          SectionCard(
                            title: strings.celebrationTitle,
                            icon: Icons.wb_sunny_outlined,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  strings.introText,
                                  style: theme.textTheme.bodyLarge,
                                ),
                                const SizedBox(height: 24),
                                Wrap(
                                  spacing: 12,
                                  runSpacing: 12,
                                  children: strings.highlights
                                      .map(
                                        (highlight) => Chip(
                                          label: Text(highlight),
                                          backgroundColor: theme
                                              .colorScheme.secondary
                                              .withValues(alpha: 0.12),
                                          labelStyle: theme
                                              .textTheme.bodyMedium
                                              ?.copyWith(
                                            color: theme.colorScheme.onSurface,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                              ],
                            ),
                          ),
                          SectionCard(
                            title: strings.scheduleTitle,
                            icon: Icons.schedule_outlined,
                            child: _ScheduleTimeline(items: strings.schedule),
                          ),
                          SectionCard(
                            title: strings.locationTitle,
                            icon: Icons.place_outlined,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  strings.venueName,
                                  style: theme.textTheme.headlineSmall,
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  strings.locationSummary,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: theme.colorScheme.primary,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                SelectableText(
                                  strings.fullAddress,
                                  style: theme.textTheme.bodyMedium,
                                ),
                                const SizedBox(height: 24),
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
                                      icon: const Icon(Icons.map_outlined),
                                      label: Text(strings.locationButtonLabel),
                                    ),
                                    TextButton.icon(
                                      onPressed: () => _openLink(
                                        context,
                                        calendarUrl,
                                        strings.linkErrorMessage,
                                      ),
                                      icon:
                                          const Icon(Icons.event_available_outlined),
                                      label: Text(strings.calendarButtonLabel),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SectionCard(
                            title: strings.rsvpTitle,
                            icon: Icons.mark_email_read_outlined,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  strings.rsvpDateLimit,
                                  style: theme.textTheme.bodyMedium,
                                ),
                                const SizedBox(height: 20),
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
                                      icon: const Icon(Icons.email_outlined),
                                      label: Text(strings.emailButtonLabel),
                                    ),
                                    OutlinedButton.icon(
                                      onPressed: () => _openLink(
                                        context,
                                        whatsappUrl,
                                        strings.linkErrorMessage,
                                      ),
                                      icon: const Icon(Icons.chat_bubble_outline),
                                      label: Text(strings.whatsappButtonLabel),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 28),
                                _InfoRow(
                                  icon: Icons.style_outlined,
                                  label: strings.dressCodeLabel,
                                  value: strings.dressCode,
                                ),
                                const SizedBox(height: 20),
                                _InfoRow(
                                  icon: Icons.card_giftcard_outlined,
                                  label: strings.registryLabel,
                                  value: strings.registryNote,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          _Footer(
                            details: details,
                            strings: strings,
                          ),
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
              child: _LanguageToggle(
                selected: _locale,
                onChanged: _switchLocale,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
class _HeroOverlay extends StatelessWidget {
  const _HeroOverlay({
    required this.details,
    required this.strings,
    required this.onScrollPromptTap,
  });

  final WeddingDetails details;
  final LocaleStrings strings;
  final VoidCallback onScrollPromptTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isWide = MediaQuery.of(context).size.width >= 720;
    final Color tagColor = Colors.white.withValues(alpha: 0.85);
    final Color textColor = Colors.white.withValues(alpha: 0.95);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          strings.heroTagline,
          style: theme.textTheme.titleMedium?.copyWith(
            color: tagColor,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  details.coupleNames,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.displayLarge?.copyWith(
                    fontSize: isWide ? 64 : 42,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  strings.celebrationDate,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.white.withValues(alpha: 0.92),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: onScrollPromptTap,
          child: Column(
            children: [
              Text(
                strings.countdownSubtitle,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.white.withValues(alpha: 0.75),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 38,
                color: Colors.white.withValues(alpha: 0.85),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _LanguageToggle extends StatelessWidget {
  const _LanguageToggle({
    required this.selected,
    required this.onChanged,
  });

  final InvitationLocale selected;
  final ValueChanged<InvitationLocale> onChanged;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<InvitationLocale>(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? Colors.white.withValues(alpha: 0.9)
              : Colors.white.withValues(alpha: 0.35),
        ),
        foregroundColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? const Color(0xFF2F3C35)
              : Colors.white,
        ),
        side: WidgetStateProperty.resolveWith(
          (states) => BorderSide(
            color: Colors.white.withValues(
              alpha: states.contains(WidgetState.selected) ? 0.7 : 0.5,
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
      onSelectionChanged: (Set<InvitationLocale> values) {
        if (values.isNotEmpty) {
          onChanged(values.first);
        }
      },
    );
  }
}

class _CountdownSection extends StatelessWidget {
  const _CountdownSection({
    required this.countdown,
    required this.strings,
  });

  final ValueListenable<Duration> countdown;
  final LocaleStrings strings;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Color cardColor = Colors.white.withValues(alpha: 0.16);
    final Color borderColor = Colors.white.withValues(alpha: 0.24);
    final Color headlineColor = Colors.white.withValues(alpha: 0.95);
    final Color bodyColor = Colors.white.withValues(alpha: 0.82);

    return ClipRRect(
      borderRadius: BorderRadius.circular(32),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 36),
          decoration: BoxDecoration(
            color: cardColor,
            border: Border.all(color: borderColor),
          ),
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
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: bodyColor,
                ),
              ),
              const SizedBox(height: 24),
              ValueListenableBuilder<Duration>(
                valueListenable: countdown,
                builder: (context, duration, _) {
                  final breakdown = _TimeBreakdown.fromDuration(duration);
                  return Column(
                    children: [
                      Text(
                        strings.countdownLeadLabel.toUpperCase(),
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: headlineColor,
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 18,
                        runSpacing: 18,
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
              const SizedBox(height: 24),
              Text(
                strings.countdownTargetLabel,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: bodyColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class _CountdownValue extends StatelessWidget {
  const _CountdownValue({
    required this.value,
    required this.label,
  });

  final int value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Color background = Colors.white.withValues(alpha: 0.12);
    final Color border = Colors.white.withValues(alpha: 0.22);
    final Color textColor = Colors.white.withValues(alpha: 0.95);
    final Color labelColor = Colors.white.withValues(alpha: 0.75);

    return Container(
      width: 88,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: border),
      ),
      child: Column(
        children: [
          Text(
            value.toString().padLeft(2, '0'),
            style: theme.textTheme.displaySmall?.copyWith(
              fontSize: 36,
              color: textColor,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label.toUpperCase(),
            style: theme.textTheme.bodySmall?.copyWith(
              color: labelColor,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}

class _StorySection extends StatelessWidget {
  const _StorySection({required this.strings});

  final LocaleStrings strings;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Color background = Colors.white.withValues(alpha: 0.14);
    final Color border = Colors.white.withValues(alpha: 0.2);
    final Color textColor = Colors.white.withValues(alpha: 0.92);

    return ClipRRect(
      borderRadius: BorderRadius.circular(32),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 36),
          decoration: BoxDecoration(
            color: background,
            border: Border.all(color: border),
          ),
          child: Column(
            children: [
              for (final line in strings.storyLines) ...[
                Text(
                  line,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.displaySmall?.copyWith(
                    fontSize: 28,
                    height: 1.3,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 8),
              ],
              const SizedBox(height: 12),
              Text(
                strings.storyInvite,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: textColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ScheduleTimeline extends StatelessWidget {
  const _ScheduleTimeline({required this.items});

  final List<LocaleScheduleItem> items;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        for (int index = 0; index < items.length; index++) ...[
          _ScheduleTile(item: items[index]),
          if (index != items.length - 1)
            Divider(
              height: 24,
              color: theme.colorScheme.outlineVariant,
            ),
        ],
      ],
    );
  }
}

class _ScheduleTile extends StatelessWidget {
  const _ScheduleTile({required this.item});

  final LocaleScheduleItem item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 80,
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            item.time,
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.title,
                style: theme.textTheme.titleMedium,
              ),
              const SizedBox(height: 6),
              Text(
                item.description,
                style: theme.textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ],
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
              Text(
                label,
                style: theme.textTheme.titleMedium,
              ),
              const SizedBox(height: 6),
              Text(
                value,
                style: theme.textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer({
    required this.details,
    required this.strings,
  });

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
            color: theme.colorScheme.onSurfaceVariant,
            letterSpacing: 0.8,
          ),
        ),
        const SizedBox(height: 40),
      ],
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
    return Container(
      margin: const EdgeInsets.only(bottom: 32),
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: theme.colorScheme.outlineVariant),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 26,
            offset: const Offset(0, 18),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: theme.colorScheme.primary),
              const SizedBox(width: 12),
              Text(title, style: theme.textTheme.headlineMedium),
            ],
          ),
          const SizedBox(height: 20),
          child,
        ],
      ),
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
    final int totalSeconds = duration.inSeconds;
    final int days = duration.inDays;
    final int hours = (totalSeconds - days * 86400) ~/ 3600;
    final int minutes =
        (totalSeconds - days * 86400 - hours * 3600) ~/ 60;
    final int seconds = totalSeconds % 60;
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
    required this.mapUrl,
    required this.rsvpEmail,
    required this.rsvpPhoneNumber,
    required this.localized,
  });

  final String coupleNames;
  final String videoUrl;
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
    required this.celebrationTitle,
    required this.introText,
    required this.highlights,
    required this.scheduleTitle,
    required this.schedule,
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
  final String celebrationTitle;
  final String introText;
  final List<String> highlights;
  final String scheduleTitle;
  final List<LocaleScheduleItem> schedule;
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

class LocaleScheduleItem {
  const LocaleScheduleItem({
    required this.time,
    required this.title,
    required this.description,
  });

  final String time;
  final String title;
  final String description;
}

enum InvitationLocale { es, fr }
