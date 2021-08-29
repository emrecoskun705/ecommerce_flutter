import 'package:ecommerce_flutter/services/carousel_api.dart';
import 'package:flutter/cupertino.dart';

class CarouselProvider extends ChangeNotifier {
  List<String> imageURLs = [];
  bool isLoading = true;

  Future fetchImageURLs() async {
    setIsLoading(true);
    setImgURLList(await CarouselApi().fetchData());
    setIsLoading(false);
  }

  void setImgURLList(List<String> imageURLs) {
    this.imageURLs = imageURLs;
    notifyListeners();
  }

  void setIsLoading(bool value) {
    this.isLoading = value;
    notifyListeners();
  }
}
