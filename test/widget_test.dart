import 'package:flutter_test/flutter_test.dart';

import 'package:invitacion_boda_mama/main.dart';

void main() {
  testWidgets('Wedding invitation renders hero, countdown, and location in Spanish',
      (WidgetTester tester) async {
    await tester.pumpWidget(const WeddingInvitationApp());

    expect(
      find.text(WeddingInvitationPage.details.coupleNames),
      findsWidgets,
    );
    expect(find.text('Cuenta regresiva'), findsOneWidget);
    expect(find.text('Ubicación'), findsOneWidget);
    expect(find.text('Confirmar asistencia'), findsOneWidget);
  });
}
