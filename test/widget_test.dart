import 'package:flutter_test/flutter_test.dart';
import 'package:blindly/main.dart';

void main() {
  testWidgets('Initial screen shows blindly logo', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    // Verify that the logo text exists
    expect(find.text('blindly'), findsOneWidget);
  });
}
