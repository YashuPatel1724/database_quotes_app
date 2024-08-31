import 'dart:ui';

import 'package:database_quotes_app/Api%20Helper/api_helper.dart';
import 'package:database_quotes_app/Db%20Helper/db_helper.dart';
import 'package:database_quotes_app/modal/quotes_modal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../view/screens/home_page.dart';

class QuotesController extends GetxController {
  var allQuotes = <QuoteModal>[].obs;
  var categoryQuotes = [].obs;
  var pageIndex = 0.obs;
  RxList<QuoteModal> favouriteList = <QuoteModal>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initDb();
    readRecode();
  }

  Future<RxList> fromList() async {
    final data = await ApiHelper.apiHelper.fetchData();
    allQuotes.value = data.map((e) => QuoteModal.fromJson(e),).toList();
    return allQuotes;
  }

  void categoryWiseData(String category) {
    categoryQuotes.clear();
    categoryQuotes.refresh();
    for (var element in allQuotes) {
      if (element.category == category) {
        categoryQuotes.add(element);
      }
    }
    print(categoryQuotes);
    categoryQuotes.refresh();
  }

  void pageviewIndex(int value) {
    pageIndex.value = value;
  }

  List themes = [
    'assets/theme/AUTUMN LEAVES.jpg',
    'assets/theme/A Fogueira na Praia.jpg',
    'assets/theme/A água vindo do céu.jpg',
    'assets/theme/black🖤😊.jpg',
    'assets/theme/download.jpg',
    'assets/theme/Lifes Best_.jpg',
    'assets/theme/love1.jpg',
    'assets/theme/love2.jpg',
    'assets/theme/Free Bokeh Effect Light Blur Road Park Light Editing Background HD.jpg',
    'assets/theme/ce20ad78-ebdf-4067-bc58-a80f42f4f317.jpg',
    'assets/theme/love3.jpg',
    'assets/theme/6c20eca8-347b-4ceb-aae2-86aeb0280964.jpg',
    'assets/theme/motivatio1.jpg',
    'assets/theme/motivation.jpg',
    'assets/theme/motivation2.jpg',
    'assets/theme/motivation3.jpg',
    'assets/theme/motivation4.jpg',
    'assets/theme/Cute Little Friends holding heart on a street at night.jpg',
    'assets/theme/theme1.jpg',
    'assets/theme/theme3.jpg',
    'assets/theme/sundey.jpg',
    'assets/theme/theme4.jpg',
    'assets/theme/Photographer’s Love of Nature Inspires Him to Capture All the Glorious Ends of the Earth.jpg',
    'assets/theme/5c4a5bb0-9502-4838-9660-73c782b301a6.jpg',
    'assets/theme/302593bb-3b07-43ce-8b63-1463876fe532.jpg',
    'assets/theme/abc40898-2fe6-4548-a64a-767bd9589e12.jpg',
    'assets/theme/c498b2a8-a421-4532-a13c-e855dd88c816.jpg',
    'assets/theme/5b5e18e9-df7f-4a85-a4a0-db445d14d352.jpg',
    'assets/theme/8f4539b3-51ff-40c1-bde2-1f7fec5773c9.jpg',
    'assets/theme/679b4025-8b3f-45eb-a853-9ef4bc998835.jpg',
    'assets/theme/black moon wallpaper.jpg',
    'assets/theme/c33ced24-d381-4881-9076-460527c00e75.jpg',
    'assets/theme/c3898572-aa7e-4f8a-b207-0b0926f4f282.jpg',
    'assets/theme/Free Photo _ Full shot family members silhouettes outdoors.jpg',
    'assets/theme/James sent you a Pin!.jpg',
    'assets/theme/Premium Photo _ Yellow happy emoji character walking on a road.jpg',
  ];
  String img = 'assets/theme/black🖤😊.jpg';

  void theme(int index) {
    img = themes[index];
  }

  Rx<TextAlign> textAlign = TextAlign.center.obs;

  void alignText(TextAlign text) {
    textAlign.value = text;
  }

  RxList fontFamilyList = [
    'Dancing Script',
    'Josefin Sans',
    'Anton',
    'Exo 2',
    'Pacifico',
    'Lobster',
    'Imbue',
    'Crimson Text',
    'Prompt',
    'Varela Round',
    'Licorice',
    'Play',
    'IBM Plex Mono',
    'Caveat',
    'Chakra Petch',
    'Shadows Into Light',
    'Abril Fatface',
    'Satisfy',
    'Lilita One',
    'Galada',
    'Permanent Marker',
    'Indie Flower',
    'Edu NSW ACT Foundation',
    'Orbitron',
    'Cinzel',
  ].obs;
  RxString googleFont = 'Roboto'.obs;

  void fontFamily(int index) {
    googleFont.value = fontFamilyList[index];
  }

  RxList<Color> colorList = [
    Colors.blueAccent,
    Colors.lightGreen,
    Colors.amber,
    Colors.white,
    Colors.red,
    Colors.cyan,
    Colors.pink,
    Colors.lightBlue,
    Colors.deepPurple,
    Colors.grey,
    Colors.blue,
    Colors.yellowAccent,
    Colors.green,
    Colors.orange,
    Colors.teal,
    Colors.tealAccent,
  ].obs;
  Rx<Color> color = Colors.white.obs;

  void colorPick(int index) {
    color.value = colorList[index];
  }


  void initDb() {
    DbHelper.dbHelper.database;
  }

  Future<void> insertRecord(QuoteModal quote) async {
    await DbHelper.dbHelper.insertData(quote.quote, quote.author, quote.category, quote.isLiked);
    readRecode();
  }

  Future<void> readRecode() async {
    favouriteList.value = await DbHelper.dbHelper.readData();
  }

  int check = 0;

  void checkDoubleQuote(QuoteModal quote) {
    print('---------------------------enter--------------------');
    for (int i = 0; i < favouriteList.length; i++) {
      check = 0;
      if (quote.quote == favouriteList[i].quote) {
        check = 1;
        Get.snackbar(
            'Already Added!', 'The quote is already added to favourite!',
            snackPosition: SnackPosition.BOTTOM,
            colorText: CupertinoColors.white);
      }
    }
    if(check == 0)
    {
      print('----------------------------check 0-----------------------');
      // insertRecord(quote.quote, quote.author, quote.category, quote.isLiked);
      insertRecord(quote);
      check = 1;
    }
  }

  void like(int index)
  {
    allQuotes[index].isLiked = '1';
    allQuotes.refresh();
  }
  List<QuoteModal> getQuotesByCategory(String category) {
    return favouriteList.where((q) => q.category == category).toList();
  }

  Future<void> deleteQuote(int id)
  async {
    await DbHelper.dbHelper.deleteQuotes(id);
    readRecode();
  }

}