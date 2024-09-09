import 'package:get/get.dart';

class Engine2WidgetController extends GetxController {
  bool engine2IsSearching = true;
  // Widget setEngine2Screen = const Engine2SearchAnimation();

  getEngine2SearchingStatus(bool status) {
    engine2IsSearching = status;

    update();
  }

  // setEngine2Widget(Widget nextScreen) {
  //   setEngine2Screen = nextScreen;
  //   update();
  // }
}
