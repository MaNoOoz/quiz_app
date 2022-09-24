import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class SharedWidgets {
  Widget buildLogo() {
    return FadeInDown(
      child: Image.asset(
        'assets/images/ideas.png',
        fit: BoxFit.cover,
        width: 280,
      ),
    );
  }

  Widget buildCustomAppbar({required VoidCallback onPressed}) {
    return FadeInDown(
      child: Container(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              icon: Icon(Icons.close),
              onPressed: onPressed,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildGif() {
    return FadeInDown(
      child: Image.asset(
        'assets/images/ideas.png',
        fit: BoxFit.cover,
        width: 280,
      ),
    );
  }

  Widget buildDesc(description) {
    return FadeInDown(
      duration: Duration(milliseconds: 500),
      delay: const Duration(milliseconds: 200),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20),
        child: Text(
          '$description',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: Colors.grey.shade500, height: 1.5),
        ),
      ),
    );
  }

  Widget buildTextLeft(text, style) {
    return FadeInLeft(
      delay: const Duration(milliseconds: 600),
      child: Text(
        "$text",
        style: style,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget buildTextRight(text, style) {
    return FadeInRight(
      delay: const Duration(milliseconds: 600),
      child: Text(
        "$text",
        style: style,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget buildTextTop(text, style) {
    return FadeInUp(
      delay: const Duration(milliseconds: 600),
      child: Text(
        "$text",
        style: style,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget buildTextDown(text, style) {
    return FadeInDown(
      delay: const Duration(milliseconds: 600),
      child: Text(
        "$text",
        style: style,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget buildShareBtn(text, style, {required VoidCallback onPressed}) {
    return FadeInUp(
      delay: const Duration(milliseconds: 600),
      child: ElevatedButton.icon(
        // minWidth: double.infinity,
        icon: Icon(
          Icons.share_sharp,
          size: 24.0,
          color: Colors.white,
        ),
        onPressed: onPressed,
        // color: Colors.black,
        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        // padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        label: Text(
          "$text",
          style: style,
        ),
      ),
    );
  }

  Widget buildRequestBtn(text, style, {required VoidCallback onPressed}) {
    return FadeInDown(
      delay: const Duration(milliseconds: 600),
      child: MaterialButton(
        minWidth: double.infinity,
        onPressed: onPressed,
        color: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        child: Text(
          "$text",
          style: style,
        ),
      ),
    );
  }
}
