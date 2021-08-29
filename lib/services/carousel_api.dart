import 'package:http/http.dart' as http;
import 'dart:convert';

import '../constants.dart';

class CarouselApi {
  Future<List<String>> fetchData() async {
    var url = Uri.parse('$kServerApiURL/carousel/');
    http.Response response = await http.get(url);

    List<String> carouselList = [];

    if (response.statusCode == 200) {
      dynamic data = jsonDecode(response.body);
      for (var img in data) {
        carouselList.add(img['image']);
      }
    }

    return carouselList;
  }
}
