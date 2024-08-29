import 'package:database_quotes_app/Api%20Helper/api_helper.dart';
import 'package:database_quotes_app/modal/quotes_modal.dart';
import 'package:get/get.dart';

import '../view/screens/home_page.dart';

class QuotesController extends GetxController {
  var allQuotes = <QuoteModal>[].obs;
  var categoryQuotes = [].obs;

  Future<RxList> fromList()
  async {
    final data = await ApiHelper.apiHelper.fetchData();
    allQuotes.value = data.map((e) => QuoteModal.fromJson(e),).toList();
    return allQuotes;
  }

  void categoryWiseData(String category)
  {
    categoryQuotes.clear();
    categoryQuotes.refresh();
    for(var element in allQuotes)
      {
          if(element.category == category)
            {
              categoryQuotes.add(element);
            }
      }
    categoryQuotes.refresh();
  }
}