import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // 🟢 اضافه شده
import '../models/flashcard_model.dart';
import '../data/flashcard_data.dart';
import 'category_items_screen.dart';

class HomeScreen extends StatelessWidget {
  final BookLevel selectedLevel;
  final String bookTitle;

  const HomeScreen({
    super.key,
    required this.selectedLevel,
    required this.bookTitle,
  });

  Map<String, dynamic> _getCategoryDetails(CardCategory category) {
    switch (category) {
      case CardCategory.fruits:
        return {'title': 'Fruits & Food', 'color': Colors.green, 'icon': '🍎'};
      case CardCategory.actions:
        return {'title': 'Actions', 'color': Colors.orange, 'icon': '🏃'};
      case CardCategory.colors:
        return {'title': 'Colors', 'color': Colors.purple, 'icon': '🎨'};
      case CardCategory.animals:
        return {'title': 'Animals', 'color': Colors.brown, 'icon': '🐄'};
      case CardCategory.clothes:
        return {'title': 'Clothes', 'color': Colors.pink, 'icon': '👕'};
      case CardCategory.bodyParts:
        return {'title': 'Body Parts', 'color': Colors.redAccent, 'icon': '👀'};
      case CardCategory.numbers:
        return {'title': 'Numbers', 'color': Colors.blue, 'icon': '🔢'};
      case CardCategory.objects:
        return {'title': 'Objects & Toys', 'color': Colors.teal, 'icon': '🧸'};
      case CardCategory.family:
        return {'title': 'Family', 'color': Colors.indigo, 'icon': '👨‍👩‍👧‍👦'};
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableCategories = CardCategory.values.where((cat) {
      return allFlashcards.any((card) => card.level == selectedLevel && card.category == cat);
    }).toList();

    final screenWidth = MediaQuery.of(context).size.width;
    final double maxWidth = kIsWeb ? screenWidth * 0.85 : double.infinity;

    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark, // 🟢 اجبار به آیکون‌های تیره در استاتوس‌بار
        title: Text(
          bookTitle,
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.blueGrey),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.blueGrey),
      ),
      body: SafeArea( // 🟢 جلوگیری از تداخل محتوا با لبه‌های گوشی
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: GridView.builder(
              padding: const EdgeInsets.all(20.0),
              physics: const BouncingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: screenWidth > 900 ? 4 : (screenWidth > 600 ? 3 : 2),
                crossAxisSpacing: 20.0,
                mainAxisSpacing: 20.0,
                childAspectRatio: screenWidth > 600 ? 1.25 : 1.05,
              ),
              itemCount: availableCategories.length,
              itemBuilder: (context, index) {
                final category = availableCategories[index];
                final details = _getCategoryDetails(category);
                final Color baseColor = details['color'];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CategoryItemsScreen(
                          selectedLevel: selectedLevel,
                          category: category,
                          categoryTitle: details['title'],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          baseColor.withOpacity(0.15),
                          baseColor.withOpacity(0.35),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(28),
                      border: Border.all(color: baseColor, width: 3),
                      boxShadow: [
                        BoxShadow(
                          color: baseColor.withOpacity(0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.7),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: baseColor.withOpacity(0.15),
                                blurRadius: 6,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Text(
                            details['icon'],
                            style: const TextStyle(fontSize: 42),
                          ),
                        ),
                        const SizedBox(height: 14),
                        Text(
                          details['title'],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: baseColor.withBlue(baseColor.blue - 30 > 0 ? baseColor.blue - 30 : 0),
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