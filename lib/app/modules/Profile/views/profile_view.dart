import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:quiz_app/app/data/models/GameModel.dart';

import '../../Widgets/Common/SharedWidgets.dart';
import '../../utili/Constants.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var c = Get.put(ProfileController());
    Logger().d("build  ProfileView : ${c.userScoresList.length}");

    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await c.getUsersScores();
          },
        ), //todo remove:
        body: Container(
          // color: Colors.white,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomRight,
              colors: GradientColors.octoberSilence,
              // stops: [0.6, 0.7],
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                buildTop(),
                // SPACEV10,
                SPACEV10,
                buildUserInfo(c),
                // Container(
                //   padding: EdgeInsets.all(16),
                //   width: double.infinity,
                //   decoration: BoxDecoration(
                //     borderRadius: const BorderRadius.all(Radius.circular(12)),
                //     // border: Border.all(color: Colors.grey.withOpacity(0.5)),
                //     // color: Colors.cyan.withOpacity(0.9),
                //   ),
                //   child: Column(children: [
                //     Obx(() {}),
                //     SPACEV10,
                //   ]),
                // ),
                SPACEV10,
                SPACEV50,
                SharedWidgets().buildTextLeft("النتائج السابقة", mainStyleTWM),
                SPACEV10,

                Card(
                  color: Colors.transparent,
                  child: Container(
                    color: Colors.transparent,
                    height: 300,
                    child: Obx(() {
                      var _scoreList = ListView.builder(
                        itemCount: c.userScoresList.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          var model = c.userScoresList[index];
                          Logger().d("userScoresList : ${c.userScoresList.length}");
                          Logger().d("model : ${model.numberOfGames}");

                          return _buildItem(c.name.value, index, model);
                        },
                      ).obs;

                      return c.isPlayed.value
                          ? _scoreList.value
                          : Center(
                              child: const Text(
                                "No Games Yet 😫",
                                style: mainStyleTMBU,
                              ),
                            );
                      ;
                    }),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildUserInfo(ProfileController c) {
    return Card(
      elevation: 1,
      color: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(16),
        child: Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              child: Image.network(
                "https://picsum.photos/150/150",
                height: 90,
                fit: BoxFit.fill,
              ),
            ),
            Spacer(),
            Container(
              // margin: EdgeInsets.only(left: 16),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SharedWidgets()
                      .buildTextLeft("${c.name.value.toUpperCase()}", mainTitleWhite, align: TextAlign.center),
                  SharedWidgets().buildTextLeft("${c.mobile.value}", mainStyleLBW, align: TextAlign.center),
                ],
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(name, int index, GameModel model) {
    return FadeOutUp(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                height: 56,
                width: 56,
                color: ([...Colors.primaries]..shuffle()).first,
                child: Center(
                  child: Text(
                    name.toString().characters.first.toUpperCase(),
                    style: mainStyleTWM,
                  ),
                ),
              ),
            ),
            SPACEH10,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${name}",
                    style: mainStyleTMBU,
                  ),
                  SPACEV10,
                ],
              ),
            ),
            Text("Score : ${model.score}"),
          ],
        ),
      ),
    );
  }

  Widget buildTop() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Spacer(),
        SharedWidgets().buildIconWithText(
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
            text: "",
            onPressed: () async {
              await controller.logOUt();
            }),
      ],
    );
  }
}
