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
              buildCard('Love',quotes),
              buildCard('Affirmation',quotes),
              buildCard('Motivation',quotes),
              buildCard('Deep',quotes),
              buildCard('Positive',quotes),
              buildCard('Mental Health',quotes),
              buildCard('Discipline',quotes),
              buildCard('Broken',quotes),
              buildCard('Self Esteem',quotes),
              buildCard('Success',quotes),
              buildCard('Friendship',quotes),
              buildCard('Loyalty',quotes),
              buildCard('Kindness',quotes),
              buildCard('Funny',quotes),
              buildCard('Happy',quotes),
              buildCard('Sad',quotes),
              buildCard('Hope',quotes),
              buildCard('Gratitude',quotes),
              buildCard('Ego',quotes),
              buildCard('Patience',quotes),
            ],
          ),
        )
    );
  }

  Widget buildCard(String name
      ,QuotesController quotes) {
    return GestureDetector(
      onTap: () {
        quotes.categoryWiseData(name);
        Get.toNamed('/');
      },
      child: Card(
        margin: EdgeInsets.only(top: 15),
          child: ListTile(
            title: Text(textAlign: TextAlign.center,'$name',style: TextStyle(fontSize: 20),),
            leading: Icon(Icons.format_quote),
            trailing: Icon(Icons.chevron_right),
          ),
        ),
    );
  }
}
