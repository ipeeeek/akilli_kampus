import 'package:flutter_test/flutter_test.dart';
import 'package:akilli_kampus/main.dart';

void main() {
  testWidgets('App builds', (WidgetTester tester) async {
    await tester.pumpWidget(const AnaUygulama());
    await tester.pump();
    expect(find.byType(AnaUygulama), findsOneWidget);
  });
}
