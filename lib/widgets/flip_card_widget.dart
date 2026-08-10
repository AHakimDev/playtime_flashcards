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
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
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
    await widget.tts.setLanguage("en-US");
    await widget.tts.setSpeechRate(0.4);
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
          final isFrontVisible = angle <= pi / 2;

          return Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(angle),
            alignment: Alignment.center,
            child: isFrontVisible
                ? _buildFrontSide()
                : Transform(
                    transform: Matrix4.identity()..rotateY(pi),
                    alignment: Alignment.center,
                    child: _buildBackSide(),
                  ),
          );
        },
      ),
    );
  }

  Widget _buildFrontSide() {
    return Container(
      margin: const EdgeInsets.all(24),
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 15, offset: Offset(0, 8)),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
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

  Widget _buildBackSide() {
    return Container(
      margin: const EdgeInsets.all(24),
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 15, offset: Offset(0, 8)),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // 🟢 استفاده از LayoutBuilder برای تنظیم سایز المان‌ها بر اساس ارتفاع در دسترس
          double titleSize = constraints.maxHeight * 0.15;
          double subtitleSize = constraints.maxHeight * 0.08;
          double iconSize = constraints.maxHeight * 0.25;

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.flashcard.word,
                style: TextStyle(
                  fontSize: titleSize.clamp(24, 56),
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.flashcard.persianWord,
                style: TextStyle(
                  fontSize: subtitleSize.clamp(16, 32),
                  fontWeight: FontWeight.w500,
                  color: Colors.blueGrey.withOpacity(0.6),
                ),
              ),
              const SizedBox(height: 24),
              GestureDetector(
                onTap: _speakWord,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.volume_up_rounded,
                    size: iconSize.clamp(40, 80),
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
