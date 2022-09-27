import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/app/modules/utili/Constants.dart';

import '../../../routes/app_pages.dart';
import '../../Widgets/Common/SharedWidgets.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  static const String routeName = Routes.HOME;

  @override
  Widget build(BuildContext context) {
    var c = Get.put(HomeController());

    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await c.getUserName();
          },
        ),
        body: Container(
          color: Colors.white,
          height: double.infinity,
          // decoration: const BoxDecoration(
          //   gradient: LinearGradient(
          //     begin: Alignment.bottomCenter,
          //     end: Alignment.topRight,
          //     colors: GradientColors.white,
          //     // stops: [0.6, 0.7],
          //   ),
          // ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: Get.height - 120,
                child: Stack(
                  children: [
                    ListView(
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        SPACEV50,
                        Align(alignment: AlignmentDirectional.topCenter, child: SharedWidgets().buildLogo()),
                        SPACEV50,
                        Obx(() {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SharedWidgets().buildTextRight("👋  Hey", mainStyleTMBL, align: TextAlign.center),
                              SPACEH10,
                              SharedWidgets().buildTextLeft("${c.userName.value.toUpperCase()}", mainTitleBlue,
                                  align: TextAlign.center),
                            ],
                          );
                        }),
                        SPACEV50,
                        SizedBox(
                          width: Get.width,
                          child: DefaultTextStyle(
                            textAlign: TextAlign.center,
                            style: mainTitleBlack,
                            child: Center(
                              child: AnimatedTextKit(
                                animatedTexts: [
                                  // TyperAnimatedText('👋  Hey , ', textAlign: TextAlign.center),
                                  TyperAnimatedText('Ready to Test You knowledge??', textAlign: TextAlign.center),
                                  TyperAnimatedText('and challenge Others!!', textAlign: TextAlign.center),
                                  TyperAnimatedText('Answer as much questions as u can in 2 minutes',
                                      textAlign: TextAlign.center),
                                ],
                                onTap: () {
                                  print("Tap Event");
                                },
                                totalRepeatCount: 1,
                                pause: Duration(seconds: 2),
                                // repeatForever: true,
                                stopPauseOnTap: true,
                              ),
                            ),
                          ),
                        ),
                        SPACEV50,
                      ],
                    ),
                    Align(
                        alignment: AlignmentDirectional.bottomCenter,
                        child: SharedWidgets().buildRequestBtn("Quiz Me ! 🤞", mainStyleTWM, onPressed: () async {
                          c.startGame();
                        })),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
