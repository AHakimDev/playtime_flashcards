import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // 🟢 اضافه شده برای مدیریت نوار وضعیت
import '../models/flashcard_model.dart';
import 'home_screen.dart';

class BookSelectionScreen extends StatelessWidget {
  const BookSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final double maxWidth = kIsWeb ? screenWidth * 0.75 : double.infinity;

    // 🟢 استفاده از AnnotatedRegion برای تیره ماندن آیکون‌های نوار وضعیت
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFE0F7FA),
                Color(0xFFFCE4EC),
              ],
            ),
          ),
          child: SafeArea( // 🟢 جلوگیری از تداخل با نوار وضعیت
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: maxWidth),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // هدر و بنر جذاب بالای صفحه
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFFFF758C), Color(0xFFFF7EB3)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(32),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.pink.withOpacity(0.3),
                              blurRadius: 12,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Column(
                          children: const [
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                '🌟 Play Time Flashcards 🌟',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'دنیای شاد یادگیری زبان انگلیسی',
                              textAlign: TextAlign.center,
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),
                      // راهنمای انتخاب کتاب
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        textDirection: TextDirection.rtl,
                        children: const [
                          Icon(Icons.touch_app_rounded, color: Colors.blueAccent),
                          SizedBox(width: 8),
                          Text(
                            'لطفاً کتاب مورد نظر را انتخاب کنید 👇',
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      _buildBookButton(
                        context: context,
                        title: 'Play Time A',
                        subtitle: '۵۰ فلش‌کارت جذاب',
                        gradientColors: [const Color(0xFFFF9966), const Color(0xFFFF5E62)],
                        icon: '🎒',
                        level: BookLevel.levelA,
                      ),
                      const SizedBox(height: 20),
                      _buildBookButton(
                        context: context,
                        title: 'Play Time B',
                        subtitle: '۴۸ فلش‌کارت جذاب',
                        gradientColors: [const Color(0xFF00C9FF), const Color(0xFF92FE9D)],
                        icon: '🚀',
                        level: BookLevel.levelB,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBookButton({
    required BuildContext context,
    required String title,
    required String subtitle,
    required List<Color> gradientColors,
    required String icon,
    required BookLevel level,
  }) {
    return Container(
      width: double.infinity,
      height: 110,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: gradientColors.last.withOpacity(0.4),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(28),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(
                  selectedLevel: level,
                  bookTitle: title,
                ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    shape: BoxShape.circle,
                  ),
                  child: Text(icon, style: const TextStyle(fontSize: 36)),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        textDirection: TextDirection.rtl,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.white,
                  size: 28,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}