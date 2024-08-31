import 'dart:convert';
import 'package:database_quotes_app/modal/quotes_modal.dart';
import 'package:http/http.dart' as http;
import 'package:http/src/response.dart';
import 'package:http/http.dart';

class ApiHelper
{
  static ApiHelper apiHelper = ApiHelper._();
  ApiHelper._();
  Future<List> fetchData()
  async {
    String apiData = 'https://sheetdb.io/api/v1/w8h8e0bz8dzpv';
    Uri uri = Uri.parse(apiData);
    Response response = await http.get(uri);

    if(response.statusCode == 200)
      {
        final json = response.body;
        final List data =jsonDecode(json);
        return data;
      }
    else
      {
        return [];
      }
  }
}