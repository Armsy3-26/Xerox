import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WidgetController extends GetxController {
  Widget? currentWidget;

  //choose between
  //1.select file
  //2.selected file page
  //3.analysis page

  getWidget(Widget stringWidgets) {
    currentWidget = stringWidgets;

    update();
  }
}
