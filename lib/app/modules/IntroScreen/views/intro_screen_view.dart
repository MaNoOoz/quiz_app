import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Widgets/Common/SharedWidgets.dart';
import '../../onBorading/views/on_borading_view.dart';
import '../controllers/intro_screen_controller.dart';

class IntroScreenView extends GetView<IntroScreenController> {
  const IntroScreenView({Key? key}) : super(key: key);

  Widget errorView(AsyncSnapshot<Object?> snapshot) {
    return Scaffold(body: Center(child: Text('Error: ${snapshot.error}')));
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
                return SharedWidgets().buildLoading();
              } else if (snapshot.hasError) {
                return errorView(snapshot);
              } else {
                return const OnBoradingView();
              }
            });
      },
    );
  }

// Widget buildLoading() {
//   return SafeArea(
//     child: Material(
//       child: Scaffold(
//           body: Container(
//               color: Colors.black,
//               child: Column(
//                 children: [
//                   SPACEV10,
//                   SPACEV10,
//                   SharedWidgets().buildLogo(),
//                   SPACEV10,
//                   SPACEV10,
//                   // Center(child: SharedWidgets().buildLoading()),
//                 ],
//               ))),
//     ),
//   );
// }
}
