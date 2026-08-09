import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // 🟢 اضافه شده
import 'package:flutter_tts/flutter_tts.dart';
import '../models/flashcard_model.dart';
import '../widgets/flip_card_widget.dart';

class FullscreenCardScreen extends StatefulWidget {
  final List<FlashcardModel> cards;
  final int initialIndex;
  final String categoryTitle;

  const FullscreenCardScreen({
    super.key,
    required this.cards,
    required this.initialIndex,
    required this.categoryTitle,
  });

  @override
  State<FullscreenCardScreen> createState() => _FullscreenCardScreenState();
}

class _FullscreenCardScreenState extends State<FullscreenCardScreen> {
  late PageController _pageController;
  final FlutterTts _flutterTts = FlutterTts();
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
    _initTts();
  }

  Future<void> _initTts() async {
    await _flutterTts.setLanguage("en-US");
    await _flutterTts.setSpeechRate(0.4);
    await _flutterTts.setPitch(1.0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _flutterTts.stop();
    super.dispose();
  }

  void _goToNext() {
    if (_currentIndex < widget.cards.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  void _goToPrevious() {
    if (_currentIndex > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark, // 🟢 مدیریت نوار وضعیت
        title: Text(
          widget.categoryTitle,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.blueGrey),
      ),
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
        child: SafeArea( // 🟢 جلوگیری از تداخل محتوا با نوار وضعیت
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  physics: const BouncingScrollPhysics(),
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  itemCount: widget.cards.length,
                  itemBuilder: (context, index) {
                    return Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 600),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              FlipCardWidget(
                                flashcard: widget.cards[index],
                                tts: _flutterTts,
                              ),
                              Positioned(
                                bottom: 20,
                                child: IgnorePointer(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.4),
                                          borderRadius: BorderRadius.circular(30),
                                          border: Border.all(color: Colors.white.withOpacity(0.3)),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: const [
                                            Icon(
                                                Icons.flip_camera_android_rounded,
                                                color: Colors.white,
                                                size: 24
                                            ),
                                            SizedBox(width: 8),
                                            Text(
                                              'برای چرخش لمس کنید',
                                              textDirection: TextDirection.rtl,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 0.5,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: _currentIndex > 0 ? _goToPrevious : null,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.blueGrey,
                          elevation: 4,
                          disabledBackgroundColor: Colors.white54,
                        ),
                        child: const Icon(Icons.arrow_back_ios_rounded, size: 28),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '${_currentIndex + 1} / ${widget.cards.length}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: _currentIndex < widget.cards.length - 1 ? _goToNext : null,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.blueGrey,
                          elevation: 4,
                          disabledBackgroundColor: Colors.white54,
                        ),
                        child: const Icon(Icons.arrow_forward_ios_rounded, size: 28),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}