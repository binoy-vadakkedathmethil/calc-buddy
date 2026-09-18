import 'package:calc_buddy/app/app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('CalcBuddy app shows home screen', (tester) async {
    await tester.pumpWidget(const CalcBuddyApp());

    expect(find.text('CalcBuddy'), findsWidgets);
    expect(find.text('Welcome to CalcBuddy 🧮'), findsOneWidget);
  });
}
