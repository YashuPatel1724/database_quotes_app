import 'package:database_quotes_app/view/screens/category_page.dart';
import 'package:database_quotes_app/view/screens/home_page.dart';
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
      initialRoute: '/cate',
      getPages: [
        GetPage(name: '/', page: () => HomePage(),),
        GetPage(name: '/cate', page: () => CategoryPage(),),
      ],
    );
  }
}