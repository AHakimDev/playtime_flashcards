import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../models/flashcard_model.dart';

class ListenMatchScreen extends StatefulWidget {
  final List<FlashcardModel> categoryCards;
  final String categoryTitle;

  const ListenMatchScreen({
    super.key,
    required this.categoryCards,
    required this.categoryTitle,
  });

  @override
  State<ListenMatchScreen> createState() => _ListenMatchScreenState();
}

class _ListenMatchScreenState extends State<ListenMatchScreen> {
  final FlutterTts _flutterTts = FlutterTts();
  final Random _random = Random();

  late FlashcardModel _targetCard;
  List<FlashcardModel> _currentOptions = [];

  bool _isLocked = false;
  int? _selectedIndex;
  bool _isCorrect = false;

  @override
  void initState() {
    super.initState();
    _initTts();
    _generateNewRound();
  }

  Future<void> _initTts() async {
    await _flutterTts.setLanguage("en-US");
    await _flutterTts.setSpeechRate(0.4);
    await _flutterTts.setPitch(1.0);
  }

  void _generateNewRound() {
    int optionsCount = min(4, widget.categoryCards.length);

    _targetCard =
        widget.categoryCards[_random.nextInt(widget.categoryCards.length)];

    Set<FlashcardModel> optionsSet = {_targetCard};
    while (optionsSet.length < optionsCount) {
      optionsSet.add(
        widget.categoryCards[_random.nextInt(widget.categoryCards.length)],
      );
    }

    _currentOptions = optionsSet.toList();
    _currentOptions.shuffle();

    setState(() {
      _isLocked = false;
      _selectedIndex = null;
    });

    // 🟢 اصلاح مهم: چک کردن mounted قبل از پخش صدا بعد از تاخیر
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) _playTargetWord();
    });
  }

  Future<void> _playTargetWord() async {
    await _flutterTts.stop();
    await _flutterTts.speak(_targetCard.word);
  }

  void _onCardTapped(int index) async {
    if (_isLocked) return;

    // 🟢 متوقف کردن صدای فعلی (اگر در حال پخش است) برای اجرای فوری بازخورد جدید
    await _flutterTts.stop();

    setState(() {
      _isLocked = true;
      _selectedIndex = index;
      _isCorrect = _currentOptions[index].word == _targetCard.word;
    });

    if (_isCorrect) {
      await _flutterTts.speak("Great!");
      Future.delayed(const Duration(milliseconds: 1500), () {
        if (mounted) _generateNewRound();
      });
    } else {
      await _flutterTts.speak(_targetCard.word);
      Future.delayed(const Duration(milliseconds: 1000), () {
        if (mounted) {
          setState(() {
            _isLocked = false;
            _selectedIndex = null;
          });
        }
      });
    }
  }

  @override
  void dispose() {
    _flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          _flutterTts.stop(); // 🟢 به محض خروج، هر صدایی متوقف شود
        }
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Directionality(
            textDirection: TextDirection.rtl,
            child: Text(
              'بازی: ${widget.categoryTitle}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.blueGrey),
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFE0F7FA), Color(0xFFFCE4EC)],
            ),
          ),
          child: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(
                  top: 40,
                  bottom: 24,
                ), // 🟢 افزایش فاصله از بالا
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: screenWidth > 800 ? 900 : 600,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // 🟢 نمایش کلمه هدف برای تقویت یادگیری بصری همزمان با صوتی
                      Text(
                        _targetCard.word,
                        style: const TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey,
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: _playTargetWord,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: 10.0,
                              sigmaY: 10.0,
                            ),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 30,
                                vertical: 20,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.5),
                                  width: 2,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Icon(
                                    Icons.volume_up_rounded,
                                    size: 32,
                                    color: Colors.blueGrey,
                                  ),
                                  SizedBox(width: 12),
                                  Text(
                                    'دوباره گوش کن',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blueGrey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: screenWidth > 700 ? 4 : 2,
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 16,
                                childAspectRatio: 0.9,
                              ),
                          itemCount: _currentOptions.length,
                          itemBuilder: (context, index) {
                            final option = _currentOptions[index];
                            final isSelected = _selectedIndex == index;
                            Color borderColor = Colors.transparent;
                            if (isSelected) {
                              borderColor = _isCorrect
                                  ? Colors.green
                                  : Colors.red;
                            }
                            return GestureDetector(
                              onTap: () => _onCardTapped(index),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(24),
                                  border: Border.all(
                                    color: borderColor,
                                    width: 4,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 10,
                                      offset: const Offset(0, 5),
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Image.asset(
                                      option.imageAssetPath,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
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
}
