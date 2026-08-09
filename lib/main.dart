import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // 🟢 اضافه شدن پکیج سرویس‌ها برای کنترل دیوایس
import 'screens/book_selection_screen.dart';

void main() async {
  // 🟢 اطمینان از مقداردهی اولیه فلاتر قبل از اعمال تنظیمات سیستمی
  WidgetsFlutterBinding.ensureInitialized();

  // 🟢 قفل کردن جهت صفحه فقط روی حالت عمودی (بالا و پایین)
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const KidsFlashcardApp());
}

class KidsFlashcardApp extends StatelessWidget {
  const KidsFlashcardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PT Cards', // 🟢 تغییر نام به اسم جدید و یکپارچه
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orangeAccent),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF0F8FF),
        // 🟢 تنظیم سراسری اپ‌بار و نوار وضعیت برای تمام صفحات
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.dark, // سیاه کردن آیکون‌های باتری و ساعت
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.blueGrey), // رنگ فلش برگشت
          titleTextStyle: TextStyle(
            color: Colors.blueGrey,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: const BookSelectionScreen(),
    );
  }
}