import 'package:flutter_test/flutter_test.dart';
import 'package:playtime_flashcards/main.dart';

// این فایل تست برای بررسی بارگذاری صحیح برنامه و صفحه انتخاب کتاب است.
void main() {
  testWidgets('App load and book selection screen test', (WidgetTester tester) async {
    // بارگذاری برنامه
    await tester.pumpWidget(const KidsFlashcardApp());

    // بررسی وجود تیتر صفحه اصلی
    expect(find.text('🌟 Play Time Flashcards 🌟'), findsOneWidget);

    // بررسی وجود دکمه‌های انتخاب کتاب
    expect(find.text('Play Time A'), findsOneWidget);
    expect(find.text('Play Time B'), findsOneWidget);

    // بررسی وجود متن راهنما
    expect(find.text('لطفاً کتاب مورد نظر را انتخاب کنید 👇'), findsOneWidget);
  });
}
