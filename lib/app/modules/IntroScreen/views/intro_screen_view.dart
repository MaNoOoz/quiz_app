import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../onBorading/views/on_borading_view.dart';
import '../controllers/intro_screen_controller.dart';

class IntroScreenView extends GetView<IntroScreenController> {
  const IntroScreenView({Key? key}) : super(key: key);

  Widget errorView(AsyncSnapshot<Object?> snapshot) {
    return Scaffold(body: Center(child: Text('Error: ${snapshot.error}')));
  }

  Widget waitingView() {
    return Scaffold(
        body: Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: CircularProgressIndicator(),
          ),
          Text('Loading...'),
        ],
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    var c = Get.put(IntroScreenController());

    return GetBuilder<IntroScreenController>(
      builder: (logic) {
        return FutureBuilder(
            future: c.init(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return waitingView();
              } else if (snapshot.hasError) {
                return errorView(snapshot);
              } else {
                return const OnBoradingView();
              }
            });
      },
    );
  }
}
