import 'package:flutter/material.dart';

// API =================================================================================================
const userToken =
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NSwiaWF0IjoxNjYzMzU4NDY1fQ.LlVAcArd2Bn3gtdanoHlfMOsHn0gRMqvVHozUk4bjWM";
const BASE_URL = "https://quizu.okoul.com/";
const headers = {
  'Content-Type': 'application/json',
  "Accept": "application/json",
  "Access-Control_Allow_Origin": "*",
  "Authorization": "Bearer $userToken",
};

// STYLE =================================================================================================
const TextStyle mainStyleTB = TextStyle(
  fontFamily: "DG Sahabah Bold",
  fontSize: 28,
  fontWeight: FontWeight.w800,
  color: Colors.black,
);
const TextStyle mainStyleTW =
    TextStyle(fontFamily: "DG Sahabah Bold", fontSize: 34, fontWeight: FontWeight.w800, color: Colors.white);
const TextStyle mainStyleTM =
    TextStyle(fontFamily: "DG Sahabah Bold", fontSize: 24, fontWeight: FontWeight.w800, color: Colors.white);
const TextStyle mainStyleTMBL =
    TextStyle(fontFamily: "DG Sahabah Bold", fontSize: 24, fontWeight: FontWeight.w800, color: Colors.black54);
const TextStyle mainStyleLB = TextStyle(fontFamily: "DG Sahabah Bold", fontSize: 14, color: Colors.black87);
const TextStyle mainStyleLW = TextStyle(fontFamily: "DG Sahabah Bold", fontSize: 14, color: Colors.white);
TextStyle timerStyle = const TextStyle(
    fontFamily: "DG Sahabah Bold", letterSpacing: 2, color: Colors.white, fontSize: 60, fontWeight: FontWeight.bold);

Widget SPACEV10 = const SizedBox(
  height: 10,
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
Widget SPACEV200 = const SizedBox(
  height: 200,
);

InputDecoration textFieldDecorationCircle({String? hint, String? lable, Icon? icon, TextStyle? style}) {
  style = mainStyleTB;
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
