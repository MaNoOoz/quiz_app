import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../Widgets/Common/SharedWidgets.dart';
import '../../utili/Constants.dart';
import '../controllers/leaderboard_controller.dart';

class LeaderboardView extends GetView<LeaderboardController> {
  const LeaderboardView({Key? key}) : super(key: key);
  static const String routeName = Routes.LEADERBOARD;

  @override
  Widget build(BuildContext context) {
    var c = Get.put(LeaderboardController());

    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: ListView(
              children: [
                SharedWidgets().buildTextLeft("المتصدرين", mainTitleBlack),
                SPACEV10,
                SPACEV10,
                SPACEV10,
                Container(
                  color: Colors.white,
                  // height: 400,
                  child: Obx(() {
                    return Expanded(
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: c.listOfUsers.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          var name = c.listOfUsers[index]['name'];
                          var score = c.listOfUsers[index]['score'];

                          return _buildItem(name, index, score);
                        },
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildItem(name, int index, score) {
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
                    style: mainStyleLBB2,
                  ),
                  SPACEV10,
                  Text("💪 ${(score).toString()}"),
                ],
              ),
            ),
            Text("# ${(index + 1).toString()}"),
          ],
        ),
      ),
    );
  }
}
