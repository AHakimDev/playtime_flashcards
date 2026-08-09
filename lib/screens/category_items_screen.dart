import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // 🟢 اضافه شده
import '../models/flashcard_model.dart';
import '../data/flashcard_data.dart';
import 'fullscreen_card_screen.dart';

class CategoryItemsScreen extends StatelessWidget {
  final BookLevel selectedLevel;
  final CardCategory category;
  final String categoryTitle;

  const CategoryItemsScreen({
    super.key,
    required this.selectedLevel,
    required this.category,
    required this.categoryTitle,
  });

  @override
  Widget build(BuildContext context) {
    final categoryCards = allFlashcards
        .where((card) => card.level == selectedLevel && card.category == category)
        .toList();

    final screenWidth = MediaQuery.of(context).size.width;
    final double maxWidth = kIsWeb ? screenWidth * 0.85 : double.infinity;

    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark, // 🟢 تنظیم نوار وضعیت
        title: Text(
          categoryTitle,
          style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.blueGrey),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.blueGrey),
      ),
      body: SafeArea( // 🟢 جلوگیری از تداخل محتوا
        child: categoryCards.isEmpty
            ? const Center(
          child: Text(
            "کارتی در این دسته وجود ندارد",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.blueGrey),
          ),
        )
            : Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: GridView.builder(
              padding: const EdgeInsets.all(20.0),
              physics: const BouncingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: screenWidth > 900 ? 5 : (screenWidth > 600 ? 4 : 2),
                crossAxisSpacing: 18.0,
                mainAxisSpacing: 18.0,
                childAspectRatio: 0.9,
              ),
              itemCount: categoryCards.length,
              itemBuilder: (context, index) {
                final card = categoryCards[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FullscreenCardScreen(
                          cards: categoryCards,
                          initialIndex: index,
                          categoryTitle: categoryTitle,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: Colors.orangeAccent.withOpacity(0.4), width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Image.asset(
                              card.imageAssetPath,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}