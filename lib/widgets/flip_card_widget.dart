import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../models/flashcard_model.dart';

class FlipCardWidget extends StatefulWidget {
  final FlashcardModel flashcard;
  final FlutterTts tts;

  const FlipCardWidget({
    super.key,
    required this.flashcard,
    required this.tts,
  });

  @override
  State<FlipCardWidget> createState() => _FlipCardWidgetState();
}

class _FlipCardWidgetState extends State<FlipCardWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isFront = true;

  @override
  void initState() {
    super.initState();
    // تنظیمات انیمیشن چرخشی
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600), // سرعت چرخش مناسب کودکان
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleCard() {
    if (_controller.isAnimating) return;
    if (_isFront) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    setState(() {
      _isFront = !_isFront;
    });
  }

  Future<void> _speakWord() async {
    await widget.tts.setLanguage("en-US"); // تنظیم لهجه روی انگلیسی
    await widget.tts.setSpeechRate(0.4); // سرعت آرام‌تر برای درک بهتر کودک
    await widget.tts.speak(widget.flashcard.word);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleCard,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          final angle = _animation.value * pi;
          // وقتی کارت از نیمه می‌گذرد، محتوای پشت را نشان می‌دهیم
          final isFrontVisible = angle <= pi / 2;

          return Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001) // ایجاد پرسپکتیو سه‌بعدی
              ..rotateY(angle),
            alignment: Alignment.center,
            child: isFrontVisible
                ? _buildFrontSide()
                : Transform(
              // جلوگیری از آینه‌ای شدن (برعکس شدن) محتوای پشت کارت
              transform: Matrix4.identity()..rotateY(pi),
              alignment: Alignment.center,
              child: _buildBackSide(),
            ),
          );
        },
      ),
    );
  }

  // --- طراحی روی کارت (فقط عکس) ---
  Widget _buildFrontSide() {
    return Container(
      margin: const EdgeInsets.all(24),
      width: double.infinity, // 🟢 اضافه شده برای یکسان‌سازی سایز با پشت کارت
      height: double.infinity, // 🟢 اضافه شده برای پر کردن فضای در دسترس
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 15, offset: Offset(0, 8)),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0), // ایجاد فاصله برای لبه‌های عکس
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child: Image.asset(
            widget.flashcard.imageAssetPath,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  // --- طراحی پشت کارت (متن انگلیسی، متن فارسی و دکمه بلندگو) ---
  Widget _buildBackSide() {
    return Container(
      margin: const EdgeInsets.all(24),
      width: double.infinity,
      height: double.infinity, // 🟢 اضافه شده برای هماهنگی با روی کارت
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 15, offset: Offset(0, 8)),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // نمایش کلمه انگلیسی
          Text(
            widget.flashcard.word,
            style: const TextStyle(
              fontSize: 56, // کمی کوچکتر شد تا فضای کافی برای کلمه فارسی باشد
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey,
            ),
          ),
          const SizedBox(height: 12),

          // نمایش کلمه فارسی
          Text(
            widget.flashcard.persianWord,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w500,
              // رنگ ملایم‌تر برای اینکه تمرکز اصلی روی کلمه انگلیسی بماند
              color: Colors.blueGrey.withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 48),

          // دکمه پخش صدا
          GestureDetector(
            onTap: _speakWord,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.volume_up_rounded,
                size: 80,
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}