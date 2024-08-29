import 'package:database_quotes_app/controller/quotes_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

var quotes = Get.put(QuotesController());

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: quotes.fromList(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Stack(
              children: [
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  child: PageView.builder(
                    itemCount:  (quotes.categoryQuotes == null ||
                        quotes.categoryQuotes.isEmpty)
                        ? quotes.allQuotes.length
                        : quotes.categoryQuotes.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          (quotes.categoryQuotes == null ||
                                  quotes.categoryQuotes.isEmpty)
                              ? Text(
                                  textAlign: TextAlign.center,
                                  '${quotes.allQuotes[index].quote}',
                                  style: TextStyle(fontSize: 25),
                                )
                              : Text(
                                  textAlign: TextAlign.center,
                                  '${quotes.categoryQuotes[index].quote}',
                                  style: TextStyle(fontSize: 25),
                                ),
                          // Text('- ${quotes.allQuotes[index].author}')
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
