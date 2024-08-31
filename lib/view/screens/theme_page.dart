import 'package:database_quotes_app/view/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemePage extends StatelessWidget {
  const ThemePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Themes',style: TextStyle(fontSize: 23),),
      ),
      body: GridView.builder(
        gridDelegate:
        SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,childAspectRatio: 55/93),
        itemCount: quotes.themes.length,
        itemBuilder: (context, index) =>
            InkWell(
              onTap: () {
                quotes.theme(index);
                Get.to(() => HomePage(),
                    duration: Duration(milliseconds: 500),
                    transition: Transition.zoom);
              },
              child: Container(
                margin: (index%1==0)?EdgeInsets.only(top: 10,left: 5) : null,
                decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('${quotes.themes[index]}')
                    )
                ),
              ),
            ),
      ),
    );
  }
}
