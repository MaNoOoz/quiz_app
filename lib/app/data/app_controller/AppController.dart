import 'dart:math';

import 'package:get/get.dart';

class AppController extends GetxController {
  var id = Random().nextInt(500);
  var score = 0;
  var userName = "".obs;
}
