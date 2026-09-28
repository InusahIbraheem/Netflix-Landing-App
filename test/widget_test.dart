import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:netflix_landing_ui/core/constants/app_constants.dart';
import 'package:netflix_landing_ui/widgets/developer_footer.dart';

void main() {
  test('app constants are configured', () {
    expect(AppConstants.appName, 'Netflix Landing UI');
    expect(AppConstants.developer, '@inusah_ibraheem');
  });

  testWidgets('Developer footer displays credit', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: DeveloperFooter()),
      ),
    );
    expect(find.text('Developed by @inusah_ibraheem'), findsOneWidget);
  });
}
