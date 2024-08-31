import 'package:database_quotes_app/view/screens/category_page.dart';
import 'package:database_quotes_app/view/screens/favourite_page.dart';
import 'package:database_quotes_app/view/screens/home_page.dart';
import 'package:database_quotes_app/view/screens/theme_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main()
{
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => HomePage(),),
        GetPage(name: '/cate', page: () => CategoryPage(),),
        GetPage(name: '/theme', page: () => ThemePage(),),
        GetPage(name: '/fav', page: () => FavouritePage(),),
      ],
    );
  }
}