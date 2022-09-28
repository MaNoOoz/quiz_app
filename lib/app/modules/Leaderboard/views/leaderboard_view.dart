import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/UserResponseModel.dart';
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
                    var q = Expanded(
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: c.allUsers.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          var model = c.allUsers[index];
                          return _buildItem(model: model, index: index);
                        },
                      ),
                    ).obs;
                    return q.value;
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildItem({required int index, required UserModel model}) {
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
                    model.name.toString().characters.first.toUpperCase(),
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
                    "${model.name}",
                    style: mainStyleLBB2,
                  ),
                  SPACEV10,
                  Text("💪 ${(model.score).toString()}"),
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
