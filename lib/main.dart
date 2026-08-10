import 'package:flutter/foundation.dart'; // 🟢 اضافه شد برای تشخیص وب
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:window_manager/window_manager.dart';
import 'screens/book_selection_screen.dart';

// 🟢 استفاده از شرط بومی برای جلوگیری از خطای وب
import 'dart:io' show Platform;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 🟢 تنظیمات دسکتاپ - فقط اگر در وب نباشیم اجرا شود
  if (!kIsWeb && (Platform.isWindows || Platform.isMacOS || Platform.isLinux)) {
    await windowManager.ensureInitialized();
    WindowOptions windowOptions = const WindowOptions(
      size: Size(960, 600),
      minimumSize: Size(800, 550),
      center: true,
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.normal,
      title: 'PT Cards',
    );
    await windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }

  // 🟢 تنظیم جهت صفحه برای موبایل
  if (!kIsWeb) {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  runApp(const KidsFlashcardApp());
}

class KidsFlashcardApp extends StatelessWidget {
  const KidsFlashcardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PT Cards',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // 🟢 تنظیم فونت پایه برای کل اپلیکیشن (اولویت با Vazirmatn)
        fontFamily: 'Vazirmatn',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orangeAccent),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF0F8FF),

        appBarTheme: const AppBarTheme(
          toolbarHeight: 72, // 🟢 افزایش ارتفاع برای فاصله گرفتن از لبه بالای ویندوز
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.blueGrey),
          // 🟢 بهینه‌سازی فونت برای متون ترکیبی فارسی و انگلیسی
          titleTextStyle: TextStyle(
            fontFamily: 'Vazirmatn',
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