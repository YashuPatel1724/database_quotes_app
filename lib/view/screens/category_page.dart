import 'package:database_quotes_app/controller/quotes_controller.dart';
import 'package:database_quotes_app/view/screens/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Category', style: TextStyle(fontSize: 22, letterSpacing: 1),),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              buildCard('Love'),
              buildCard('Affirmation'),
              buildCard('Motivation'),
              buildCard('Deep'),
              buildCard('Positive'),
              buildCard('Mental Health'),
              buildCard('Discipline'),
              buildCard('Broken'),
              buildCard('Self Esteem'),
              buildCard('Success'),
              buildCard('Friendship'),
              buildCard('Loyalty'),
              buildCard('Kindness'),
              buildCard('Funny'),
              buildCard('Happy'),
              buildCard('Sad'),
              buildCard('Hope'),
              buildCard('Gratitude'),
              buildCard('Ego'),
              buildCard('Patience'),
            ],
          ),
        )
    );
  }

  Widget buildCard(String name) {
    return GestureDetector(
      onTap: () {
        quotes.categoryWiseData(name);
        Get.toNamed('/');
      },
      child: Card(
        margin: EdgeInsets.only(top: 15),
          child: ListTile(
            title: Text(textAlign: TextAlign.center,'$name',style: TextStyle(fontSize: 20),),
            leading: Icon(Icons.format_quote_rounded),
            trailing: Icon(Icons.chevron_right),
          ),
        ),
    );
  }
}
