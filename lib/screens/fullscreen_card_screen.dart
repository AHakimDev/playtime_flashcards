import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../models/flashcard_model.dart';
import '../widgets/flip_card_widget.dart';
import 'listen_match_screen.dart';

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
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          _flutterTts.stop(); // 🟢 توقف فوری صدا هنگام بازگشت از نمایش کارت
        }
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          title: Directionality(
            textDirection: TextDirection.rtl,
            child: Text(
              widget.categoryTitle,
              style: const TextStyle(fontWeight: FontWeight.bold),
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
          child: SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 20), // 🟢 فاصله اضافی از AppBar
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
                                  bottom: 10,
                                  // 🟢 کمی پایین‌تر برای ایجاد فاصله از محتوای کارت
                                  child: IgnorePointer(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(30),
                                      child: BackdropFilter(
                                        filter: ImageFilter.blur(
                                            sigmaX: 8.0, sigmaY: 8.0),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 8),
                                          // 🟢 پدینگ کمتر برای دسکتاپ
                                          decoration: BoxDecoration(
                                            color:
                                                Colors.black.withOpacity(0.4),
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            border: Border.all(
                                                color: Colors.white
                                                    .withOpacity(0.3)),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: const [
                                              Icon(
                                                  Icons
                                                      .flip_camera_android_rounded,
                                                  color: Colors.white,
                                                  size: 20 // 🟢 سایز آیکون کمی کوچک‌تر
                                                  ),
                                              SizedBox(width: 8),
                                              Directionality(
                                                textDirection:
                                                    TextDirection.rtl,
                                                child: Text(
                                                  'لمس کن تا اسمشو بگم!',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 13,
                                                    // 🟢 سایز متن کمی کوچک‌تر
                                                    wordSpacing: 0.5,
                                                  ),
                                                ),
                                              )
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
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 24.0),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 600),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // دکمه قبلی
                        ElevatedButton(
                          onPressed: _currentIndex > 0 ? _goToPrevious : null,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 16),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.blueGrey,
                            elevation: 4,
                            disabledBackgroundColor: Colors.white54,
                          ),
                          child: const Icon(Icons.arrow_back_ios_rounded,
                              size: 28),
                        ),

                        // 🟢 نوار پیشرفت متحرک بصری (جایگزین شمارنده متنی)
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${_currentIndex + 1}',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blueGrey,
                                      ),
                                    ),
                                    Icon(
                                      Icons.sports_esports_rounded,
                                      color: _currentIndex ==
                                              widget.cards.length - 1
                                          ? Colors.orangeAccent
                                          : Colors.blueGrey.withOpacity(0.4),
                                      size: 24,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: TweenAnimationBuilder<double>(
                                    tween: Tween<double>(
                                      begin: 0,
                                      end: (_currentIndex + 1) /
                                          widget.cards.length,
                                    ),
                                    duration: const Duration(milliseconds: 300),
                                    builder: (context, value, _) =>
                                        LinearProgressIndicator(
                                      value: value,
                                      minHeight: 12,
                                      backgroundColor:
                                          Colors.white.withOpacity(0.6),
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        _currentIndex == widget.cards.length - 1
                                            ? Colors.orangeAccent
                                            : Colors.blueAccent
                                                .withOpacity(0.7),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // دکمه بعدی / ورود به بازی
                        _currentIndex < widget.cards.length - 1
                            ? ElevatedButton(
                                onPressed: _goToNext,
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 16),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16)),
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.blueGrey,
                                  elevation: 4,
                                ),
                                child: const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 28),
                              )
                            : ElevatedButton(
                                onPressed: () {
                                  _flutterTts.stop();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ListenMatchScreen(
                                        categoryCards: widget.cards,
                                        categoryTitle: widget.categoryTitle,
                                      ),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 16),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16)),
                                  backgroundColor: Colors.orangeAccent,
                                  foregroundColor: Colors.white,
                                  elevation: 6,
                                ),
                                child: const Icon(Icons.sports_esports_rounded,
                                    size: 28),
                              ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
