import 'package:flutter/material.dart';

import '../../utili/Constants.dart';

class CountdownTimer extends StatelessWidget {
  const CountdownTimer({Key? key, required this.time}) : super(key: key);

  final String time;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Row(
        children: [
          // Image.asset(
          //   'assets/images/timer.gif',
          //   height: 50,
          //   // color: Colors.deepOrangeAccent,
          // ),
          SPACEH10,
          Text(
            time,
            style: mainStyleTW,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
