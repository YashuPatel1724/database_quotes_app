import 'package:database_quotes_app/view/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../modal/quotes_modal.dart';

class FavouritePage extends StatelessWidget {
  const FavouritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourite Quotes'),
      ),
      body: Obx(
        () {
          // Group quotes by category
          Map<String, List<QuoteModal>> categorizedQuotes = {};
          for (var quote in quotes.favouriteList) {
            if (!categorizedQuotes.containsKey(quote.category)) {
              categorizedQuotes[quote.category] = [];
            }
            categorizedQuotes[quote.category]!.add(quote);
          }

          // Display categories and their quotes
          // return ListView(
          //   children: categorizedQuotes.entries.map((entry) {
          //     return ExpansionTile(
          //       title: Text(entry.key), // Category name
          //       children: entry.value.map((quote) {
          //         return ListTile(
          //           title: Text(quote.quote),
          //           subtitle: Text(quote.author),
          //         );
          //       }).toList(),
          //     );
          //   }).toList(),
          // );
          return ListView.builder(
            itemCount: categorizedQuotes.keys.length,
            itemBuilder: (context, index) {
              String category = categorizedQuotes.keys.elementAt(index);
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 10,
                  shadowColor: Colors.black38,
                  color: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: ExpansionTile(
                      collapsedBackgroundColor: Colors.white,
                      leading: Icon(Icons.format_quote_rounded),
                      title: Text(
                        textAlign: TextAlign.center,
                        category,
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                      children: categorizedQuotes[category]!.map((quote) {
                        return Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 4.0),
                          padding: const EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                              quote.quote,
                              style: TextStyle(fontSize: 16,),
                            ),
                            subtitle: Text('- ${quote.author}',style: TextStyle(fontWeight: FontWeight.w600),),
                            trailing: IconButton(onPressed: () {
                              quotes.deleteQuote(quote.id!);
                            },icon: Icon(Icons.delete),),
                          ),
                        );
                      },).toList(),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
