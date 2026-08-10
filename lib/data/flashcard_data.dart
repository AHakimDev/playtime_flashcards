import '../models/flashcard_model.dart';

final List<FlashcardModel> allFlashcards = [
  // ==================== LEVEL A ====================
  // میوه‌ها و خوراکی‌ها (Level A)
  const FlashcardModel(id: 'a1', level: BookLevel.levelA, category: CardCategory.fruits, imageAssetPath: 'assets/images/level_a/apple.webp', word: 'Apple', persianWord: 'سیب'),
  const FlashcardModel(id: 'a2', level: BookLevel.levelA, category: CardCategory.objects, imageAssetPath: 'assets/images/level_a/balloon.webp', word: 'Balloon', persianWord: 'بالون'),
  const FlashcardModel(id: 'a3', level: BookLevel.levelA, category: CardCategory.fruits, imageAssetPath: 'assets/images/level_a/banana.webp', word: 'Banana', persianWord: 'موز'),
  const FlashcardModel(id: 'a5', level: BookLevel.levelA, category: CardCategory.fruits, imageAssetPath: 'assets/images/level_a/cherries.webp', word: 'Cherries', persianWord: 'گیلاس'),
  const FlashcardModel(id: 'a6', level: BookLevel.levelA, category: CardCategory.fruits, imageAssetPath: 'assets/images/level_a/fruits.webp', word: 'Fruits', persianWord: 'میوه‌ها'),
  const FlashcardModel(id: 'a7', level: BookLevel.levelA, category: CardCategory.fruits, imageAssetPath: 'assets/images/level_a/orange.webp', word: 'Orange', persianWord: 'پرتقال'),
  const FlashcardModel(id: 'a8', level: BookLevel.levelA, category: CardCategory.fruits, imageAssetPath: 'assets/images/level_a/pear.webp', word: 'Pear', persianWord: 'گلابی'),
  const FlashcardModel(id: 'a9', level: BookLevel.levelA, category: CardCategory.fruits, imageAssetPath: 'assets/images/level_a/plum.webp', word: 'Plum', persianWord: 'آلو'),

  // افعال و حرکات (Level A)
  const FlashcardModel(id: 'a10', level: BookLevel.levelA, category: CardCategory.actions, imageAssetPath: 'assets/images/level_a/clap.webp', word: 'Clap', persianWord: 'دست زدن'),
  const FlashcardModel(id: 'a11', level: BookLevel.levelA, category: CardCategory.actions, imageAssetPath: 'assets/images/level_a/climb.webp', word: 'Climb', persianWord: 'بالا رفتن'),
  const FlashcardModel(id: 'a12', level: BookLevel.levelA, category: CardCategory.actions, imageAssetPath: 'assets/images/level_a/jump.webp', word: 'Jump', persianWord: 'پریدن'),
  const FlashcardModel(id: 'a13', level: BookLevel.levelA, category: CardCategory.actions, imageAssetPath: 'assets/images/level_a/play.webp', word: 'Play', persianWord: 'بازی کردن'),
  const FlashcardModel(id: 'a14', level: BookLevel.levelA, category: CardCategory.actions, imageAssetPath: 'assets/images/level_a/run.webp', word: 'Run', persianWord: 'دویدن'),

  // رنگ‌ها (Level A)
  const FlashcardModel(id: 'a15', level: BookLevel.levelA, category: CardCategory.colors, imageAssetPath: 'assets/images/level_a/colour_blue.webp', word: 'Blue', persianWord: 'آبی'),
  const FlashcardModel(id: 'a16', level: BookLevel.levelA, category: CardCategory.colors, imageAssetPath: 'assets/images/level_a/colour_green.webp', word: 'Green', persianWord: 'سبز'),
  const FlashcardModel(id: 'a17', level: BookLevel.levelA, category: CardCategory.colors, imageAssetPath: 'assets/images/level_a/colour_orange.webp', word: 'Orange', persianWord: 'نارنجی'),
  const FlashcardModel(id: 'a18', level: BookLevel.levelA, category: CardCategory.colors, imageAssetPath: 'assets/images/level_a/colour_purple.webp', word: 'Purple', persianWord: 'بنفش'),
  const FlashcardModel(id: 'a19', level: BookLevel.levelA, category: CardCategory.colors, imageAssetPath: 'assets/images/level_a/colour_red.webp', word: 'Red', persianWord: 'قرمز'),
  const FlashcardModel(id: 'a20', level: BookLevel.levelA, category: CardCategory.colors, imageAssetPath: 'assets/images/level_a/colour_yellow.webp', word: 'Yellow', persianWord: 'زرد'),

  // حیوانات و مزرعه (Level A)
  const FlashcardModel(id: 'a21', level: BookLevel.levelA, category: CardCategory.animals, imageAssetPath: 'assets/images/level_a/cow.webp', word: 'Cow', persianWord: 'گاو'),
  const FlashcardModel(id: 'a22', level: BookLevel.levelA, category: CardCategory.animals, imageAssetPath: 'assets/images/level_a/duck.webp', word: 'Duck', persianWord: 'اردک'),
  const FlashcardModel(id: 'a23', level: BookLevel.levelA, category: CardCategory.animals, imageAssetPath: 'assets/images/level_a/hen.webp', word: 'Hen', persianWord: 'مرغ'),
  const FlashcardModel(id: 'a24', level: BookLevel.levelA, category: CardCategory.animals, imageAssetPath: 'assets/images/level_a/horse.webp', word: 'Horse', persianWord: 'اسب'),
  const FlashcardModel(id: 'a25', level: BookLevel.levelA, category: CardCategory.animals, imageAssetPath: 'assets/images/level_a/sheep.webp', word: 'Sheep', persianWord: 'گوسفند'),
  const FlashcardModel(id: 'a26', level: BookLevel.levelA, category: CardCategory.objects, imageAssetPath: 'assets/images/level_a/farm.webp', word: 'Farm', persianWord: 'مزرعه'),
  const FlashcardModel(id: 'a27', level: BookLevel.levelA, category: CardCategory.objects, imageAssetPath: 'assets/images/level_a/farmer.webp', word: 'Farmer', persianWord: 'کشاورز'),

  // لباس‌ها (Level A)
  const FlashcardModel(id: 'a28', level: BookLevel.levelA, category: CardCategory.clothes, imageAssetPath: 'assets/images/level_a/dress.webp', word: 'Dress', persianWord: 'لباس'),
  const FlashcardModel(id: 'a29', level: BookLevel.levelA, category: CardCategory.clothes, imageAssetPath: 'assets/images/level_a/hat.webp', word: 'Hat', persianWord: 'کلاه'),
  const FlashcardModel(id: 'a30', level: BookLevel.levelA, category: CardCategory.clothes, imageAssetPath: 'assets/images/level_a/shoes.webp', word: 'Shoes', persianWord: 'کفش'),
  const FlashcardModel(id: 'a31', level: BookLevel.levelA, category: CardCategory.clothes, imageAssetPath: 'assets/images/level_a/socks.webp', word: 'Socks', persianWord: 'جوراب'),
  const FlashcardModel(id: 'a32', level: BookLevel.levelA, category: CardCategory.clothes, imageAssetPath: 'assets/images/level_a/trouses.webp', word: 'Trousers', persianWord: 'شلوار'),
  const FlashcardModel(id: 'a33', level: BookLevel.levelA, category: CardCategory.clothes, imageAssetPath: 'assets/images/level_a/t-shirt.webp', word: 'T-shirt', persianWord: 'تی‌شرت'),

  // اعضای بدن (Level A)
  const FlashcardModel(id: 'a34', level: BookLevel.levelA, category: CardCategory.bodyParts, imageAssetPath: 'assets/images/level_a/ears.webp', word: 'Ears', persianWord: 'گوش'),
  const FlashcardModel(id: 'a35', level: BookLevel.levelA, category: CardCategory.bodyParts, imageAssetPath: 'assets/images/level_a/eyes.webp', word: 'Eyes', persianWord: 'چشم'),
  const FlashcardModel(id: 'a36', level: BookLevel.levelA, category: CardCategory.bodyParts, imageAssetPath: 'assets/images/level_a/face.webp', word: 'Face', persianWord: 'صورت'),
  const FlashcardModel(id: 'a37', level: BookLevel.levelA, category: CardCategory.bodyParts, imageAssetPath: 'assets/images/level_a/hair.webp', word: 'Hair', persianWord: 'مو'),
  const FlashcardModel(id: 'a38', level: BookLevel.levelA, category: CardCategory.bodyParts, imageAssetPath: 'assets/images/level_a/mouth.webp', word: 'Mouth', persianWord: 'دهان'),
  const FlashcardModel(id: 'a39', level: BookLevel.levelA, category: CardCategory.bodyParts, imageAssetPath: 'assets/images/level_a/nose.webp', word: 'Nose', persianWord: 'بینی'),

  // اعداد (Level A)
  const FlashcardModel(id: 'a40', level: BookLevel.levelA, category: CardCategory.numbers, imageAssetPath: 'assets/images/level_a/number_01.webp', word: 'One', persianWord: 'یک'),
  const FlashcardModel(id: 'a41', level: BookLevel.levelA, category: CardCategory.numbers, imageAssetPath: 'assets/images/level_a/number_02.webp', word: 'Two', persianWord: 'دو'),
  const FlashcardModel(id: 'a42', level: BookLevel.levelA, category: CardCategory.numbers, imageAssetPath: 'assets/images/level_a/number_03.webp', word: 'Three', persianWord: 'سه'),
  const FlashcardModel(id: 'a43', level: BookLevel.levelA, category: CardCategory.numbers, imageAssetPath: 'assets/images/level_a/number_04.webp', word: 'Four', persianWord: 'چهار'),
  const FlashcardModel(id: 'a44', level: BookLevel.levelA, category: CardCategory.numbers, imageAssetPath: 'assets/images/level_a/number_05.webp', word: 'Five', persianWord: 'پنج'),
  const FlashcardModel(id: 'a45', level: BookLevel.levelA, category: CardCategory.numbers, imageAssetPath: 'assets/images/level_a/number_06.webp', word: 'Six', persianWord: 'شش'),

  // اشیا و متفرقه (Level A)
  const FlashcardModel(id: 'a46', level: BookLevel.levelA, category: CardCategory.objects, imageAssetPath: 'assets/images/level_a/melody.webp', word: 'Melody', persianWord: 'ملودی'),
  const FlashcardModel(id: 'a47', level: BookLevel.levelA, category: CardCategory.objects, imageAssetPath: 'assets/images/level_a/present.webp', word: 'Present', persianWord: 'هدیه'),
  const FlashcardModel(id: 'a48', level: BookLevel.levelA, category: CardCategory.objects, imageAssetPath: 'assets/images/level_a/rocket.webp', word: 'Rocket', persianWord: 'راکت'),
  const FlashcardModel(id: 'a49', level: BookLevel.levelA, category: CardCategory.objects, imageAssetPath: 'assets/images/level_a/slide.webp', word: 'Slide', persianWord: 'سرسره'),
  const FlashcardModel(id: 'a50', level: BookLevel.levelA, category: CardCategory.objects, imageAssetPath: 'assets/images/level_a/star.webp', word: 'Star', persianWord: 'استار'),
  const FlashcardModel(id: 'a51', level: BookLevel.levelA, category: CardCategory.objects, imageAssetPath: 'assets/images/level_a/twig.webp', word: 'Twig', persianWord: 'توئگ'),

  // ==================== LEVEL B ====================
  // اعضای بدن و جوارح (Level B)
  const FlashcardModel(id: 'b1', level: BookLevel.levelB, category: CardCategory.bodyParts, imageAssetPath: 'assets/images/level_b/arms.webp', word: 'Arms', persianWord: 'بازوها'),
  const FlashcardModel(id: 'b2', level: BookLevel.levelB, category: CardCategory.bodyParts, imageAssetPath: 'assets/images/level_b/body.webp', word: 'Body', persianWord: 'بدن'),
  const FlashcardModel(id: 'b3', level: BookLevel.levelB, category: CardCategory.bodyParts, imageAssetPath: 'assets/images/level_b/feet.webp', word: 'Feet', persianWord: 'پاها'),
  const FlashcardModel(id: 'b4', level: BookLevel.levelB, category: CardCategory.bodyParts, imageAssetPath: 'assets/images/level_b/hands.webp', word: 'Hands', persianWord: 'دست‌ها'),
  const FlashcardModel(id: 'b5', level: BookLevel.levelB, category: CardCategory.bodyParts, imageAssetPath: 'assets/images/level_b/head.webp', word: 'Head', persianWord: 'سر'),
  const FlashcardModel(id: 'b6', level: BookLevel.levelB, category: CardCategory.bodyParts, imageAssetPath: 'assets/images/level_b/legs.webp', word: 'Legs', persianWord: 'پاها'),

  // خانواده (Level B)
  const FlashcardModel(id: 'b7', level: BookLevel.levelB, category: CardCategory.family, imageAssetPath: 'assets/images/level_b/brother.webp', word: 'Brother', persianWord: 'برادر'),
  const FlashcardModel(id: 'b8', level: BookLevel.levelB, category: CardCategory.family, imageAssetPath: 'assets/images/level_b/daddy.webp', word: 'Daddy', persianWord: 'پدر'),
  const FlashcardModel(id: 'b9', level: BookLevel.levelB, category: CardCategory.family, imageAssetPath: 'assets/images/level_b/family.webp', word: 'Family', persianWord: 'خانواده'),
  const FlashcardModel(id: 'b10', level: BookLevel.levelB, category: CardCategory.family, imageAssetPath: 'assets/images/level_b/grandad.webp', word: 'Grandad', persianWord: 'پدربزرگ'),
  const FlashcardModel(id: 'b11', level: BookLevel.levelB, category: CardCategory.family, imageAssetPath: 'assets/images/level_b/grandy.webp', word: 'Grandy', persianWord: 'مادربزرگ'),
  const FlashcardModel(id: 'b12', level: BookLevel.levelB, category: CardCategory.family, imageAssetPath: 'assets/images/level_b/mummy.webp', word: 'Mummy', persianWord: 'مادر'),
  const FlashcardModel(id: 'b13', level: BookLevel.levelB, category: CardCategory.family, imageAssetPath: 'assets/images/level_b/sister.webp', word: 'Sister', persianWord: 'خواهر'),

  // حیوانات (Level B)
  const FlashcardModel(id: 'b14', level: BookLevel.levelB, category: CardCategory.animals, imageAssetPath: 'assets/images/level_b/bird.webp', word: 'Bird', persianWord: 'پرنده'),
  const FlashcardModel(id: 'b15', level: BookLevel.levelB, category: CardCategory.animals, imageAssetPath: 'assets/images/level_b/elephant.webp', word: 'Elephant', persianWord: 'فیل'),
  const FlashcardModel(id: 'b16', level: BookLevel.levelB, category: CardCategory.animals, imageAssetPath: 'assets/images/level_b/giraffe.webp', word: 'Giraffe', persianWord: 'زرافه'),
  const FlashcardModel(id: 'b17', level: BookLevel.levelB, category: CardCategory.animals, imageAssetPath: 'assets/images/level_b/snake.webp', word: 'Snake', persianWord: 'مار'),
  const FlashcardModel(id: 'b18', level: BookLevel.levelB, category: CardCategory.animals, imageAssetPath: 'assets/images/level_b/tiger.webp', word: 'Tiger', persianWord: 'ببر'),
  const FlashcardModel(id: 'b19', level: BookLevel.levelB, category: CardCategory.animals, imageAssetPath: 'assets/images/level_b/zebra.webp', word: 'Zebra', persianWord: 'گورخر'),

  // رنگ‌ها (Level B)
  const FlashcardModel(id: 'b20', level: BookLevel.levelB, category: CardCategory.colors, imageAssetPath: 'assets/images/level_b/colour_black.webp', word: 'Black', persianWord: 'مشکی'),
  const FlashcardModel(id: 'b21', level: BookLevel.levelB, category: CardCategory.colors, imageAssetPath: 'assets/images/level_b/colour_brown.webp', word: 'Brown', persianWord: 'قهوه‌ای'),
  const FlashcardModel(id: 'b22', level: BookLevel.levelB, category: CardCategory.colors, imageAssetPath: 'assets/images/level_b/colour_pink.webp', word: 'Pink', persianWord: 'صورتی'),
  const FlashcardModel(id: 'b23', level: BookLevel.levelB, category: CardCategory.colors, imageAssetPath: 'assets/images/level_b/colour_white.webp', word: 'White', persianWord: 'سفید'),

  // اعداد (Level B)
  const FlashcardModel(id: 'b24', level: BookLevel.levelB, category: CardCategory.numbers, imageAssetPath: 'assets/images/level_b/number_07.webp', word: 'Seven', persianWord: 'هفت'),
  const FlashcardModel(id: 'b25', level: BookLevel.levelB, category: CardCategory.numbers, imageAssetPath: 'assets/images/level_b/number_08.webp', word: 'Eight', persianWord: 'هشت'),
  const FlashcardModel(id: 'b26', level: BookLevel.levelB, category: CardCategory.numbers, imageAssetPath: 'assets/images/level_b/number_09.webp', word: 'Nine', persianWord: 'نه'),
  const FlashcardModel(id: 'b27', level: BookLevel.levelB, category: CardCategory.numbers, imageAssetPath: 'assets/images/level_b/number_10.webp', word: 'Ten', persianWord: 'ده'),

  // خوراکی‌ها و اشیا (Level B)
  const FlashcardModel(id: 'b28', level: BookLevel.levelB, category: CardCategory.fruits, imageAssetPath: 'assets/images/level_b/biscuits.webp', word: 'Biscuits', persianWord: 'بیسکویت'),
  const FlashcardModel(id: 'b29', level: BookLevel.levelB, category: CardCategory.fruits, imageAssetPath: 'assets/images/level_b/cheese.webp', word: 'Cheese', persianWord: 'پنیر'),
  const FlashcardModel(id: 'b30', level: BookLevel.levelB, category: CardCategory.fruits, imageAssetPath: 'assets/images/level_b/juice.webp', word: 'Juice', persianWord: 'آبمیوه'),
  const FlashcardModel(id: 'b31', level: BookLevel.levelB, category: CardCategory.fruits, imageAssetPath: 'assets/images/level_b/nuts.webp', word: 'Nuts', persianWord: 'آجیل / مغزها'),
  const FlashcardModel(id: 'b32', level: BookLevel.levelB, category: CardCategory.fruits, imageAssetPath: 'assets/images/level_b/sandwitches.webp', word: 'Sandwiches', persianWord: 'ساندویچ‌ها'),
  const FlashcardModel(id: 'b33', level: BookLevel.levelB, category: CardCategory.fruits, imageAssetPath: 'assets/images/level_b/tomatoes.webp', word: 'Tomatoes', persianWord: 'گوجه‌ها'),

  // اسباب‌بازی‌ها و اشیا (Level B)
  const FlashcardModel(id: 'b34', level: BookLevel.levelB, category: CardCategory.objects, imageAssetPath: 'assets/images/level_b/ball.webp', word: 'Ball', persianWord: 'توپ'),
  const FlashcardModel(id: 'b35', level: BookLevel.levelB, category: CardCategory.objects, imageAssetPath: 'assets/images/level_b/car.webp', word: 'Car', persianWord: 'ماشین'),
  const FlashcardModel(id: 'b36', level: BookLevel.levelB, category: CardCategory.objects, imageAssetPath: 'assets/images/level_b/doll.webp', word: 'Doll', persianWord: 'عروسک'),
  const FlashcardModel(id: 'b37', level: BookLevel.levelB, category: CardCategory.objects, imageAssetPath: 'assets/images/level_b/drum.webp', word: 'Drum', persianWord: 'طبل'),
  const FlashcardModel(id: 'b38', level: BookLevel.levelB, category: CardCategory.objects, imageAssetPath: 'assets/images/level_b/guitar.webp', word: 'Guitar', persianWord: 'گیتار'),
  const FlashcardModel(id: 'b39', level: BookLevel.levelB, category: CardCategory.objects, imageAssetPath: 'assets/images/level_b/piano.webp', word: 'Piano', persianWord: 'پیانو'),
  const FlashcardModel(id: 'b40', level: BookLevel.levelB, category: CardCategory.objects, imageAssetPath: 'assets/images/level_b/robot.webp', word: 'Robot', persianWord: 'ربات'),
  const FlashcardModel(id: 'b41', level: BookLevel.levelB, category: CardCategory.objects, imageAssetPath: 'assets/images/level_b/shaker.webp', word: 'Shaker', persianWord: 'ساز شیکر'),
  const FlashcardModel(id: 'b42', level: BookLevel.levelB, category: CardCategory.objects, imageAssetPath: 'assets/images/level_b/teddy_bear.webp', word: 'Teddy Bear', persianWord: 'خرس عروسکی'),
  const FlashcardModel(id: 'b43', level: BookLevel.levelB, category: CardCategory.objects, imageAssetPath: 'assets/images/level_b/toys.webp', word: 'Toys', persianWord: 'اسباب‌بازی‌ها'),
  const FlashcardModel(id: 'b44', level: BookLevel.levelB, category: CardCategory.objects, imageAssetPath: 'assets/images/level_b/train.webp', word: 'Train', persianWord: 'قطار'),
  const FlashcardModel(id: 'b45', level: BookLevel.levelB, category: CardCategory.objects, imageAssetPath: 'assets/images/level_b/triandle.webp', word: 'Triangle', persianWord: 'سه‌تار / مثلث صوتی'),
  const FlashcardModel(id: 'b46', level: BookLevel.levelB, category: CardCategory.objects, imageAssetPath: 'assets/images/level_b/trumpet.webp', word: 'Trumpet', persianWord: 'ترومپت'),
  const FlashcardModel(id: 'b47', level: BookLevel.levelB, category: CardCategory.objects, imageAssetPath: 'assets/images/level_b/yo-yo.webp', word: 'Yo-yo', persianWord: 'یویو'),
  const FlashcardModel(id: 'b48', level: BookLevel.levelB, category: CardCategory.fruits, imageAssetPath: 'assets/images/level_b/cake.webp', word: 'Cake', persianWord: 'کیک'),
];