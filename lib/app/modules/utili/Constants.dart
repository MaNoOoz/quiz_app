import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Control/views/control_view.dart';

// API =================================================================================================
const BASE_URL = "https://quizu.okoul.com/";

enum LoadingStatus { loading, completed, error, noReult }

// STYLE =================================================================================================
InputDecoration textFieldDecorationCircle({String? hint, String? lable, Icon? icon, TextStyle? style}) {
  style = mainTitleBlack;
  return InputDecoration(
    // prefixIcon: icon,
//      prefixIcon: icon,
//     icon: icon,
    suffixIcon: icon,
    hintTextDirection: TextDirection.rtl,
    floatingLabelBehavior: FloatingLabelBehavior.never,
    contentPadding: EdgeInsets.all(10),
    hintText: hint,
    labelText: lable,
    hintStyle: style,
    labelStyle: style,
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blue),
      borderRadius: BorderRadius.all(Radius.circular(5)),
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey),
      borderRadius: BorderRadius.all(Radius.circular(5)),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey),
      borderRadius: BorderRadius.all(Radius.circular(5)),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.redAccent),
      borderRadius: BorderRadius.all(Radius.circular(5)),
    ),
  );
}

const TextStyle mainTitleBlack = TextStyle(
  fontFamily: "DG Sahabah Bold",
  fontSize: 34,
  color: Colors.black87,
  fontWeight: FontWeight.w500,
  letterSpacing: 1,
  shadows: [
    // Shadow(color: Colors.black45, blurRadius: 1, offset: Offset(-0.5, 2)),
  ],
  wordSpacing: 0.5,
);
const TextStyle mainTitleBlackTHIN = TextStyle(
  fontFamily: "DG Sahabah Bold",
  fontSize: 34,
  color: Colors.black54,
  fontWeight: FontWeight.w100,
  letterSpacing: 1,
  shadows: [
    // Shadow(color: Colors.black45, blurRadius: 1, offset: Offset(-0.5, 2)),
  ],
  wordSpacing: 0.5,
);
const TextStyle mainTitleBlue = TextStyle(
  fontFamily: "DG Sahabah Bold",
  fontSize: 34,
  color: Colors.blue,
  fontWeight: FontWeight.w500,
  letterSpacing: 1,
  shadows: [
    // Shadow(color: Colors.black45, blurRadius: 1, offset: Offset(-0.5, 2)),
  ],
  wordSpacing: 0.5,
);
const TextStyle mainTitleWhite = TextStyle(
  fontFamily: "DG Sahabah Bold",
  fontSize: 32,
  fontWeight: FontWeight.w500,
  color: Colors.white,
  letterSpacing: 0.15,
  wordSpacing: 0.5,
);
const TextStyle mainStyleTWM = TextStyle(
  fontFamily: "DG Sahabah Bold",
  fontSize: 24,
  fontWeight: FontWeight.w100,
  color: Colors.white,
  letterSpacing: 0.2,
  wordSpacing: 0.5,
);
const TextStyle mainStyleTMBL = TextStyle(
  fontFamily: "DG Sahabah Bold",
  fontSize: 24,
  fontWeight: FontWeight.w100,
  color: Colors.black87,
  letterSpacing: 0.2,
  wordSpacing: 0.5,
);
const TextStyle mainStyleTMBU = TextStyle(
  fontFamily: "DG Sahabah Bold",
  fontSize: 20,
  fontWeight: FontWeight.w100,
  color: Colors.black54,
  letterSpacing: 0.2,
  wordSpacing: 0.5,
);
const TextStyle mainStyleLBB = TextStyle(
  fontFamily: "DG Sahabah Bold",
  fontSize: 14,
  color: Colors.black54,
  fontWeight: FontWeight.w300,
);
const TextStyle mainStyleLBb = TextStyle(
  fontFamily: "DG Sahabah Bold",
  fontSize: 14,
  color: Colors.blueAccent,
  fontWeight: FontWeight.w300,
);
const TextStyle mainStyleLBW = TextStyle(
  fontFamily: "DG Sahabah Bold",
  fontSize: 16,
  color: Colors.white,
  fontWeight: FontWeight.w300,
);
const TextStyle mainStyleLBB2 = TextStyle(
  fontFamily: "DG Sahabah Bold",
  fontSize: 14,
  color: Colors.black87,
  fontWeight: FontWeight.w600,
);
const TextStyle mainStyleLableSmall = TextStyle(
  fontFamily: "DG Sahabah Bold",
  fontSize: 14,
  color: Colors.black54,
  fontWeight: FontWeight.w300,
);
const TextStyle mainStyleLW = TextStyle(
  fontFamily: "DG Sahabah Bold",
  fontSize: 14,
  color: Colors.white,
  fontWeight: FontWeight.w300,
);
const TextStyle mainStyleTR = TextStyle(
  fontFamily: "DG Sahabah Bold",
  fontSize: 14,
  color: Colors.red,
  fontWeight: FontWeight.w300,
);
const TextStyle timerStyle = TextStyle(
    fontFamily: "DG Sahabah Bold", letterSpacing: 2, color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold);

/// Dialogs ==========================================================================
showSnackBarRed() {
  Get.snackbar(
    'شكلو الباك إند ديفلوبر ماأفطر اليوم 😂  ',
    'مشكلة بالسيرفر',
    duration: const Duration(milliseconds: 2000),
    colorText: Colors.white,
    backgroundColor: Colors.red,
    snackPosition: SnackPosition.BOTTOM,
  );
}

showSnackBarError() {
  Get.snackbar(
    '😫',
    'تأكد من الكود',
    duration: const Duration(milliseconds: 2000),
    colorText: Colors.white,
    backgroundColor: Colors.red,
    snackPosition: SnackPosition.BOTTOM,
  );
}

showTryAgainDialog() {
  return Get.defaultDialog(
    title: "Wrong Answer 😰",
    barrierDismissible: false,
    content: const Flexible(child: Text(" حاول مرة أخرى")),
    titleStyle: mainTitleBlack,
    backgroundColor: Colors.white,
    confirm: TextButton(
      style: TextButton.styleFrom(backgroundColor: Colors.white),
      onPressed: () async {
        Get.offAllNamed(ControlView.routeName); //todo 1
      },
      child: const Text(
        "المحاولة مرة أخرى",
        style: mainStyleLBB,
      ),
    ),
  );
}

showEndTimeDialog() {
  return Get.defaultDialog(
    title: "Time is Over 😭",
    barrierDismissible: false,
    content: const Flexible(child: Text("إنتهى الوقت حاول مرة أخرى")),
    titleStyle: mainTitleBlack,
    backgroundColor: Colors.white,
    confirm: TextButton(
      style: TextButton.styleFrom(backgroundColor: Colors.white),
      onPressed: () async {
        Get.offAllNamed(ControlView.routeName); // todo 1
      },
      child: const Text(
        "المحاولة مرة أخرى",
        style: mainStyleLBB,
      ),
    ),
  );
}

/// Widgets =====================================================================================
Widget SPACEV10 = const SizedBox(
  height: 10,
);
Widget SPACEV16 = const SizedBox(
  height: 16,
);
Widget SPACEH10 = const SizedBox(
  width: 10,
);
Widget SPACEH100 = const SizedBox(
  width: 100,
);
Widget SPACEH50 = const SizedBox(
  width: 50,
);
Widget SPACEV100 = const SizedBox(
  height: 100,
);
Widget SPACEV50 = const SizedBox(
  height: 50,
);
Widget SPACEV200 = const SizedBox(
  height: 200,
);
