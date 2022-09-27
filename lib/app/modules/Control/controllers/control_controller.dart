import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ControlController extends GetxController {
  final _currentIndex = 0.obs;
  final _inactiveColor = Colors.grey;

  get currentIndex => _currentIndex.value;

  void changePage(int index) {
    // Logger().d('$index');
    _currentIndex.value = index;
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  get inactiveColor => _inactiveColor;
}
