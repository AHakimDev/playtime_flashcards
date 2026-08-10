import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:confetti/confetti.dart';
import '../models/flashcard_model.dart';

class MemoryMatchScreen extends StatefulWidget {
  final List<FlashcardModel> allLevelCards;
  final String levelTitle;

  const MemoryMatchScreen({
    super.key,
    required this.allLevelCards,
    required this.levelTitle,
  });

  @override
  State<MemoryMatchScreen> createState() => _MemoryMatchScreenState();
}

class _MemoryMatchScreenState extends State<MemoryMatchScreen> {
  final FlutterTts _flutterTts = FlutterTts();
  final Random _random = Random();
  late ConfettiController _confettiController;

  List<FlashcardModel> _gridCards = [];
  List<int> _flippedIndices = [];
  List<int> _matchedIndices = [];
  bool _isLocked = false;

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 3));
    _initTts();
    _setupGame();
  }

  Future<void> _initTts() async {
    await _flutterTts.setLanguage("en-US");
    await _flutterTts.setSpeechRate(0.5);
  }

  void _setupGame() {
    Set<FlashcardModel> uniqueCards = {};
    while (uniqueCards.length < 4 &&
        uniqueCards.length < widget.allLevelCards.length) {
      uniqueCards
          .add(widget.allLevelCards[_random.nextInt(widget.allLevelCards.length)]);
    }

    _gridCards = uniqueCards.toList() + uniqueCards.toList();
    _gridCards.shuffle();

    setState(() {
      _flippedIndices.clear();
      _matchedIndices.clear();
      _isLocked = false;
    });
  }

  void _onCardTapped(int index) async {
    if (_isLocked ||
        _matchedIndices.contains(index) ||
        _flippedIndices.contains(index)) return;

    // پخش صدای کلمه انتخابی کارت
    await _flutterTts.stop();
    await _flutterTts.speak(_gridCards[index].word);

    setState(() => _flippedIndices.add(index));

    if (_flippedIndices.length == 2) {
      setState(() => _isLocked = true);
      int first = _flippedIndices[0];
      int second = _flippedIndices[1];

      if (_gridCards[first].word == _gridCards[second].word) {
        await _flutterTts.stop();
        await _flutterTts.speak("Great!");

        setState(() {
          _matchedIndices.addAll([first, second]);
          _flippedIndices.clear();
          _isLocked = false;
        });

        if (_matchedIndices.length == _gridCards.length) {
          _triggerWinSequence();
        }
      } else {
        Future.delayed(const Duration(milliseconds: 1000), () {
          if (mounted) {
            setState(() {
              _flippedIndices.clear();
              _isLocked = false;
            });
          }
        });
      }
    }
  }

  // 🟢 حذف کدهای صوتی اضافی و فقط اجرای افکت و دیالوگ
  void _triggerWinSequence() {
    _confettiController.play();
    _showWinDialog();
  }

  void _showWinDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Stack(
          alignment: Alignment.center,
          children: [
            const Directionality(
              textDirection: TextDirection.rtl,
              child: Text('آفرین!', textAlign: TextAlign.center),
            ),
            Positioned(
              left: 0,
              child: InkWell(
                // 🟢 حذف افکت‌های رنگی و سلکت شدن در زمان کلیک
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                onTap: () {
                  Navigator.pop(context); // بستن دیالوگ
                  Navigator.pop(context); // بازگشت به صفحه قبلی
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.close,
                    color: Colors.grey,
                    size: 22, // 🟢 کوچک‌تر کردن سایز ضرب‌در
                  ),
                ),
              ),
            ),
          ],
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // بستن دیالوگ و شروع مجدد بازی
              _setupGame();
            },
            child: const Text('دوباره بازی کنیم'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          _flutterTts.stop();
          _confettiController.stop();
        }
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Directionality(
            textDirection: TextDirection.rtl,
            child: Text(
              widget.levelTitle,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
        ),
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xFFFFF9C4), Color(0xFFFFE0B2)]),
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 800),
                  child: GridView.builder(
                    padding: const EdgeInsets.only(
                        top: 120,
                        left: 20,
                        right: 20,
                        bottom: 20), // 🟢 فاصله بیشتر از بالا
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: screenWidth > 600 ? 4 : 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 1.0,
                    ),
                    itemCount: _gridCards.length,
                    itemBuilder: (context, index) {
                      bool isFlipped = _flippedIndices.contains(index) ||
                          _matchedIndices.contains(index);

                      return GestureDetector(
                        onTap: () => _onCardTapped(index),
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 400),
                          transitionBuilder:
                              (Widget child, Animation<double> animation) {
                            return ScaleTransition(
                                scale: animation, child: child);
                          },
                          child: Container(
                            key: ValueKey<bool>(isFlipped),
                            decoration: BoxDecoration(
                              color: isFlipped
                                  ? Colors.white
                                  : Colors.orangeAccent,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Center(
                              child: isFlipped
                                  ? Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Image.asset(
                                        _gridCards[index].imageAssetPath,
                                        fit: BoxFit.contain,
                                      ),
                                    )
                                  : const Icon(
                                      Icons.help_outline,
                                      color: Colors.white,
                                      size: 48,
                                    ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: ConfettiWidget(
                confettiController: _confettiController,
                blastDirectionality: BlastDirectionality.explosive,
                shouldLoop: false,
                colors: const [
                  Colors.green,
                  Colors.blue,
                  Colors.pink,
                  Colors.orange
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
