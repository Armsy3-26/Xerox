import 'package:get/get.dart';

class WidgetController extends GetxController {
  bool isSearching = true;

  getSearchingStatus(bool status) {
    isSearching = status;

    update();
  }
}
